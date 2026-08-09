package com.sekai.memory.book.control;

import com.sekai.memory.book.model.Anime;
import com.sekai.memory.book.model.CharacterFavorite;
import com.sekai.memory.book.model.Quote;
import com.sekai.memory.book.model.User;
import com.sekai.memory.book.service.AnimeService;
import com.sekai.memory.book.service.CharacterFavoriteService;
import com.sekai.memory.book.service.QuoteService;
import com.sekai.memory.book.util.UploadPathUtil;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Locale;
import java.util.UUID;

@Controller
public class MemoryControl {

    private static final int FREE_ANIME_LIMIT = 50;
    private static final int FREE_CHARACTER_LIMIT = 20;
    private static final int FREE_QUOTE_LIMIT = 30;

    @Resource
    private AnimeService animeService;

    @Resource
    private CharacterFavoriteService characterFavoriteService;

    @Resource
    private QuoteService quoteService;

    @PostMapping("/anime/add")
    public String addAnime(Anime anime,
                           HttpSession session,
                           RedirectAttributes redirectAttributes,
                           @RequestParam(value = "returnTo", required = false) String returnTo) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.isPro() && animeService.countByUserId(user.getId(), null) >= FREE_ANIME_LIMIT) {
            redirectAttributes.addFlashAttribute("error", "免费版最多记录 " + FREE_ANIME_LIMIT + " 部番剧，开通 Pro 后可继续添加");
            return "redirect:/pro";
        }
        anime.setUserId(user.getId());
        boolean success = animeService.add(anime);
        redirectAttributes.addFlashAttribute(success ? "message" : "error",
                success ? "番剧已经加入回忆档案" : "番剧名称不能为空");
        return redirectTo(returnTo, "/anime");
    }

    @PostMapping("/import/screenshot")
    public String importScreenshot(@RequestParam("screenshot") MultipartFile screenshot,
                                   Anime anime,
                                   @RequestParam(value = "recognizedText", required = false) String recognizedText,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.isPro()) {
            redirectAttributes.addFlashAttribute("error", "截图导入是 Pro 功能，开通后可上传截图并一键加入回忆录");
            return "redirect:/pro";
        }
        anime.setUserId(user.getId());
        if (anime.getStatus() == null || anime.getStatus().isBlank()) {
            anime.setStatus("看完");
        }
        if ((anime.getMemoryText() == null || anime.getMemoryText().isBlank())
                && recognizedText != null && !recognizedText.isBlank()) {
            anime.setMemoryText("截图导入：" + recognizedText.trim());
        }
        String screenshotUrl = saveScreenshot(screenshot);
        if (screenshotUrl != null && (anime.getCoverUrl() == null || anime.getCoverUrl().isBlank())) {
            anime.setCoverUrl(screenshotUrl);
        }
        boolean success = animeService.add(anime);
        redirectAttributes.addFlashAttribute(success ? "message" : "error",
                success ? "截图记录已加入番剧回忆录" : "番剧标题不能为空，截图导入未完成");
        return success ? "redirect:/anime" : "redirect:/import/screenshot";
    }

    @PostMapping("/anime/update/{id}")
    public String updateAnime(@PathVariable Long id,
                              Anime anime,
                              HttpSession session,
                              RedirectAttributes redirectAttributes,
                              @RequestParam(value = "returnTo", required = false) String returnTo) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        anime.setId(id);
        boolean success = animeService.update(anime, user.getId());
        redirectAttributes.addFlashAttribute(success ? "message" : "error",
                success ? "番剧记录已更新" : "番剧名称不能为空，或记录不存在");
        return redirectTo(returnTo, "/anime");
    }

    @PostMapping("/anime/delete/{id}")
    public String deleteAnime(@PathVariable Long id,
                              HttpSession session,
                              @RequestParam(value = "returnTo", required = false) String returnTo) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        animeService.delete(id, user.getId());
        return redirectTo(returnTo, "/anime");
    }

    @PostMapping("/characters/add")
    public String addCharacter(CharacterFavorite characterFavorite,
                               HttpSession session,
                               RedirectAttributes redirectAttributes,
                               @RequestParam(value = "returnTo", required = false) String returnTo) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.isPro() && characterFavoriteService.countByUserId(user.getId()) >= FREE_CHARACTER_LIMIT) {
            redirectAttributes.addFlashAttribute("error", "免费版最多收藏 " + FREE_CHARACTER_LIMIT + " 个角色，开通 Pro 后可继续添加");
            return "redirect:/pro";
        }
        characterFavorite.setUserId(user.getId());
        boolean success = characterFavoriteService.add(characterFavorite);
        redirectAttributes.addFlashAttribute(success ? "message" : "error",
                success ? "角色已经加入收藏" : "角色名称不能为空");
        return redirectTo(returnTo, "/characters");
    }

    @PostMapping("/characters/delete/{id}")
    public String deleteCharacter(@PathVariable Long id,
                                  HttpSession session,
                                  @RequestParam(value = "returnTo", required = false) String returnTo) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        characterFavoriteService.delete(id, user.getId());
        return redirectTo(returnTo, "/characters");
    }

    @PostMapping("/characters/update/{id}")
    public String updateCharacter(@PathVariable Long id,
                                  CharacterFavorite characterFavorite,
                                  HttpSession session,
                                  RedirectAttributes redirectAttributes,
                                  @RequestParam(value = "returnTo", required = false) String returnTo) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        characterFavorite.setId(id);
        boolean success = characterFavoriteService.update(characterFavorite, user.getId());
        redirectAttributes.addFlashAttribute(success ? "message" : "error",
                success ? "角色记录已更新" : "角色名称不能为空，或记录不存在");
        return redirectTo(returnTo, "/characters");
    }

    @PostMapping("/quotes/add")
    public String addQuote(Quote quote,
                           @RequestParam(value = "videoFile", required = false) MultipartFile videoFile,
                           HttpSession session,
                           RedirectAttributes redirectAttributes,
                           @RequestParam(value = "returnTo", required = false) String returnTo) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.isPro() && quoteService.countByUserId(user.getId()) >= FREE_QUOTE_LIMIT) {
            redirectAttributes.addFlashAttribute("error", "免费版最多摘录 " + FREE_QUOTE_LIMIT + " 条台词，开通 Pro 后可继续添加");
            return "redirect:/pro";
        }
        quote.setUserId(user.getId());
        quote.setVideoUrl(resolveQuoteVideoUrl(quote.getVideoUrl(), videoFile));
        boolean success = quoteService.add(quote);
        redirectAttributes.addFlashAttribute(success ? "message" : "error",
                success ? "台词已经收进记忆本" : "台词内容不能为空");
        return redirectTo(returnTo, "/quotes");
    }

    @PostMapping("/quotes/delete/{id}")
    public String deleteQuote(@PathVariable Long id,
                              HttpSession session,
                              @RequestParam(value = "returnTo", required = false) String returnTo) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        quoteService.delete(id, user.getId());
        return redirectTo(returnTo, "/quotes");
    }

    @PostMapping("/quotes/update/{id}")
    public String updateQuote(@PathVariable Long id,
                              Quote quote,
                              @RequestParam(value = "videoFile", required = false) MultipartFile videoFile,
                              HttpSession session,
                              RedirectAttributes redirectAttributes,
                              @RequestParam(value = "returnTo", required = false) String returnTo) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        quote.setId(id);
        quote.setVideoUrl(resolveQuoteVideoUrl(quote.getVideoUrl(), videoFile));
        boolean success = quoteService.update(quote, user.getId());
        redirectAttributes.addFlashAttribute(success ? "message" : "error",
                success ? "台词记录已更新" : "台词内容不能为空，或记录不存在");
        return redirectTo(returnTo, "/quotes");
    }

    private User getLoginUser(HttpSession session) {
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser instanceof User user) {
            return user;
        }
        return null;
    }

    private String redirectTo(String returnTo, String fallback) {
        if (returnTo != null && returnTo.startsWith("/") && !returnTo.startsWith("//")) {
            return "redirect:" + returnTo;
        }
        return "redirect:" + fallback;
    }

    private String resolveQuoteVideoUrl(String submittedUrl, MultipartFile videoFile) {
        String uploadedUrl = saveQuoteVideo(videoFile);
        return uploadedUrl == null ? submittedUrl : uploadedUrl;
    }

    private String saveQuoteVideo(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            return null;
        }
        String originalName = file.getOriginalFilename();
        String suffix = ".mp4";
        if (originalName != null && originalName.lastIndexOf('.') >= 0) {
            suffix = originalName.substring(originalName.lastIndexOf('.')).toLowerCase(Locale.ROOT);
        }
        if (!suffix.matches("\\.(mp4|webm|ogg|mov|m4v)$")) {
            return null;
        }
        try {
            Path dir = UploadPathUtil.quoteVideoRoot();
            Files.createDirectories(dir);
            Path target = dir.resolve(UUID.randomUUID() + suffix);
            file.transferTo(target);
            return "/uploads/quote-videos/" + target.getFileName();
        } catch (IOException ex) {
            return null;
        }
    }

    private String saveScreenshot(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            return null;
        }
        String originalName = file.getOriginalFilename();
        String suffix = ".jpg";
        if (originalName != null && originalName.lastIndexOf('.') >= 0) {
            suffix = originalName.substring(originalName.lastIndexOf('.')).toLowerCase(Locale.ROOT);
        }
        if (!suffix.matches("\\.(jpg|jpeg|png|webp)$")) {
            suffix = ".jpg";
        }
        try {
            Path dir = UploadPathUtil.screenshotRoot();
            Files.createDirectories(dir);
            Path target = dir.resolve(UUID.randomUUID() + suffix);
            file.transferTo(target);
            return "/uploads/screenshots/" + target.getFileName();
        } catch (IOException ex) {
            return null;
        }
    }
}
