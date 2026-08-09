package com.sekai.memory.book.control;

import com.sekai.memory.book.model.Anime;
import com.sekai.memory.book.model.AdvancedInsights;
import com.sekai.memory.book.model.CharacterFavorite;
import com.sekai.memory.book.model.DashboardStats;
import com.sekai.memory.book.model.Quote;
import com.sekai.memory.book.model.SearchResult;
import com.sekai.memory.book.model.TimelineItem;
import com.sekai.memory.book.model.User;
import com.sekai.memory.book.model.YearlyReport;
import com.sekai.memory.book.service.AnimeService;
import com.sekai.memory.book.service.CharacterFavoriteService;
import com.sekai.memory.book.service.MembershipOrderService;
import com.sekai.memory.book.service.QuoteService;
import com.sekai.memory.book.service.UserService;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;

@Controller
public class PageControl {

    @Resource
    private AnimeService animeService;

    @Resource
    private CharacterFavoriteService characterFavoriteService;

    @Resource
    private QuoteService quoteService;

    @Resource
    private UserService userService;

    @Resource
    private MembershipOrderService membershipOrderService;

    @GetMapping({"/", "/login"})
    public String login() {
        return "login";
    }

    @GetMapping("/register")
    public String register() {
        return "register";
    }

    @GetMapping("/forgot-password")
    public String forgotPassword() {
        return "forgot-password";
    }

    @GetMapping("/user/register")
    public String registerFallback() {
        return "redirect:/register";
    }

    @GetMapping("/user/login")
    public String loginFallback() {
        return "redirect:/login";
    }

    @GetMapping("/home")
    public String home(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        addDashboard(model, user);
        return "home";
    }

