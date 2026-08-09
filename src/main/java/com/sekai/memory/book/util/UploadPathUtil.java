package com.sekai.memory.book.util;

import com.sekai.memory.book.SekaiMemoryBookApplication;

import java.net.URI;
import java.nio.file.Path;

public final class UploadPathUtil {

    private UploadPathUtil() {
    }

    public static Path uploadRoot() {
        String configured = System.getProperty("sekai.uploadRoot");
        if (configured == null || configured.isBlank()) {
            configured = System.getenv("SEKAI_UPLOAD_ROOT");
        }
        if (configured != null && !configured.isBlank()) {
            return Path.of(configured).toAbsolutePath().normalize();
        }
        return projectRoot().resolve("uploads").toAbsolutePath().normalize();
    }

    public static Path quoteVideoRoot() {
        return uploadRoot().resolve("quote-videos").toAbsolutePath().normalize();
    }

    public static Path screenshotRoot() {
        return uploadRoot().resolve("screenshots").toAbsolutePath().normalize();
    }

    private static Path projectRoot() {
        try {
            URI location = SekaiMemoryBookApplication.class.getProtectionDomain()
                    .getCodeSource()
                    .getLocation()
                    .toURI();
            Path classpathRoot = Path.of(location).toAbsolutePath().normalize();
            if (classpathRoot.endsWith(Path.of("target", "classes"))) {
                return classpathRoot.getParent().getParent();
            }
            Path fileName = classpathRoot.getFileName();
            Path parent = classpathRoot.getParent();
            if (fileName != null
                    && fileName.toString().endsWith(".jar")
                    && parent != null
                    && parent.endsWith("target")) {
                return parent.getParent();
            }
        } catch (Exception ignored) {
            // Fall back to the process working directory for unusual launchers.
        }
        return Path.of("").toAbsolutePath().normalize();
    }
}
