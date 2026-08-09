package com.sekai.memory.book.control;

import com.sekai.memory.book.model.Result;
import org.springframework.http.CacheControl;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.net.URLConnection;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.Duration;
import java.util.Arrays;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

@Controller
public class ImageControl {

    private static final int MAX_PROXY_IMAGE_BYTES = 8 * 1024 * 1024;

    @GetMapping("/image/proxy")
    public ResponseEntity<byte[]> proxy(@RequestParam("url") String url) {
        URI uri = parseRemoteImageUri(url);
        if (uri == null) {
            return ResponseEntity.badRequest().build();
        }
        try {
            URLConnection connection = uri.toURL().openConnection();
            connection.setConnectTimeout(8000);
            connection.setReadTimeout(16000);
            connection.setRequestProperty("User-Agent",
                    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
                            + "(KHTML, like Gecko) Chrome/126.0 Safari/537.36");
            connection.setRequestProperty("Accept", "image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8");
            connection.setRequestProperty("Accept-Language", "zh-CN,zh;q=0.9,en;q=0.8");
            connection.setRequestProperty("Referer", uri.getScheme() + "://" + uri.getHost() + "/");

            byte[] bytes;
            try (InputStream input = connection.getInputStream()) {
                bytes = input.readNBytes(MAX_PROXY_IMAGE_BYTES + 1);
            }
            if (bytes.length > MAX_PROXY_IMAGE_BYTES) {
                return ResponseEntity.status(413).build();
            }
            MediaType mediaType = resolveMediaType(connection.getContentType(), uri.getPath(), bytes);
            if (!"image".equals(mediaType.getType())) {
                return ResponseEntity.status(415).build();
            }
            return ResponseEntity.ok()
                    .contentType(mediaType)
                    .cacheControl(CacheControl.maxAge(Duration.ofHours(6)).cachePublic())
                    .body(bytes);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().build();
        } catch (IOException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping(value = "/image/cache", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Result<Map<String, Object>> cache(@RequestParam("url") String url) {
        if (url == null || url.isBlank() || !url.startsWith("http")) {
            return fail("Invalid image URL.");
        }
        try {
            URI uri = URI.create(url.trim());
            URLConnection connection = uri.toURL().openConnection();
            connection.setConnectTimeout(8000);
            connection.setReadTimeout(16000);
            connection.setRequestProperty("User-Agent", "SekaiMemoryBook/1.0");

            String contentType = connection.getContentType();
            String extension = resolveExtension(contentType, uri.getPath());
            Path dir = Path.of("uploads", "images");
            Files.createDirectories(dir);
            Path file = dir.resolve(UUID.randomUUID() + extension);

            try (InputStream input = connection.getInputStream()) {
                Files.copy(input, file);
            }

            BufferedImage image = ImageIO.read(file.toFile());
            if (image == null) {
                Files.deleteIfExists(file);
                return fail("The URL did not return a readable image.");
            }
            int width = image.getWidth();
            int height = image.getHeight();
            double ratio = height == 0 ? 0 : width / (double) height;
            String advice = ratio >= 1.45 ? "Wallpaper / wide banner"
                    : ratio >= 0.7 ? "Cover / share card"
                    : "Portrait / character art";
            String localUrl = "/uploads/images/" + file.getFileName();
            return success(Map.of(
                    "url", localUrl,
                    "width", width,
                    "height", height,
                    "ratio", String.format(Locale.ROOT, "%.2f", ratio),
                    "advice", advice
            ));
        } catch (IllegalArgumentException e) {
            return fail("Malformed image URL.");
        } catch (IOException e) {
            return fail("Download failed: " + e.getMessage());
        }
    }

    private Result<Map<String, Object>> success(Map<String, Object> data) {
        Result<Map<String, Object>> result = new Result<>();
        result.setSuccess(true);
        result.setCode("SUCCESS");
        result.setMessage("OK");
        result.setData(data);
        return result;
    }

    private Result<Map<String, Object>> fail(String message) {
        Result<Map<String, Object>> result = new Result<>();
        result.setSuccess(false);
        result.setCode("FAIL");
        result.setMessage(message);
        return result;
    }

    private URI parseRemoteImageUri(String url) {
        if (url == null || url.isBlank()) {
            return null;
        }
        try {
            URI uri = URI.create(url.trim());
            String scheme = uri.getScheme();
            if (scheme == null || uri.getHost() == null) {
                return null;
            }
            String lowerScheme = scheme.toLowerCase(Locale.ROOT);
            return ("http".equals(lowerScheme) || "https".equals(lowerScheme)) ? uri : null;
        } catch (IllegalArgumentException e) {
            return null;
        }
    }

    private MediaType resolveMediaType(String contentType, String path, byte[] bytes) {
        if (contentType != null) {
            String lowerContentType = contentType.toLowerCase(Locale.ROOT);
            if (lowerContentType.startsWith("image/")) {
                try {
                    return MediaType.parseMediaType(contentType);
                } catch (IllegalArgumentException ignored) {
                    return MediaType.APPLICATION_OCTET_STREAM;
                }
            }
        }
        MediaType mediaType = detectMediaType(bytes);
        if (mediaType != null) {
            return mediaType;
        }
        String lowerPath = path == null ? "" : path.toLowerCase(Locale.ROOT);
        if (lowerPath.endsWith(".png")) {
            return MediaType.IMAGE_PNG;
        }
        if (lowerPath.endsWith(".webp")) {
            return MediaType.parseMediaType("image/webp");
        }
        if (lowerPath.endsWith(".gif")) {
            return MediaType.IMAGE_GIF;
        }
        if (lowerPath.endsWith(".svg")) {
            return MediaType.parseMediaType("image/svg+xml");
        }
        return MediaType.IMAGE_JPEG;
    }

    private MediaType detectMediaType(byte[] bytes) {
        if (bytes == null || bytes.length < 4) {
            return null;
        }
        if ((bytes[0] & 0xFF) == 0xFF && (bytes[1] & 0xFF) == 0xD8 && (bytes[2] & 0xFF) == 0xFF) {
            return MediaType.IMAGE_JPEG;
        }
        byte[] pngSignature = new byte[] {(byte) 0x89, 'P', 'N', 'G'};
        if (bytes.length >= pngSignature.length && Arrays.equals(Arrays.copyOf(bytes, pngSignature.length), pngSignature)) {
            return MediaType.IMAGE_PNG;
        }
        if (bytes.length >= 6
                && bytes[0] == 'G' && bytes[1] == 'I' && bytes[2] == 'F'
                && bytes[3] == '8' && (bytes[4] == '7' || bytes[4] == '9') && bytes[5] == 'a') {
            return MediaType.IMAGE_GIF;
        }
        if (bytes.length >= 12
                && bytes[0] == 'R' && bytes[1] == 'I' && bytes[2] == 'F' && bytes[3] == 'F'
                && bytes[8] == 'W' && bytes[9] == 'E' && bytes[10] == 'B' && bytes[11] == 'P') {
            return MediaType.parseMediaType("image/webp");
        }
        String prefix = new String(bytes, 0, Math.min(bytes.length, 256), java.nio.charset.StandardCharsets.UTF_8)
                .trim()
                .toLowerCase(Locale.ROOT);
        if (prefix.startsWith("<svg") || prefix.contains("<svg")) {
            return MediaType.parseMediaType("image/svg+xml");
        }
        return null;
    }

    private String resolveExtension(String contentType, String path) {
        if (contentType != null) {
            if (contentType.contains("png")) {
                return ".png";
            }
            if (contentType.contains("webp")) {
                return ".webp";
            }
            if (contentType.contains("gif")) {
                return ".gif";
            }
        }
        String lowerPath = path == null ? "" : path.toLowerCase(Locale.ROOT);
        if (lowerPath.endsWith(".png")) {
            return ".png";
        }
        if (lowerPath.endsWith(".webp")) {
            return ".webp";
        }
        if (lowerPath.endsWith(".gif")) {
            return ".gif";
        }
        return ".jpg";
    }
}