    @GetMapping("/anime")
    public String anime(HttpSession session,
                        Model model,
                        @RequestParam(value = "keyword", required = false) String keyword,
                        @RequestParam(value = "page", defaultValue = "1") int page,
                        @RequestParam(value = "autoSort", defaultValue = "false") boolean autoSort) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        int pageSize = 8;
        int total = animeService.countByUserId(user.getId(), keyword);
        int totalPages = Math.max((int) Math.ceil(total / (double) pageSize), 1);
        int currentPage = Math.min(Math.max(page, 1), totalPages);
        model.addAttribute("loginUser", user);
        model.addAttribute("animeList", animeService.listByUserId(user.getId(), keyword, currentPage, pageSize));
        model.addAttribute("keyword", keyword == null ? "" : keyword);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalCount", total);
        model.addAttribute("autoSortActive", autoSort);
        return "anime";
    }

    @GetMapping("/anime/{id}")
    public String animeDetail(@PathVariable Long id, HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        Anime anime = animeService.getByIdAndUserId(id, user.getId());
        if (anime == null) {
            return "redirect:/anime";
        }
        List<CharacterFavorite> relatedCharacters = characterFavoriteService.listByUserId(user.getId()).stream()
                .filter(character -> Objects.equals(character.getAnimeId(), anime.getId()))
                .toList();
        List<Quote> relatedQuotes = quoteService.listByUserId(user.getId()).stream()
                .filter(quote -> Objects.equals(quote.getAnimeId(), anime.getId()))
                .toList();
        model.addAttribute("loginUser", user);
        model.addAttribute("anime", anime);
        model.addAttribute("tagList", splitTags(anime.getTags()));
        model.addAttribute("relatedCharacters", relatedCharacters);
        model.addAttribute("relatedQuotes", relatedQuotes);
        return "anime-detail";
    }

    @GetMapping("/characters")
    public String characters(HttpSession session,
                             Model model,
                             @RequestParam(value = "page", defaultValue = "1") int page) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        int pageSize = 8;
        int total = characterFavoriteService.countByUserId(user.getId());
        int totalPages = Math.max((int) Math.ceil(total / (double) pageSize), 1);
        int currentPage = Math.min(Math.max(page, 1), totalPages);
        List<Anime> animeOptions = animeService.listByUserId(user.getId());
        model.addAttribute("loginUser", user);
        model.addAttribute("animeOptions", animeOptions);
        model.addAttribute("animeCoverById", buildAnimeCoverById(animeOptions));
        model.addAttribute("characterList", characterFavoriteService.listByUserId(user.getId(), currentPage, pageSize));
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalCount", total);
        return "characters";
    }

    @GetMapping("/quotes")
    public String quotes(HttpSession session,
                         Model model,
                         @RequestParam(value = "page", defaultValue = "1") int page) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        int pageSize = 8;
        int total = quoteService.countByUserId(user.getId());
        int totalPages = Math.max((int) Math.ceil(total / (double) pageSize), 1);
        int currentPage = Math.min(Math.max(page, 1), totalPages);
        model.addAttribute("loginUser", user);
        model.addAttribute("animeOptions", animeService.listByUserId(user.getId()));
        model.addAttribute("quoteList", quoteService.listByUserId(user.getId(), currentPage, pageSize));
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalCount", total);
        return "quotes";
    }

    @GetMapping("/timeline")
    public String timeline(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        List<Anime> animeList = animeService.listByUserId(user.getId());
        List<CharacterFavorite> characterList = characterFavoriteService.listByUserId(user.getId());
        List<Quote> quoteList = quoteService.listByUserId(user.getId());
        model.addAttribute("loginUser", user);
        model.addAttribute("timelineItems", buildAnimeReleaseTimeline(animeList));
        model.addAttribute("stats", buildStats(animeList, characterList, quoteList));
        return "timeline";
    }

    @GetMapping("/yearly-report")
    public String yearlyReport(HttpSession session,
                               Model model,
                               @RequestParam(value = "year", required = false) Integer year) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        List<Anime> animeList = animeService.listByUserId(user.getId());
        List<CharacterFavorite> characterList = characterFavoriteService.listByUserId(user.getId());
        List<Quote> quoteList = quoteService.listByUserId(user.getId());
        int selectedYear = year == null ? LocalDate.now().getYear() : year;
        model.addAttribute("loginUser", user);
        model.addAttribute("selectedYear", selectedYear);
        model.addAttribute("availableYears", findAvailableYears(animeList, characterList, quoteList));
        model.addAttribute("report", buildYearlyReport(selectedYear, animeList, characterList, quoteList));
        return "yearly-report";
    }

    @GetMapping("/advanced")
    public String advanced(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        List<Anime> animeList = animeService.listByUserId(user.getId());
        List<CharacterFavorite> characterList = characterFavoriteService.listByUserId(user.getId());
        List<Quote> quoteList = quoteService.listByUserId(user.getId());
        model.addAttribute("loginUser", user);
        model.addAttribute("animeList", animeList);
        model.addAttribute("characterList", characterList);
        model.addAttribute("quoteList", quoteList);
        model.addAttribute("animeById", buildAnimeById(animeList));
        model.addAttribute("insights", buildAdvancedInsights(animeList, characterList, quoteList));
        return "advanced";
    }

    @GetMapping("/memory-graph")
    public String memoryGraph(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        List<Anime> animeList = animeService.listByUserId(user.getId());
        List<CharacterFavorite> characterList = characterFavoriteService.listByUserId(user.getId());
        List<Quote> quoteList = quoteService.listByUserId(user.getId());
        model.addAttribute("loginUser", user);
        model.addAttribute("stats", buildStats(animeList, characterList, quoteList));
        model.addAttribute("graphJson", buildMemoryGraphJson(animeList, characterList, quoteList));
        return "memory-graph";
    }

    @GetMapping("/pro")
    public String proCenter(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        List<Anime> animeList = animeService.listByUserId(user.getId());
        List<CharacterFavorite> characterList = characterFavoriteService.listByUserId(user.getId());
        List<Quote> quoteList = quoteService.listByUserId(user.getId());
        model.addAttribute("loginUser", user);
        model.addAttribute("stats", buildStats(animeList, characterList, quoteList));
        model.addAttribute("animeList", animeList);
        model.addAttribute("characterList", characterList);
        model.addAttribute("quoteList", quoteList);
        return "pro";
    }

    @GetMapping("/pro/checkout")
    public String proCheckout(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("loginUser", user);
        model.addAttribute("orders", membershipOrderService.listByUserId(user.getId()));
        return "pro-checkout";
    }

    @GetMapping("/pro/briefing")
    public String proBriefing(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.isPro()) {
            return "redirect:/pro";
        }
        List<Anime> animeList = animeService.listByUserId(user.getId());
        List<CharacterFavorite> characterList = characterFavoriteService.listByUserId(user.getId());
        List<Quote> quoteList = quoteService.listByUserId(user.getId());
        AdvancedInsights insights = buildAdvancedInsights(animeList, characterList, quoteList);
        List<HealthIssue> issues = buildHealthIssues(animeList, characterList, quoteList);
        model.addAttribute("loginUser", user);
        model.addAttribute("stats", buildStats(animeList, characterList, quoteList));
        model.addAttribute("insights", insights);
        model.addAttribute("nextAnime", chooseNextAnime(insights, animeList));
        model.addAttribute("issues", issues.stream().limit(8).toList());
        model.addAttribute("shareSnippets", buildShareSnippets(animeList, quoteList));
        model.addAttribute("goals", buildProGoals(animeList, characterList, quoteList, issues));
        return "pro-briefing";
    }

    @GetMapping("/pro/asset-lab")
    public String proAssetLab(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.isPro()) {
            return "redirect:/pro";
        }
        List<Anime> animeList = animeService.listByUserId(user.getId());
        List<CharacterFavorite> characterList = characterFavoriteService.listByUserId(user.getId());
        List<Quote> quoteList = quoteService.listByUserId(user.getId());
        List<ProAssetInsight> assetInsights = buildProAssetInsights(animeList, characterList, quoteList);
        model.addAttribute("loginUser", user);
        model.addAttribute("stats", buildStats(animeList, characterList, quoteList));
        model.addAttribute("assetInsights", assetInsights);
        model.addAttribute("premiumCount", assetInsights.stream().filter(item -> item.score() >= 80).count());
        model.addAttribute("fixCount", assetInsights.stream().filter(item -> !item.gaps().isEmpty()).count());
        return "pro-asset-lab";
    }

    @GetMapping("/pro/playlists")
    public String proPlaylists(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.isPro()) {
            return "redirect:/pro";
        }
        List<Anime> animeList = animeService.listByUserId(user.getId());
        List<CharacterFavorite> characterList = characterFavoriteService.listByUserId(user.getId());
        List<Quote> quoteList = quoteService.listByUserId(user.getId());
        model.addAttribute("loginUser", user);
        model.addAttribute("stats", buildStats(animeList, characterList, quoteList));
        model.addAttribute("playlists", buildProPlaylists(animeList));
        return "pro-playlists";
    }

    @GetMapping("/pro/watch-plan")
    public String proWatchPlan(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.isPro()) {
            return "redirect:/pro";
        }
        List<Anime> animeList = animeService.listByUserId(user.getId());
        List<CharacterFavorite> characterList = characterFavoriteService.listByUserId(user.getId());
        List<Quote> quoteList = quoteService.listByUserId(user.getId());
        model.addAttribute("loginUser", user);
        model.addAttribute("stats", buildStats(animeList, characterList, quoteList));
        model.addAttribute("watchPlan", buildWatchPlan(animeList));
        model.addAttribute("backlogCount", animeList.stream().filter(anime -> !isWatched(anime)).count());
        return "pro-watch-plan";
    }

    @GetMapping("/pro/calendar")
    public String proCalendar(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.isPro()) {
            return "redirect:/pro";
        }
        List<Anime> animeList = animeService.listByUserId(user.getId());
        List<CharacterFavorite> characterList = characterFavoriteService.listByUserId(user.getId());
        List<Quote> quoteList = quoteService.listByUserId(user.getId());
        List<WatchPlanDay> watchPlan = buildWatchPlan(animeList);
        model.addAttribute("loginUser", user);
        model.addAttribute("stats", buildStats(animeList, characterList, quoteList));
        model.addAttribute("watchPlan", watchPlan);
        model.addAttribute("calendarTitle", "Sekai 7 天追番日历");
        model.addAttribute("plannedEpisodes", watchPlan.stream().mapToInt(WatchPlanDay::episodes).sum());
        return "pro-calendar";
    }

    @GetMapping("/pro/batch")
    public String proBatch(HttpSession session,
                           Model model,
                           @RequestParam(value = "filter", defaultValue = "missing") String filter) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.isPro()) {
            return "redirect:/pro";
        }
        List<Anime> animeList = animeService.listByUserId(user.getId());
        List<CharacterFavorite> characterList = characterFavoriteService.listByUserId(user.getId());
        List<Quote> quoteList = quoteService.listByUserId(user.getId());
        List<Anime> candidates = filterBatchAnime(animeList, filter);
        model.addAttribute("loginUser", user);
        model.addAttribute("stats", buildStats(animeList, characterList, quoteList));
        model.addAttribute("filter", filter);
        model.addAttribute("candidates", candidates);
        model.addAttribute("batchStats", buildBatchStats(animeList));
        return "pro-batch";
    }

    @PostMapping("/pro/batch/status")
    public String batchUpdateStatus(HttpSession session,
                                    @RequestParam(value = "ids", required = false) List<Long> ids,
                                    @RequestParam("status") String status,
                                    @RequestParam(value = "filter", defaultValue = "missing") String filter) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.isPro()) {
            return "redirect:/pro";
        }
        if (ids != null && status != null && !status.isBlank()) {
            ids.forEach(id -> {
                Anime anime = animeService.getByIdAndUserId(id, user.getId());
                if (anime != null) {
                    anime.setStatus(status.trim());
                    animeService.update(anime, user.getId());
                }
            });
        }
        return "redirect:/pro/batch?filter=" + filter;
    }

    @PostMapping("/pro/batch/tags")
    public String batchAppendTag(HttpSession session,
                                 @RequestParam(value = "ids", required = false) List<Long> ids,
                                 @RequestParam("tag") String tag,
                                 @RequestParam(value = "filter", defaultValue = "missing") String filter) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.isPro()) {
            return "redirect:/pro";
        }
        if (ids != null && tag != null && !tag.isBlank()) {
            String cleanTag = tag.trim();
            ids.forEach(id -> {
                Anime anime = animeService.getByIdAndUserId(id, user.getId());
                if (anime != null) {
                    anime.setTags(appendDistinctTag(anime.getTags(), cleanTag));
                    animeService.update(anime, user.getId());
                }
            });
        }
        return "redirect:/pro/batch?filter=" + filter;
    }

    @GetMapping("/pro/duplicates")
    public String proDuplicates(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.isPro()) {
            return "redirect:/pro";
        }
        List<Anime> animeList = animeService.listByUserId(user.getId());
        List<CharacterFavorite> characterList = characterFavoriteService.listByUserId(user.getId());
        List<Quote> quoteList = quoteService.listByUserId(user.getId());
        List<DuplicateGroup> duplicateGroups = buildDuplicateGroups(animeList, characterList, quoteList);
        model.addAttribute("loginUser", user);
        model.addAttribute("stats", buildStats(animeList, characterList, quoteList));
        model.addAttribute("duplicateGroups", duplicateGroups);
        model.addAttribute("duplicateCount", duplicateGroups.stream().mapToInt(group -> group.items().size() - 1).sum());
        return "pro-duplicates";
    }

    @PostMapping("/pro/duplicates/delete")
    public String deleteDuplicates(HttpSession session,
                                   @RequestParam("type") String type,
                                   @RequestParam(value = "ids", required = false) List<Long> ids) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.isPro()) {
            return "redirect:/pro";
        }
        if (ids != null) {
            ids.forEach(id -> {
                if ("anime".equals(type)) {
                    animeService.delete(id, user.getId());
                } else if ("character".equals(type)) {
                    characterFavoriteService.delete(id, user.getId());
                } else if ("quote".equals(type)) {
                    quoteService.delete(id, user.getId());
                }
            });
        }
        return "redirect:/pro/duplicates";
    }

    @GetMapping("/pro/health")
    public String proHealth(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.isPro()) {
            return "redirect:/pro";
        }
        List<Anime> animeList = animeService.listByUserId(user.getId());
        List<CharacterFavorite> characterList = characterFavoriteService.listByUserId(user.getId());
        List<Quote> quoteList = quoteService.listByUserId(user.getId());
        List<HealthIssue> issues = buildHealthIssues(animeList, characterList, quoteList);
        int totalChecks = Math.max(animeList.size() * 5, 1);
        int healthScore = Math.max(0, 100 - (int) Math.round(issues.size() * 100.0 / totalChecks));
        model.addAttribute("loginUser", user);
        model.addAttribute("stats", buildStats(animeList, characterList, quoteList));
        model.addAttribute("issues", issues);
        model.addAttribute("healthScore", healthScore);
        return "pro-health";
    }

    @GetMapping("/pro/export/json")
    public ResponseEntity<Map<String, Object>> exportJson(HttpSession session) {
        User user = getLoginUser(session);
        if (user == null || !user.isPro()) {
            return ResponseEntity.status(403).body(Map.of("message", "Pro required"));
        }
        List<Anime> animeList = animeService.listByUserId(user.getId());
        List<CharacterFavorite> characterList = characterFavoriteService.listByUserId(user.getId());
        List<Quote> quoteList = quoteService.listByUserId(user.getId());
        return ResponseEntity.ok()
                .header("Content-Disposition", attachmentName("sekai-memory-book.json"))
                .body(Map.of(
                        "userName", user.getUserName(),
                        "exportedAt", LocalDateTime.now().toString(),
                        "animeList", animeList,
                        "characterList", characterList,
                        "quoteList", quoteList
                ));
    }

    @GetMapping("/pro/export/anime.csv")
    public void exportAnimeCsv(HttpSession session, HttpServletResponse response) throws IOException {
        User user = getLoginUser(session);
        if (user == null || !user.isPro()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Pro required");
            return;
        }
        response.setCharacterEncoding(StandardCharsets.UTF_8.name());
        response.setContentType("text/csv;charset=UTF-8");
        response.setHeader("Content-Disposition", attachmentName("sekai-anime.csv"));
        response.getWriter().write('\ufeff');
        response.getWriter().println("标题,状态,评分,类型,标签,观看日期,总集数,当前集数,备注");
        for (Anime anime : animeService.listByUserId(user.getId())) {
            response.getWriter().println(String.join(",",
                    csv(anime.getTitle()),
                    csv(anime.getStatus()),
                    csv(anime.getScore() == null ? null : anime.getScore().toString()),
                    csv(anime.getType()),
                    csv(anime.getTags()),
                    csv(anime.getWatchDate() == null ? null : anime.getWatchDate().toString()),
                    csv(anime.getTotalEpisodes() == null ? null : anime.getTotalEpisodes().toString()),
                    csv(anime.getCurrentEpisode() == null ? null : anime.getCurrentEpisode().toString()),
                    csv(anime.getMemoryText())
            ));
        }
    }

    @GetMapping("/pro/export/characters.csv")
    public void exportCharacterCsv(HttpSession session, HttpServletResponse response) throws IOException {
        User user = getLoginUser(session);
        if (user == null || !user.isPro()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Pro required");
            return;
        }
        Map<Long, Anime> animeById = buildAnimeById(animeService.listByUserId(user.getId()));
        response.setCharacterEncoding(StandardCharsets.UTF_8.name());
        response.setContentType("text/csv;charset=UTF-8");
        response.setHeader("Content-Disposition", attachmentName("sekai-characters.csv"));
        response.getWriter().write('\ufeff');
        response.getWriter().println("character,anime,favorite_level,reason,image_url,created_at");
        for (CharacterFavorite character : characterFavoriteService.listByUserId(user.getId())) {
            response.getWriter().println(String.join(",",
                    csv(character.getCharacterName()),
                    csv(findAnimeTitle(animeById, character.getAnimeId())),
                    csv(character.getFavoriteLevel() == null ? null : character.getFavoriteLevel().toString()),
                    csv(character.getReason()),
                    csv(character.getImageUrl()),
                    csv(character.getCreateTime() == null ? null : character.getCreateTime().toString())
            ));
        }
    }

    @GetMapping("/pro/export/quotes.csv")
    public void exportQuoteCsv(HttpSession session, HttpServletResponse response) throws IOException {
        User user = getLoginUser(session);
        if (user == null || !user.isPro()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Pro required");
            return;
        }
        Map<Long, Anime> animeById = buildAnimeById(animeService.listByUserId(user.getId()));
        response.setCharacterEncoding(StandardCharsets.UTF_8.name());
        response.setContentType("text/csv;charset=UTF-8");
        response.setHeader("Content-Disposition", attachmentName("sekai-quotes.csv"));
        response.getWriter().write('\ufeff');
        response.getWriter().println("quote,character,anime,tag,feeling,video_url,created_at");
        for (Quote quote : quoteService.listByUserId(user.getId())) {
            response.getWriter().println(String.join(",",
                    csv(quote.getContent()),
                    csv(quote.getCharacterName()),
                    csv(findAnimeTitle(animeById, quote.getAnimeId())),
                    csv(quote.getTag()),
                    csv(quote.getFeeling()),
                    csv(quote.getVideoUrl()),
                    csv(quote.getCreateTime() == null ? null : quote.getCreateTime().toString())
            ));
        }
    }

    @GetMapping("/pro/export/watch-calendar.ics")
    public void exportWatchCalendar(HttpSession session, HttpServletResponse response) throws IOException {
        User user = getLoginUser(session);
        if (user == null || !user.isPro()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Pro required");
            return;
        }
        List<Anime> animeList = animeService.listByUserId(user.getId());
        response.setCharacterEncoding(StandardCharsets.UTF_8.name());
        response.setContentType("text/calendar;charset=UTF-8");
        response.setHeader("Content-Disposition", attachmentName("sekai-watch-calendar.ics"));
        response.getWriter().write(buildWatchCalendarIcs(user, buildWatchPlan(animeList)));
    }

    @GetMapping("/terms")
    public String terms() {
        return "terms";
    }

    @GetMapping("/privacy")
    public String privacy() {
        return "privacy";
    }

    @GetMapping("/refund")
    public String refund() {
        return "refund";
    }

    @GetMapping("/import/screenshot")
    public String screenshotImport(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        if (!user.isPro()) {
            return "redirect:/pro";
        }
        model.addAttribute("loginUser", user);
        return "screenshot-import";
    }

    @GetMapping("/u/{userName}")
    public String publicProfile(@PathVariable String userName, Model model) {
        User user = userService.getByUserName(userName);
        if (user == null) {
            return "redirect:/login";
        }
        List<Anime> animeList = animeService.listByUserId(user.getId());
        List<CharacterFavorite> characterList = characterFavoriteService.listByUserId(user.getId());
        List<Quote> quoteList = quoteService.listByUserId(user.getId());
        model.addAttribute("publicUser", user);
        model.addAttribute("stats", buildStats(animeList, characterList, quoteList));
        model.addAttribute("animeList", animeList.stream().limit(12).toList());
        model.addAttribute("characterList", characterList.stream().limit(8).toList());
        model.addAttribute("quoteList", quoteList.stream().limit(6).toList());
        model.addAttribute("topTags", rankTexts(animeList.stream()
                .flatMap(anime -> splitTags(anime.getTags()).stream())
                .toList(), 8));
        return "public-profile";
    }

    @GetMapping("/search")
    public String search(HttpSession session,
                         Model model,
                         @RequestParam(value = "q", required = false) String q) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        List<Anime> animeList = animeService.listByUserId(user.getId());
        List<CharacterFavorite> characterList = characterFavoriteService.listByUserId(user.getId());
        List<Quote> quoteList = quoteService.listByUserId(user.getId());
        model.addAttribute("loginUser", user);
        model.addAttribute("q", q == null ? "" : q);
        model.addAttribute("results", buildSearchResults(q, animeList, characterList, quoteList));
        return "search";
    }

    @GetMapping("/image-lab")
    public String imageLab(HttpSession session, Model model) {
        User user = getLoginUser(session);
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("loginUser", user);
        return "image-lab";
    }

    @GetMapping("/share/anime/{id}")
    public String shareAnime(@PathVariable Long id, Model model) {
        Anime anime = animeService.getById(id);
        if (anime == null) {
            return "redirect:/login";
        }
        List<CharacterFavorite> relatedCharacters = characterFavoriteService.listByUserId(anime.getUserId()).stream()
                .filter(character -> Objects.equals(character.getAnimeId(), anime.getId()))
                .toList();
        List<Quote> relatedQuotes = quoteService.listByUserId(anime.getUserId()).stream()
                .filter(quote -> Objects.equals(quote.getAnimeId(), anime.getId()))
                .toList();
        model.addAttribute("anime", anime);
        model.addAttribute("tagList", splitTags(anime.getTags()));
        model.addAttribute("relatedCharacters", relatedCharacters);
        model.addAttribute("relatedQuotes", relatedQuotes);
        return "share-anime";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    private void addDashboard(Model model, User user) {
        List<Anime> animeList = animeService.listByUserId(user.getId());
        List<CharacterFavorite> characterList = characterFavoriteService.listByUserId(user.getId());
        List<Quote> quoteList = quoteService.listByUserId(user.getId());
        model.addAttribute("loginUser", user);
        model.addAttribute("animeList", animeList);
        model.addAttribute("characterList", characterList);
        model.addAttribute("quoteList", quoteList);
        model.addAttribute("stats", buildStats(animeList, characterList, quoteList));
        model.addAttribute("recentAnimeList", animeList.stream().limit(4).toList());
    }

    private DashboardStats buildStats(List<Anime> animeList,
                                      List<CharacterFavorite> characterList,
                                      List<Quote> quoteList) {
        DashboardStats stats = new DashboardStats();
        stats.setAnimeCount(animeList.size());
        stats.setCharacterCount(characterList.size());
        stats.setQuoteCount(quoteList.size());
        stats.setWatchedCount((int) animeList.stream().filter(this::isWatched).count());
        List<BigDecimal> scores = animeList.stream()
                .map(Anime::getScore)
                .filter(Objects::nonNull)
                .toList();
        if (!scores.isEmpty()) {
            BigDecimal total = scores.stream().reduce(BigDecimal.ZERO, BigDecimal::add);
            stats.setAverageScore(total.divide(BigDecimal.valueOf(scores.size()), 1, RoundingMode.HALF_UP));
        }
        stats.setTopType(findMostFrequent(animeList.stream()
                .map(Anime::getType)
                .filter(value -> value != null && !value.isBlank())
                .toList()));
        stats.setTopTag(findMostFrequent(animeList.stream()
                .flatMap(anime -> splitTags(anime.getTags()).stream())
                .toList()));
        return stats;
    }

    private List<SearchResult> buildSearchResults(String q,
                                                  List<Anime> animeList,
                                                  List<CharacterFavorite> characterList,
                                                  List<Quote> quoteList) {
        String keyword = q == null ? "" : q.trim().toLowerCase();
        if (keyword.isEmpty()) {
            return List.of();
        }
        Map<Long, Anime> animeById = buildAnimeById(animeList);
        List<SearchResult> results = new ArrayList<>();
        animeList.stream()
                .filter(anime -> containsAny(keyword, anime.getTitle(), anime.getType(), anime.getStatus(), anime.getTags(), anime.getMemoryText()))
                .forEach(anime -> results.add(new SearchResult("番剧", anime.getTitle(),
                        compactJoin(anime.getStatus(), anime.getType(), anime.getScore() == null ? null : anime.getScore() + " 分"),
                        anime.getMemoryText(), "/anime/" + anime.getId())));
        characterList.stream()
                .filter(character -> containsAny(keyword, character.getCharacterName(), character.getReason()))
                .forEach(character -> results.add(new SearchResult("角色", character.getCharacterName(),
                        findAnimeTitle(animeById, character.getAnimeId()), character.getReason(),
                        character.getAnimeId() == null ? "/characters" : "/anime/" + character.getAnimeId())));
        quoteList.stream()
                .filter(quote -> containsAny(keyword, quote.getContent(), quote.getCharacterName(), quote.getFeeling(), quote.getTag(), quote.getVideoUrl()))
                .forEach(quote -> results.add(new SearchResult("台词", quote.getContent(),
                        compactJoin(findAnimeTitle(animeById, quote.getAnimeId()), quote.getCharacterName(), quote.getTag()),
                        quote.getFeeling(), quote.getAnimeId() == null ? "/quotes" : "/anime/" + quote.getAnimeId())));
        return results;
    }

    private List<HealthIssue> buildHealthIssues(List<Anime> animeList,
                                                List<CharacterFavorite> characterList,
                                                List<Quote> quoteList) {
        Map<Long, Integer> characterCountByAnime = countByAnimeId(characterList.stream()
                .map(CharacterFavorite::getAnimeId)
                .toList());
        Map<Long, Integer> quoteCountByAnime = countByAnimeId(quoteList.stream()
                .map(Quote::getAnimeId)
                .toList());
        List<HealthIssue> issues = new ArrayList<>();
        for (Anime anime : animeList) {
            if (anime.getCoverUrl() == null || anime.getCoverUrl().isBlank()) {
                issues.add(new HealthIssue("缺封面", anime.getTitle(), "补一张高清封面，公开主页和分享卡会更像作品集。", "/anime/" + anime.getId(), "high"));
            }
            if (anime.getMemoryText() == null || anime.getMemoryText().isBlank()) {
                issues.add(new HealthIssue("缺回忆", anime.getTitle(), "写 2-3 句当时为什么喜欢它，比单纯记录标题更有价值。", "/anime/" + anime.getId(), "medium"));
            }
            if (anime.getScore() == null) {
                issues.add(new HealthIssue("缺评分", anime.getTitle(), "补评分后，年度报告和高分榜会更完整。", "/anime/" + anime.getId(), "low"));
            }
            if (characterCountByAnime.getOrDefault(anime.getId(), 0) == 0) {
                issues.add(new HealthIssue("缺角色", anime.getTitle(), "至少收藏一个代表角色，后续可以生成角色偏好报告。", "/anime/" + anime.getId(), "medium"));
            }
            if (quoteCountByAnime.getOrDefault(anime.getId(), 0) == 0) {
                issues.add(new HealthIssue("缺台词", anime.getTitle(), "摘一句名台词，公开展馆会更有记忆点。", "/anime/" + anime.getId(), "medium"));
            }
        }
        return issues.stream().limit(30).toList();
    }

    private String attachmentName(String fileName) {
        String encoded = URLEncoder.encode(fileName, StandardCharsets.UTF_8).replace("+", "%20");
        return "attachment; filename=\"" + fileName + "\"; filename*=UTF-8''" + encoded;
    }

    private String csv(String value) {
        if (value == null) {
            return "";
        }
        return "\"" + value.replace("\"", "\"\"").replace("\r", " ").replace("\n", " ") + "\"";
    }

    private String buildMemoryGraphJson(List<Anime> animeList,
                                        List<CharacterFavorite> characterList,
                                        List<Quote> quoteList) {
        StringBuilder json = new StringBuilder();
        Map<Long, Anime> animeById = buildAnimeById(animeList);
        Map<String, String> characterNodeByAnimeAndName = new HashMap<>();
        Map<String, String> tagNodeByName = new LinkedHashMap<>();

        json.append("{\"nodes\":[");
        boolean firstNode = true;
        for (Anime anime : animeList) {
            firstNode = appendGraphNode(json, firstNode,
                    "anime-" + anime.getId(),
                    anime.getTitle(),
                    "anime",
                    compactJoin(anime.getStatus(), anime.getType(),
                            anime.getScore() == null ? null : anime.getScore() + " 分",
                            anime.getTotalEpisodes() == null ? null : anime.getTotalEpisodes() + " 集"),
                    "/anime/" + anime.getId(),
                    anime.getCoverUrl(),
                    anime.getScore() == null ? 16 : Math.min(28, 16 + anime.getScore().intValue()),
                    anime.getTags());
            for (String tag : splitTags(anime.getTags())) {
                if (!tagNodeByName.containsKey(tag)) {
                    tagNodeByName.put(tag, "tag-" + tagNodeByName.size());
                }
            }
        }
        for (CharacterFavorite character : characterList) {
            String nodeId = "character-" + character.getId();
            if (character.getAnimeId() != null && character.getCharacterName() != null) {
                characterNodeByAnimeAndName.put(character.getAnimeId() + "::" + character.getCharacterName(), nodeId);
            }
            firstNode = appendGraphNode(json, firstNode,
                    nodeId,
                    character.getCharacterName(),
                    "character",
                    compactJoin(findAnimeTitle(animeById, character.getAnimeId()), character.getReason()),
                    character.getAnimeId() == null ? "/characters" : "/anime/" + character.getAnimeId(),
                    character.getImageUrl(),
                    character.getFavoriteLevel() == null ? 12 : Math.min(22, 12 + character.getFavoriteLevel() * 2),
                    null);
        }
        for (Quote quote : quoteList) {
            firstNode = appendGraphNode(json, firstNode,
                    "quote-" + quote.getId(),
                    compactLabel(quote.getContent(), 34),
                    "quote",
                    compactJoin(findAnimeTitle(animeById, quote.getAnimeId()), quote.getCharacterName(), quote.getTag(), quote.getFeeling()),
                    quote.getAnimeId() == null ? "/quotes" : "/anime/" + quote.getAnimeId(),
                    null,
                    10,
                    quote.getTag());
        }
        for (Map.Entry<String, String> entry : tagNodeByName.entrySet()) {
            firstNode = appendGraphNode(json, firstNode,
                    entry.getValue(),
                    entry.getKey(),
                    "tag",
                    "标签：" + entry.getKey(),
                    "/anime?keyword=" + entry.getKey(),
                    null,
                    9,
                    null);
        }

        json.append("],\"edges\":[");
        boolean firstEdge = true;
        for (CharacterFavorite character : characterList) {
            if (character.getAnimeId() != null && animeById.containsKey(character.getAnimeId())) {
                firstEdge = appendGraphEdge(json, firstEdge, "anime-" + character.getAnimeId(), "character-" + character.getId(), "cast");
            }
        }
        for (Quote quote : quoteList) {
            if (quote.getAnimeId() != null && animeById.containsKey(quote.getAnimeId())) {
                firstEdge = appendGraphEdge(json, firstEdge, "anime-" + quote.getAnimeId(), "quote-" + quote.getId(), "quote");
            }
            if (quote.getAnimeId() != null && quote.getCharacterName() != null) {
                String characterNodeId = characterNodeByAnimeAndName.get(quote.getAnimeId() + "::" + quote.getCharacterName());
                if (characterNodeId != null) {
                    firstEdge = appendGraphEdge(json, firstEdge, characterNodeId, "quote-" + quote.getId(), "says");
                }
            }
        }
        for (Anime anime : animeList) {
            for (String tag : splitTags(anime.getTags())) {
                String tagNodeId = tagNodeByName.get(tag);
                if (tagNodeId != null) {
                    firstEdge = appendGraphEdge(json, firstEdge, "anime-" + anime.getId(), tagNodeId, "tag");
                }
            }
        }
        json.append("]}");
        return json.toString();
    }

    private boolean appendGraphNode(StringBuilder json,
                                    boolean first,
                                    String id,
                                    String label,
                                    String type,
                                    String detail,
                                    String href,
                                    String image,
                                    int size,
                                    String tags) {
        if (!first) {
            json.append(',');
        }
        json.append('{')
                .append("\"id\":\"").append(escapeJson(id)).append("\",")
                .append("\"label\":\"").append(escapeJson(label)).append("\",")
                .append("\"type\":\"").append(escapeJson(type)).append("\",")
                .append("\"detail\":\"").append(escapeJson(detail)).append("\",")
                .append("\"href\":\"").append(escapeJson(href)).append("\",")
                .append("\"image\":\"").append(escapeJson(image)).append("\",")
                .append("\"size\":").append(size).append(',')
                .append("\"tags\":\"").append(escapeJson(tags)).append("\"")
                .append('}');
        return false;
    }

    private boolean appendGraphEdge(StringBuilder json, boolean first, String source, String target, String type) {
        if (!first) {
            json.append(',');
        }
        json.append('{')
                .append("\"source\":\"").append(escapeJson(source)).append("\",")
                .append("\"target\":\"").append(escapeJson(target)).append("\",")
                .append("\"type\":\"").append(escapeJson(type)).append("\"")
                .append('}');
        return false;
    }

    private String compactLabel(String value, int maxLength) {
        if (value == null) {
            return "";
        }
        String trimmed = value.trim();
        return trimmed.length() <= maxLength ? trimmed : trimmed.substring(0, maxLength) + "...";
    }

    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        StringBuilder escaped = new StringBuilder(value.length() + 16);
        for (int index = 0; index < value.length(); index++) {
            char current = value.charAt(index);
            switch (current) {
                case '\\' -> escaped.append("\\\\");
                case '"' -> escaped.append("\\\"");
                case '\n' -> escaped.append("\\n");
                case '\r' -> escaped.append("\\r");
                case '\t' -> escaped.append("\\t");
                default -> escaped.append(current);
            }
        }
        return escaped.toString();
    }

    private boolean containsAny(String keyword, String... values) {
        return Arrays.stream(values)
                .filter(Objects::nonNull)
                .map(String::toLowerCase)
                .anyMatch(value -> value.contains(keyword));
    }

    private Anime chooseNextAnime(AdvancedInsights insights, List<Anime> animeList) {
        if (!insights.getRecommendations().isEmpty()) {
            return insights.getRecommendations().get(0).getAnime();
        }
        return animeList.stream()
                .filter(anime -> !isWatched(anime))
                .findFirst()
                .orElse(animeList.stream()
                        .filter(anime -> anime.getScore() != null)
                        .max(Comparator.comparing(Anime::getScore))
                        .orElse(animeList.stream().findFirst().orElse(null)));
    }

    private List<ShareSnippet> buildShareSnippets(List<Anime> animeList, List<Quote> quoteList) {
        Map<Long, List<Quote>> quotesByAnime = new HashMap<>();
        quoteList.stream()
                .filter(quote -> quote.getAnimeId() != null)
                .forEach(quote -> quotesByAnime.computeIfAbsent(quote.getAnimeId(), key -> new ArrayList<>()).add(quote));
        return animeList.stream()
                .filter(anime -> anime.getCoverUrl() != null && !anime.getCoverUrl().isBlank())
                .sorted(Comparator.comparing(Anime::getScore, Comparator.nullsLast(Comparator.reverseOrder())))
                .limit(6)
                .map(anime -> new ShareSnippet(
                        anime,
                        buildShareCopy(anime, quotesByAnime.getOrDefault(anime.getId(), List.of()).stream().findFirst().orElse(null)),
                        "/share/anime/" + anime.getId()))
                .toList();
    }

    private String buildShareCopy(Anime anime, Quote quote) {
        String scorePart = anime.getScore() == null ? "私藏推荐" : anime.getScore().stripTrailingZeros().toPlainString() + " 分推荐";
        String quotePart = quote == null || quote.getContent() == null || quote.getContent().isBlank()
                ? "这部作品已经放进我的番剧回忆录。"
                : "记住的一句台词：" + quote.getContent();
        return "《" + anime.getTitle() + "》" + scorePart + "。"
                + quotePart + " 来我的 Sekai Memory Book 看完整记录。";
    }

    private List<ProAssetInsight> buildProAssetInsights(List<Anime> animeList,
                                                        List<CharacterFavorite> characterList,
                                                        List<Quote> quoteList) {
        Map<Long, Integer> characterCounts = countByAnimeId(characterList.stream()
                .map(CharacterFavorite::getAnimeId)
                .toList());
        Map<Long, Integer> quoteCounts = countByAnimeId(quoteList.stream()
                .map(Quote::getAnimeId)
                .toList());
        Map<Long, List<Quote>> quotesByAnime = new HashMap<>();
        quoteList.stream()
                .filter(quote -> quote.getAnimeId() != null)
                .forEach(quote -> quotesByAnime.computeIfAbsent(quote.getAnimeId(), key -> new ArrayList<>()).add(quote));

        return animeList.stream()
                .map(anime -> {
                    int characters = characterCounts.getOrDefault(anime.getId(), 0);
                    int quotes = quoteCounts.getOrDefault(anime.getId(), 0);
                    List<String> strengths = new ArrayList<>();
                    List<String> gaps = new ArrayList<>();
                    int score = 0;

                    if (anime.getCoverUrl() != null && !anime.getCoverUrl().isBlank()) {
                        score += 18;
                        strengths.add("有封面，适合展示");
                    } else {
                        gaps.add("补一张清晰封面");
                    }
                    if (anime.getScore() != null) {
                        score += 14;
                        strengths.add("已评分");
                    } else {
                        gaps.add("补评分");
                    }
                    if (anime.getMemoryText() != null && !anime.getMemoryText().isBlank()) {
                        score += 18;
                        strengths.add("有个人短评");
                    } else {
                        gaps.add("补一段看完感想");
                    }
                    if (anime.getWatchDate() != null || anime.getReleaseDate() != null) {
                        score += 10;
                        strengths.add("有时间线信息");
                    } else {
                        gaps.add("补观看日期或开播日期");
                    }
                    if (anime.getTags() != null && !splitTags(anime.getTags()).isEmpty()) {
                        score += 12;
                        strengths.add("有标签");
                    } else {
                        gaps.add("补 2-4 个标签");
                    }
                    if (characters > 0) {
                        score += Math.min(14, 6 + characters * 4);
                        strengths.add(characters + " 个关联角色");
                    } else {
                        gaps.add("补主要角色");
                    }
                    if (quotes > 0) {
                        score += Math.min(14, 6 + quotes * 4);
                        strengths.add(quotes + " 条台词资产");
                    } else {
                        gaps.add("补一句名台词");
                    }

                    int finalScore = Math.min(score, 100);
                    String level = finalScore >= 80 ? "可出售级" : (finalScore >= 58 ? "可分享级" : "待补全");
                    Quote quote = quotesByAnime.getOrDefault(anime.getId(), List.of()).stream().findFirst().orElse(null);
                    String copy = buildAssetShareCopy(anime, quote, characters, quotes, finalScore);
                    return new ProAssetInsight(anime, finalScore, level, strengths, gaps, copy, characters, quotes, "/anime/" + anime.getId());
                })
                .sorted(Comparator.comparing(ProAssetInsight::score).reversed())
                .toList();
    }

    private String buildAssetShareCopy(Anime anime, Quote quote, int characterCount, int quoteCount, int score) {
        String scoreText = anime.getScore() == null ? "私人推荐" : anime.getScore().stripTrailingZeros().toPlainString() + " 分推荐";
        String quoteText = quote == null || quote.getContent() == null || quote.getContent().isBlank()
                ? "这部作品已经被我收进番剧回忆录。"
                : "记住的一句台词：" + quote.getContent();
        return "《" + anime.getTitle() + "》" + scoreText + "。档案完成度 " + score
                + "%，已整理 " + characterCount + " 个角色、" + quoteCount + " 条台词。" + quoteText;
    }

    private List<ProGoal> buildProGoals(List<Anime> animeList,
                                        List<CharacterFavorite> characterList,
                                        List<Quote> quoteList,
                                        List<HealthIssue> issues) {
        List<ProGoal> goals = new ArrayList<>();
        goals.add(new ProGoal("本周补全", Math.min(issues.size(), 8), "优先处理体检里最影响分享效果的记录"));
        goals.add(new ProGoal("可分享作品", (int) animeList.stream()
                .filter(anime -> anime.getCoverUrl() != null && !anime.getCoverUrl().isBlank())
                .count(), "有封面的作品可以直接生成公开分享页"));
        goals.add(new ProGoal("角色密度", characterList.size(), "角色越多，回忆录越不像普通记事本"));
        goals.add(new ProGoal("台词资产", quoteList.size(), "台词会让公开页和年度报告更有情绪记忆点"));
        return goals;
    }

    private List<ProPlaylist> buildProPlaylists(List<Anime> animeList) {
        List<ProPlaylist> playlists = new ArrayList<>();
        playlists.add(new ProPlaylist("高分神作片单", "适合当作主页门面展示",
                pickPlaylist(animeList, anime -> anime.getScore() != null
                        && anime.getScore().compareTo(BigDecimal.valueOf(9)) >= 0, 8)));
        playlists.add(new ProPlaylist("治愈放松片单", "适合睡前、低压、想恢复能量的时候看",
                pickPlaylist(animeList, anime -> textContainsAny(compactJoin(anime.getTags(), anime.getType(), anime.getMemoryText()),
                        "治愈", "日常", "温柔", "美食", "百合"), 8)));
        playlists.add(new ProPlaylist("热血战斗片单", "适合想燃起来、想找战斗爽感的时候看",
                pickPlaylist(animeList, anime -> textContainsAny(compactJoin(anime.getTags(), anime.getType(), anime.getMemoryText()),
                        "热血", "战斗", "冒险", "竞技", "魔法"), 8)));
        playlists.add(new ProPlaylist("恋爱青春片单", "适合做成分享页，情绪记忆点强",
                pickPlaylist(animeList, anime -> textContainsAny(compactJoin(anime.getTags(), anime.getType(), anime.getMemoryText()),
                        "恋爱", "青春", "校园", "后宫", "美少女"), 8)));
        playlists.add(new ProPlaylist("待补完片单", "把想看和在看的作品集中起来，减少半途搁置",
                pickPlaylist(animeList, anime -> !isWatched(anime), 8)));
        playlists.add(new ProPlaylist("最适合分享片单", "有封面、有评分、有感想的作品最适合拿出去展示",
                pickPlaylist(animeList, anime -> anime.getCoverUrl() != null && !anime.getCoverUrl().isBlank()
                        && anime.getScore() != null
                        && anime.getMemoryText() != null && !anime.getMemoryText().isBlank(), 8)));
        return playlists.stream()
                .filter(playlist -> !playlist.animeList().isEmpty())
                .toList();
    }

    private List<Anime> pickPlaylist(List<Anime> animeList, java.util.function.Predicate<Anime> predicate, int limit) {
        return animeList.stream()
                .filter(predicate)
                .sorted(Comparator.comparing(Anime::getScore, Comparator.nullsLast(Comparator.reverseOrder())))
                .limit(limit)
                .toList();
    }

    private boolean textContainsAny(String text, String... keywords) {
        if (text == null || text.isBlank()) {
            return false;
        }
        return Arrays.stream(keywords).anyMatch(text::contains);
    }

    private List<WatchPlanDay> buildWatchPlan(List<Anime> animeList) {
        List<Anime> candidates = animeList.stream()
                .filter(anime -> !isWatched(anime))
                .sorted(Comparator
                        .comparing((Anime anime) -> priorityStatus(anime.getStatus())).reversed()
                        .thenComparing(Anime::getScore, Comparator.nullsLast(Comparator.reverseOrder()))
                        .thenComparing(Anime::getUpdateTime, Comparator.nullsLast(Comparator.reverseOrder())))
                .limit(21)
                .toList();
        if (candidates.isEmpty()) {
            return List.of();
        }
        List<WatchPlanDay> plan = new ArrayList<>();
        for (int dayIndex = 0; dayIndex < 7; dayIndex++) {
            LocalDate date = LocalDate.now().plusDays(dayIndex);
            Anime anime = candidates.get(dayIndex % candidates.size());
            int current = anime.getCurrentEpisode() == null ? 0 : anime.getCurrentEpisode();
            int total = anime.getTotalEpisodes() == null ? 0 : anime.getTotalEpisodes();
            int remain = total > current ? total - current : 1;
            int episodes = Math.max(1, Math.min(3, remain));
            String focus = dayIndex == 0 ? "先启动" : (episodes >= 3 ? "集中推进" : "轻量保持");
            String reason = buildWatchPlanReason(anime, episodes, remain);
            plan.add(new WatchPlanDay(date, dayIndex + 1, anime, episodes, focus, reason));
        }
        return plan;
    }

    private int priorityStatus(String status) {
        if (status == null) {
            return 0;
        }
        if (status.contains("在看")) {
            return 4;
        }
        if (status.contains("想看")) {
            return 3;
        }
        if (status.contains("搁置")) {
            return 1;
        }
        return 2;
    }

    private String buildWatchPlanReason(Anime anime, int episodes, int remain) {
        List<String> parts = new ArrayList<>();
        if (anime.getStatus() != null && !anime.getStatus().isBlank()) {
            parts.add(anime.getStatus());
        }
        if (anime.getScore() != null) {
            parts.add(anime.getScore().stripTrailingZeros().toPlainString() + " 分");
        }
        if (anime.getTags() != null && !anime.getTags().isBlank()) {
            parts.add(anime.getTags());
        }
        String prefix = parts.isEmpty() ? "适合作为今天的补番任务" : String.join(" / ", parts);
        return prefix + "。建议看 " + episodes + " 集，预计还剩 " + Math.max(remain - episodes, 0) + " 集。";
    }

    private String buildWatchCalendarIcs(User user, List<WatchPlanDay> watchPlan) {
        String now = LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("yyyyMMdd'T'HHmmss"));
        StringBuilder builder = new StringBuilder();
        builder.append("BEGIN:VCALENDAR\r\n");
        builder.append("VERSION:2.0\r\n");
        builder.append("PRODID:-//Sekai Memory Book//Watch Calendar//ZH-CN\r\n");
        builder.append("CALSCALE:GREGORIAN\r\n");
        builder.append("X-WR-CALNAME:Sekai 追番日历\r\n");
        for (WatchPlanDay day : watchPlan) {
            String start = day.date().format(java.time.format.DateTimeFormatter.BASIC_ISO_DATE);
            String end = day.date().plusDays(1).format(java.time.format.DateTimeFormatter.BASIC_ISO_DATE);
            String title = day.anime() == null ? "追番任务" : day.anime().getTitle();
            builder.append("BEGIN:VEVENT\r\n");
            builder.append("UID:sekai-")
                    .append(escapeIcs(user.getUserName()))
                    .append("-")
                    .append(start)
                    .append("-")
                    .append(day.dayNumber())
                    .append("@memory-book\r\n");
            builder.append("DTSTAMP:").append(now).append("\r\n");
            builder.append("DTSTART;VALUE=DATE:").append(start).append("\r\n");
            builder.append("DTEND;VALUE=DATE:").append(end).append("\r\n");
            builder.append("SUMMARY:").append(escapeIcs("补番：" + title)).append("\r\n");
            builder.append("DESCRIPTION:").append(escapeIcs("建议看 " + day.episodes() + " 集。" + day.reason())).append("\r\n");
            builder.append("END:VEVENT\r\n");
        }
        builder.append("END:VCALENDAR\r\n");
        return builder.toString();
    }

    private String escapeIcs(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\\", "\\\\")
                .replace(";", "\\;")
                .replace(",", "\\,")
                .replace("\r", "")
                .replace("\n", "\\n");
    }

    private List<Anime> filterBatchAnime(List<Anime> animeList, String filter) {
        return animeList.stream()
                .filter(anime -> switch (filter) {
                    case "cover" -> anime.getCoverUrl() == null || anime.getCoverUrl().isBlank();
                    case "score" -> anime.getScore() == null;
                    case "memory" -> anime.getMemoryText() == null || anime.getMemoryText().isBlank();
                    case "watching" -> !isWatched(anime);
                    case "shareable" -> anime.getCoverUrl() != null && !anime.getCoverUrl().isBlank()
                            && anime.getScore() != null
                            && anime.getMemoryText() != null && !anime.getMemoryText().isBlank();
                    case "all" -> true;
                    default -> anime.getCoverUrl() == null || anime.getCoverUrl().isBlank()
                            || anime.getScore() == null
                            || anime.getMemoryText() == null || anime.getMemoryText().isBlank();
                })
                .limit(80)
                .toList();
    }

    private Map<String, Integer> buildBatchStats(List<Anime> animeList) {
        Map<String, Integer> stats = new LinkedHashMap<>();
        stats.put("missing", (int) filterBatchAnime(animeList, "missing").stream().count());
        stats.put("cover", (int) animeList.stream().filter(anime -> anime.getCoverUrl() == null || anime.getCoverUrl().isBlank()).count());
        stats.put("score", (int) animeList.stream().filter(anime -> anime.getScore() == null).count());
        stats.put("memory", (int) animeList.stream().filter(anime -> anime.getMemoryText() == null || anime.getMemoryText().isBlank()).count());
        stats.put("watching", (int) animeList.stream().filter(anime -> !isWatched(anime)).count());
        stats.put("shareable", (int) filterBatchAnime(animeList, "shareable").stream().count());
        stats.put("all", animeList.size());
        return stats;
    }

    private String appendDistinctTag(String tags, String newTag) {
        List<String> values = new ArrayList<>(splitTags(tags));
        boolean exists = values.stream().anyMatch(value -> value.equalsIgnoreCase(newTag));
        if (!exists) {
            values.add(newTag);
        }
        return String.join(", ", values);
    }

    private List<DuplicateGroup> buildDuplicateGroups(List<Anime> animeList,
                                                      List<CharacterFavorite> characterList,
                                                      List<Quote> quoteList) {
        List<DuplicateGroup> groups = new ArrayList<>();
        collectDuplicateAnime(animeList).forEach((key, values) ->
                groups.add(new DuplicateGroup("anime", "番剧", key, values.stream()
                        .map(anime -> new DuplicateItem(
                                anime.getId(),
                                anime.getTitle(),
                                compactJoin(anime.getStatus(),
                                        anime.getScore() == null ? null : anime.getScore().stripTrailingZeros().toPlainString() + " 分",
                                        anime.getTags()),
                                anime.getUpdateTime() == null ? anime.getCreateTime() : anime.getUpdateTime(),
                                "/anime/" + anime.getId()))
                        .toList())));
        collectDuplicateCharacters(characterList).forEach((key, values) ->
                groups.add(new DuplicateGroup("character", "角色", key, values.stream()
                        .map(character -> new DuplicateItem(
                                character.getId(),
                                character.getCharacterName(),
                                compactJoin(character.getFavoriteLevel() == null ? null : character.getFavoriteLevel() + " 星", character.getReason()),
                                character.getCreateTime(),
                                character.getAnimeId() == null ? "/characters" : "/anime/" + character.getAnimeId()))
                        .toList())));
        collectDuplicateQuotes(quoteList).forEach((key, values) ->
                groups.add(new DuplicateGroup("quote", "台词", key, values.stream()
                        .map(quote -> new DuplicateItem(
                                quote.getId(),
                                quote.getContent(),
                                compactJoin(quote.getCharacterName(), quote.getTag(), quote.getFeeling()),
                                quote.getCreateTime(),
                                quote.getAnimeId() == null ? "/quotes" : "/anime/" + quote.getAnimeId()))
                        .toList())));
        return groups.stream()
                .sorted(Comparator.comparing(DuplicateGroup::typeLabel).thenComparing(DuplicateGroup::key))
                .limit(60)
                .toList();
    }

    private Map<String, List<Anime>> collectDuplicateAnime(List<Anime> animeList) {
        Map<String, List<Anime>> groups = new LinkedHashMap<>();
        animeList.forEach(anime -> addDuplicateCandidate(groups, normalizeDuplicateKey(anime.getTitle()), anime));
        return onlyDuplicates(groups);
    }

    private Map<String, List<CharacterFavorite>> collectDuplicateCharacters(List<CharacterFavorite> characterList) {
        Map<String, List<CharacterFavorite>> groups = new LinkedHashMap<>();
        characterList.forEach(character -> addDuplicateCandidate(groups,
                normalizeDuplicateKey(character.getCharacterName()) + "#" + (character.getAnimeId() == null ? 0 : character.getAnimeId()),
                character));
        return onlyDuplicates(groups);
    }

    private Map<String, List<Quote>> collectDuplicateQuotes(List<Quote> quoteList) {
        Map<String, List<Quote>> groups = new LinkedHashMap<>();
        quoteList.forEach(quote -> addDuplicateCandidate(groups,
                normalizeDuplicateKey(quote.getContent()) + "#" + (quote.getAnimeId() == null ? 0 : quote.getAnimeId()),
                quote));
        return onlyDuplicates(groups);
    }

    private <T> void addDuplicateCandidate(Map<String, List<T>> groups, String key, T value) {
        if (key != null && !key.isBlank()) {
            groups.computeIfAbsent(key, ignored -> new ArrayList<>()).add(value);
        }
    }

    private <T> Map<String, List<T>> onlyDuplicates(Map<String, List<T>> groups) {
        return groups.entrySet().stream()
                .filter(entry -> entry.getValue().size() > 1)
                .collect(LinkedHashMap::new,
                        (result, entry) -> result.put(entry.getKey(), entry.getValue()),
                        LinkedHashMap::putAll);
    }

    private String normalizeDuplicateKey(String value) {
        if (value == null) {
            return null;
        }
        return value.toLowerCase()
                .replaceAll("[\\s　:：!！?？·・,，.。\\-—_《》\\[\\]【】()（）]", "")
                .trim();
    }

    private AdvancedInsights buildAdvancedInsights(List<Anime> animeList,
                                                   List<CharacterFavorite> characterList,
                                                   List<Quote> quoteList) {
        AdvancedInsights insights = new AdvancedInsights();
        insights.setTagRanks(rankAdvancedTexts(animeList.stream()
                .flatMap(anime -> splitTags(anime.getTags()).stream())
                .toList(), 8));
        insights.setEmotionRanks(rankAdvancedTexts(collectEmotionWords(animeList, characterList, quoteList), 8));
        insights.setProgressLanes(buildProgressLanes(animeList));
        insights.setContinueWatching(animeList.stream()
                .filter(anime -> matchesStatus(anime, "在看"))
                .limit(6)
                .toList());
        insights.setShareCandidates(animeList.stream()
                .filter(anime -> anime.getCoverUrl() != null && !anime.getCoverUrl().isBlank())
                .limit(6)
                .toList());
        insights.setRecommendations(buildRecommendations(animeList, characterList, quoteList));
        insights.setActionItems(buildActionItems(animeList, characterList, quoteList));
        insights.setScoreBands(buildScoreBands(animeList));
        return insights;
    }

    private List<AdvancedInsights.Recommendation> buildRecommendations(List<Anime> animeList,
                                                                       List<CharacterFavorite> characterList,
                                                                       List<Quote> quoteList) {
        Set<String> favoriteTags = new HashSet<>();
        Set<String> favoriteTypes = new HashSet<>();
        animeList.stream()
                .filter(anime -> anime.getScore() != null && anime.getScore().compareTo(BigDecimal.valueOf(8.5)) >= 0)
                .forEach(anime -> {
                    favoriteTags.addAll(splitTags(anime.getTags()));
                    if (anime.getType() != null && !anime.getType().isBlank()) {
                        favoriteTypes.add(anime.getType().trim());
                    }
                });

        Map<Long, Integer> characterCounts = countByAnimeId(characterList.stream()
                .map(CharacterFavorite::getAnimeId)
                .toList());
        Map<Long, Integer> quoteCounts = countByAnimeId(quoteList.stream()
                .map(Quote::getAnimeId)
                .toList());

        return animeList.stream()
                .filter(anime -> !isWatched(anime))
                .map(anime -> buildRecommendation(anime, favoriteTags, favoriteTypes,
                        characterCounts.getOrDefault(anime.getId(), 0), quoteCounts.getOrDefault(anime.getId(), 0)))
                .filter(recommendation -> recommendation.getMatchScore() > 0)
                .sorted(Comparator.comparingInt(AdvancedInsights.Recommendation::getMatchScore).reversed())
                .limit(5)
                .toList();
    }

    private AdvancedInsights.Recommendation buildRecommendation(Anime anime,
                                                               Set<String> favoriteTags,
                                                               Set<String> favoriteTypes,
                                                               int characterCount,
                                                               int quoteCount) {
        int score = 0;
        List<String> reasons = new ArrayList<>();

        List<String> matchedTags = splitTags(anime.getTags()).stream()
                .filter(favoriteTags::contains)
                .limit(3)
                .toList();
        if (!matchedTags.isEmpty()) {
            score += matchedTags.size() * 22;
            reasons.add("命中偏好标签：" + String.join("、", matchedTags));
        }
        if (anime.getType() != null && favoriteTypes.contains(anime.getType().trim())) {
            score += 18;
            reasons.add("类型接近高分作品");
        }
        if (matchesStatus(anime, "在看") || matchesStatus(anime, "想看")) {
            score += 14;
            reasons.add("当前适合继续推进");
        }
        if (characterCount > 0) {
            score += Math.min(characterCount * 8, 18);
            reasons.add(characterCount + " 个已收藏角色");
        }
        if (quoteCount > 0) {
            score += Math.min(quoteCount * 7, 14);
            reasons.add(quoteCount + " 条台词摘录");
        }
        if (anime.getMemoryText() != null && !anime.getMemoryText().isBlank()) {
            score += 8;
            reasons.add("已有观后感线索");
        }

        return new AdvancedInsights.Recommendation(anime, Math.min(score, 99),
                reasons.isEmpty() ? "可以作为下一部补完候选" : String.join("；", reasons));
    }

    private List<AdvancedInsights.ActionItem> buildActionItems(List<Anime> animeList,
                                                               List<CharacterFavorite> characterList,
                                                               List<Quote> quoteList) {
        List<AdvancedInsights.ActionItem> actionItems = new ArrayList<>();
        animeList.stream()
                .filter(anime -> matchesStatus(anime, "在看") && anime.getLastWatchDate() != null
                        && anime.getLastWatchDate().isBefore(LocalDate.now().minusDays(14)))
                .limit(3)
                .forEach(anime -> actionItems.add(new AdvancedInsights.ActionItem(
                        "追番提醒",
                        anime.getTitle() + " 已经 " + (LocalDate.now().toEpochDay() - anime.getLastWatchDate().toEpochDay()) + " 天没更新观看进度",
                        "/anime/" + anime.getId(),
                        "high")));
        animeList.stream()
                .filter(anime -> anime.getCoverUrl() == null || anime.getCoverUrl().isBlank())
                .limit(3)
                .forEach(anime -> actionItems.add(new AdvancedInsights.ActionItem(
                        "补封面",
                        anime.getTitle() + " 还没有封面，分享卡片会更单薄",
                        "/anime/" + anime.getId(),
                        "medium")));
        animeList.stream()
                .filter(anime -> anime.getMemoryText() == null || anime.getMemoryText().isBlank())
                .limit(3)
                .forEach(anime -> actionItems.add(new AdvancedInsights.ActionItem(
                        "补观后感",
                        anime.getTitle() + " 还缺一段自己的记忆注释",
                        "/anime/" + anime.getId(),
                        "low")));
        if (characterList.isEmpty() && !animeList.isEmpty()) {
            actionItems.add(new AdvancedInsights.ActionItem("建立角色墙", "先给喜欢的作品补 1 个角色收藏", "/characters", "medium"));
        }
        if (quoteList.isEmpty() && !animeList.isEmpty()) {
            actionItems.add(new AdvancedInsights.ActionItem("摘录台词", "保存一句最能代表当前心情的台词", "/quotes", "medium"));
        }
        return actionItems.stream().limit(6).toList();
    }

    private List<AdvancedInsights.ScoreBand> buildScoreBands(List<Anime> animeList) {
        int excellent = 0;
        int good = 0;
        int normal = 0;
        int low = 0;
        int unrated = 0;
        for (Anime anime : animeList) {
            BigDecimal score = anime.getScore();
            if (score == null) {
                unrated++;
            } else if (score.compareTo(BigDecimal.valueOf(9)) >= 0) {
                excellent++;
            } else if (score.compareTo(BigDecimal.valueOf(8)) >= 0) {
                good++;
            } else if (score.compareTo(BigDecimal.valueOf(7)) >= 0) {
                normal++;
            } else {
                low++;
            }
        }
        int total = animeList.size();
        return List.of(
                new AdvancedInsights.ScoreBand("9 分以上", excellent, total),
                new AdvancedInsights.ScoreBand("8-8.9 分", good, total),
                new AdvancedInsights.ScoreBand("7-7.9 分", normal, total),
                new AdvancedInsights.ScoreBand("7 分以下", low, total),
                new AdvancedInsights.ScoreBand("未评分", unrated, total));
    }

    private Map<Long, Integer> countByAnimeId(List<Long> animeIds) {
        Map<Long, Integer> counts = new HashMap<>();
        animeIds.stream()
                .filter(Objects::nonNull)
                .forEach(animeId -> counts.merge(animeId, 1, Integer::sum));
        return counts;
    }

    private Map<Long, Anime> buildAnimeById(List<Anime> animeList) {
        Map<Long, Anime> animeById = new HashMap<>();
        animeList.forEach(anime -> animeById.put(anime.getId(), anime));
        return animeById;
    }

    private Map<Long, String> buildAnimeCoverById(List<Anime> animeList) {
        Map<Long, String> animeCoverById = new HashMap<>();
        animeList.stream()
                .filter(anime -> anime.getId() != null)
                .filter(anime -> anime.getCoverUrl() != null && !anime.getCoverUrl().isBlank())
                .forEach(anime -> animeCoverById.put(anime.getId(), anime.getCoverUrl()));
        return animeCoverById;
    }

    private List<AdvancedInsights.ProgressLane> buildProgressLanes(List<Anime> animeList) {
        List<String> statuses = List.of("想看", "在看", "看完", "搁置");
        int total = animeList.size();
        return statuses.stream()
                .map(status -> {
                    List<Anime> laneAnime = animeList.stream()
                            .filter(anime -> matchesStatus(anime, status))
                            .limit(5)
                            .toList();
                    int count = (int) animeList.stream().filter(anime -> matchesStatus(anime, status)).count();
                    return new AdvancedInsights.ProgressLane(status, count, total, laneAnime);
                })
                .toList();
    }

    private boolean matchesStatus(Anime anime, String status) {
        return anime.getStatus() != null && anime.getStatus().contains(status);
    }

    private List<String> collectEmotionWords(List<Anime> animeList,
                                             List<CharacterFavorite> characterList,
                                             List<Quote> quoteList) {
        Map<String, List<String>> emotionKeywords = new LinkedHashMap<>();
        emotionKeywords.put("治愈", List.of("治愈", "温柔", "舒服", "安心", "温暖"));
        emotionKeywords.put("燃", List.of("燃", "热血", "激动", "震撼", "爽"));
        emotionKeywords.put("甜", List.of("甜", "恋爱", "可爱", "心动", "糖"));
        emotionKeywords.put("刀", List.of("刀", "哭", "泪", "难过", "虐"));
        emotionKeywords.put("压抑", List.of("压抑", "沉重", "黑暗", "绝望", "窒息"));
        emotionKeywords.put("怀旧", List.of("怀旧", "青春", "回忆", "夏天", "旧"));

        List<String> texts = new ArrayList<>();
        animeList.forEach(anime -> texts.add(compactJoin(anime.getTags(), anime.getMemoryText(), anime.getType())));
        characterList.forEach(character -> texts.add(character.getReason()));
        quoteList.forEach(quote -> texts.add(compactJoin(quote.getTag(), quote.getFeeling(), quote.getContent())));

        List<String> emotions = new ArrayList<>();
        texts.stream()
                .filter(Objects::nonNull)
                .forEach(text -> emotionKeywords.forEach((emotion, keywords) -> {
                    if (keywords.stream().anyMatch(text::contains)) {
                        emotions.add(emotion);
                    }
                }));
        return emotions;
    }

    private List<AdvancedInsights.RankedText> rankAdvancedTexts(List<String> values, int limit) {
        Map<String, Integer> counts = new LinkedHashMap<>();
        values.stream()
                .filter(value -> value != null && !value.isBlank())
                .map(String::trim)
                .forEach(value -> counts.merge(value, 1, Integer::sum));
        int maxCount = counts.values().stream().max(Integer::compareTo).orElse(0);
        return counts.entrySet().stream()
                .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
                .limit(limit)
                .map(entry -> new AdvancedInsights.RankedText(entry.getKey(), entry.getValue(), maxCount))
                .toList();
    }

    private YearlyReport buildYearlyReport(int year,
                                           List<Anime> animeList,
                                           List<CharacterFavorite> characterList,
                                           List<Quote> quoteList) {
        List<Anime> yearlyAnime = animeList.stream()
                .filter(anime -> hasYear(resolveAnimeTimelineTime(anime), year))
                .toList();
        List<CharacterFavorite> yearlyCharacters = characterList.stream()
                .filter(character -> hasYear(character.getCreateTime(), year))
                .toList();
        List<Quote> yearlyQuotes = quoteList.stream()
                .filter(quote -> hasYear(quote.getCreateTime(), year))
                .toList();

        YearlyReport report = new YearlyReport();
        report.setYear(year);
        report.setAnimeCount(yearlyAnime.size());
        report.setWatchedCount((int) yearlyAnime.stream().filter(this::isWatched).count());
        report.setCharacterCount(yearlyCharacters.size());
        report.setQuoteCount(yearlyQuotes.size());
        report.setAverageScore(calculateAverageScore(yearlyAnime));
        report.setTopType(findMostFrequent(yearlyAnime.stream()
                .map(Anime::getType)
                .filter(value -> value != null && !value.isBlank())
                .toList()));
        report.setTagRanks(rankTexts(yearlyAnime.stream()
                .flatMap(anime -> splitTags(anime.getTags()).stream())
                .toList(), 5));
        report.setTopTag(report.getTagRanks().isEmpty() ? "暂无" : report.getTagRanks().get(0).getText());
        report.setQuoteTagRanks(rankTexts(yearlyQuotes.stream()
                .flatMap(quote -> splitTags(quote.getTag()).stream())
                .toList(), 5));
        report.setMonthlyCounts(buildMonthlyCounts(year, yearlyAnime, yearlyCharacters, yearlyQuotes));
        report.setTopMonth(findTopMonth(report.getMonthlyCounts()));
        report.setHighestScoreAnime(yearlyAnime.stream()
                .filter(anime -> anime.getScore() != null)
                .max(Comparator.comparing(Anime::getScore))
                .orElse(null));
        report.setFavoriteCharacter(yearlyCharacters.stream()
                .filter(character -> character.getFavoriteLevel() != null)
                .max(Comparator.comparing(CharacterFavorite::getFavoriteLevel))
                .orElse(yearlyCharacters.stream().findFirst().orElse(null)));
        report.setMemorableQuote(yearlyQuotes.stream()
                .max(Comparator.comparing(Quote::getCreateTime, Comparator.nullsLast(Comparator.naturalOrder())))
                .orElse(null));
        return report;
    }

    private List<TimelineItem> buildTimeline(List<Anime> animeList,
                                             List<CharacterFavorite> characterList,
                                             List<Quote> quoteList) {
        Map<Long, Anime> animeById = new HashMap<>();
        animeList.forEach(anime -> animeById.put(anime.getId(), anime));

        List<TimelineItem> items = new ArrayList<>();
        animeList.forEach(anime -> {
            TimelineItem item = new TimelineItem();
            item.setType("anime");
            item.setTitle(anime.getTitle());
            item.setSubtitle(compactJoin(
                    anime.getReleaseDate() == null ? null : "上映/开播 " + anime.getReleaseDate(),
                    anime.getStatus(),
                    anime.getType(),
                    anime.getScore() == null ? null : anime.getScore() + " 分"));
            item.setBody(anime.getMemoryText());
            item.setBadge("番剧");
            item.setHref("/anime/" + anime.getId());
            item.setImageUrl(anime.getCoverUrl());
            item.setOccurredAt(resolveAnimeTimelineTime(anime));
            items.add(item);
        });

        characterList.forEach(character -> {
            TimelineItem item = new TimelineItem();
            item.setType("character");
            item.setTitle(character.getCharacterName());
            item.setSubtitle(compactJoin(findAnimeTitle(animeById, character.getAnimeId()),
                    character.getFavoriteLevel() == null ? null : character.getFavoriteLevel() + " 星"));
            item.setBody(character.getReason());
            item.setBadge("角色");
            item.setHref(character.getAnimeId() == null ? "/characters" : "/anime/" + character.getAnimeId());
            item.setImageUrl(character.getImageUrl());
            item.setOccurredAt(character.getCreateTime());
            items.add(item);
        });

        quoteList.forEach(quote -> {
            TimelineItem item = new TimelineItem();
            item.setType("quote");
            item.setTitle(quote.getContent());
            item.setSubtitle(compactJoin(findAnimeTitle(animeById, quote.getAnimeId()), quote.getCharacterName(), quote.getTag()));
            item.setBody(quote.getFeeling());
            item.setBadge("台词");
            item.setHref(quote.getAnimeId() == null ? "/quotes" : "/anime/" + quote.getAnimeId());
            item.setOccurredAt(quote.getCreateTime());
            items.add(item);
        });

        return items.stream()
                .sorted(Comparator.comparing(TimelineItem::getOccurredAt,
                        Comparator.nullsLast(Comparator.reverseOrder())))
                .toList();
    }

    private List<TimelineItem> buildAnimeReleaseTimeline(List<Anime> animeList) {
        List<TimelineItem> items = new ArrayList<>();
        animeList.forEach(anime -> {
            TimelineItem item = new TimelineItem();
            item.setType("anime");
            item.setTitle(anime.getTitle());
            item.setSubtitle(compactJoin(
                    anime.getReleaseDate() == null ? null : "上映/开播 " + anime.getReleaseDate(),
                    anime.getStatus(),
                    anime.getType(),
                    anime.getScore() == null ? null : anime.getScore() + " 分"));
            item.setBody(anime.getMemoryText());
            item.setBadge("番剧");
            item.setHref("/anime/" + anime.getId());
            item.setImageUrl(anime.getCoverUrl());
            item.setOccurredAt(resolveAnimeTimelineTime(anime));
            items.add(item);
        });
        return items.stream()
                .sorted(Comparator.comparing(TimelineItem::getOccurredAt,
                        Comparator.nullsLast(Comparator.naturalOrder())))
                .toList();
    }

    private LocalDateTime resolveAnimeTimelineTime(Anime anime) {
        if (anime.getReleaseDate() != null) {
            return anime.getReleaseDate().atStartOfDay();
        }
        if (anime.getWatchDate() != null) {
            return anime.getWatchDate().atStartOfDay();
        }
        return anime.getCreateTime();
    }

    private List<Integer> findAvailableYears(List<Anime> animeList,
                                             List<CharacterFavorite> characterList,
                                             List<Quote> quoteList) {
        List<Integer> years = new ArrayList<>();
        animeList.stream()
                .map(this::resolveAnimeTimelineTime)
                .filter(Objects::nonNull)
                .map(LocalDateTime::getYear)
                .forEach(year -> addDistinctYear(years, year));
        characterList.stream()
                .map(CharacterFavorite::getCreateTime)
                .filter(Objects::nonNull)
                .map(LocalDateTime::getYear)
                .forEach(year -> addDistinctYear(years, year));
        quoteList.stream()
                .map(Quote::getCreateTime)
                .filter(Objects::nonNull)
                .map(LocalDateTime::getYear)
                .forEach(year -> addDistinctYear(years, year));
        addDistinctYear(years, LocalDate.now().getYear());
        years.sort(Collections.reverseOrder());
        return years;
    }

    private void addDistinctYear(List<Integer> years, Integer year) {
        if (year != null && !years.contains(year)) {
            years.add(year);
        }
    }

    private boolean hasYear(LocalDateTime time, int year) {
        return time != null && time.getYear() == year;
    }

    private BigDecimal calculateAverageScore(List<Anime> animeList) {
        List<BigDecimal> scores = animeList.stream()
                .map(Anime::getScore)
                .filter(Objects::nonNull)
                .toList();
        if (scores.isEmpty()) {
            return null;
        }
        BigDecimal total = scores.stream().reduce(BigDecimal.ZERO, BigDecimal::add);
        return total.divide(BigDecimal.valueOf(scores.size()), 1, RoundingMode.HALF_UP);
    }

    private List<YearlyReport.RankedText> rankTexts(List<String> values, int limit) {
        Map<String, Integer> counts = new LinkedHashMap<>();
        values.stream()
                .filter(value -> value != null && !value.isBlank())
                .map(String::trim)
                .forEach(value -> counts.merge(value, 1, Integer::sum));
        return counts.entrySet().stream()
                .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
                .limit(limit)
                .map(entry -> new YearlyReport.RankedText(entry.getKey(), entry.getValue()))
                .toList();
    }

    private List<YearlyReport.MonthlyCount> buildMonthlyCounts(int year,
                                                               List<Anime> animeList,
                                                               List<CharacterFavorite> characterList,
                                                               List<Quote> quoteList) {
        int[] counts = new int[12];
        animeList.stream().map(this::resolveAnimeTimelineTime).forEach(time -> addMonthCount(counts, time, year));
        characterList.stream().map(CharacterFavorite::getCreateTime).forEach(time -> addMonthCount(counts, time, year));
        quoteList.stream().map(Quote::getCreateTime).forEach(time -> addMonthCount(counts, time, year));
        int maxCount = Arrays.stream(counts).max().orElse(0);
        List<YearlyReport.MonthlyCount> monthlyCounts = new ArrayList<>();
        for (int index = 0; index < counts.length; index++) {
            monthlyCounts.add(new YearlyReport.MonthlyCount(index + 1, counts[index], maxCount));
        }
        return monthlyCounts;
    }

    private void addMonthCount(int[] counts, LocalDateTime time, int year) {
        if (time != null && time.getYear() == year) {
            counts[time.getMonthValue() - 1]++;
        }
    }

    private String findTopMonth(List<YearlyReport.MonthlyCount> monthlyCounts) {
        return monthlyCounts.stream()
                .max(Comparator.comparingInt(YearlyReport.MonthlyCount::getCount))
                .filter(month -> month.getCount() > 0)
                .map(YearlyReport.MonthlyCount::getLabel)
                .orElse("暂无");
    }

    private boolean isWatched(Anime anime) {
        String status = anime.getStatus();
        return status != null && ("看完".equals(status) || "已看完".equals(status));
    }

    private String findAnimeTitle(Map<Long, Anime> animeById, Long animeId) {
        if (animeId == null) {
            return null;
        }
        Anime anime = animeById.get(animeId);
        return anime == null ? "番剧 #" + animeId : anime.getTitle();
    }

    private String compactJoin(String... values) {
        String joined = Arrays.stream(values)
                .filter(value -> value != null && !value.isBlank())
                .reduce((left, right) -> left + " · " + right)
                .orElse(null);
        return joined;
    }

    private String findMostFrequent(List<String> values) {
        Map<String, Integer> counts = new LinkedHashMap<>();
        values.forEach(value -> counts.merge(value.trim(), 1, Integer::sum));
        return counts.entrySet().stream()
                .max(Comparator.comparingInt(Map.Entry::getValue))
                .map(Map.Entry::getKey)
                .orElse("暂无");
    }

    private List<String> splitTags(String tags) {
        if (tags == null || tags.isBlank()) {
            return List.of();
        }
        return Arrays.stream(tags.split("[,，]"))
                .map(String::trim)
                .filter(value -> !value.isEmpty())
                .toList();
    }

    private User getLoginUser(HttpSession session) {
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser instanceof User user) {
            return user;
        }
        return null;
    }

    private record HealthIssue(String type, String title, String message, String href, String level) {
    }

    private record ShareSnippet(Anime anime, String copy, String href) {
    }

    private record ProGoal(String title, int value, String detail) {
    }

    private record ProPlaylist(String title, String description, List<Anime> animeList) {
    }

    private record ProAssetInsight(Anime anime, int score, String level, List<String> strengths, List<String> gaps,
                                   String shareCopy, int characterCount, int quoteCount, String actionHref) {
    }

    private record WatchPlanDay(LocalDate date, int dayNumber, Anime anime, int episodes, String focus, String reason) {
    }

    private record DuplicateGroup(String type, String typeLabel, String key, List<DuplicateItem> items) {
    }

    private record DuplicateItem(Long id, String title, String detail, LocalDateTime time, String href) {
    }
}
