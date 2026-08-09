package com.sekai.memory.book.service.impl;

import com.sekai.memory.book.model.Anime;
import org.junit.jupiter.api.Test;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

class AnimeArchiveSorterTest {

    @Test
    void shouldSortByAnimeTimelineTimeFirst() {
        Anime firstSeason = anime(1L, "Archive Story", "2015-04-01", null);
        Anime secondSeason = anime(2L, "Archive Story \u7B2C\u4E8C\u5B63", "2024-04-01", null);
        Anime other = anime(3L, "Middle Show", "2020-04-01", null);
        Anime oldest = anime(4L, "Old Show", "2010-04-01", null);

        List<String> titles = AnimeArchiveSorter.sortForArchive(List.of(secondSeason, other, oldest, firstSeason))
                .stream()
                .map(Anime::getTitle)
                .toList();

        assertEquals(List.of("Old Show", "Archive Story", "Middle Show", "Archive Story \u7B2C\u4E8C\u5B63"), titles);
    }

    @Test
    void taggedSeriesShouldSortByReleaseTimeInsideTheGroup() {
        Anime movie = anime(3L,
                "\u8F89\u591C\u5927\u5C0F\u59D0\u60F3\u8BA9\u6211\u544A\u767D\uFF1A\u521D\u543B\u4E0D\u4F1A\u7ED3\u675F",
                "2022-12-17",
                "\u7CFB\u5217:\u8F89\u591C\u5927\u5C0F\u59D0,\u604B\u7231");
        Anime thirdSeason = anime(2L,
                "\u8F89\u591C\u5927\u5C0F\u59D0\u60F3\u8BA9\u6211\u544A\u767D-\u8D85\u7EA7\u6D6A\u6F2B- \u7B2C\u4E09\u5B63",
                "2022-04-09",
                "\u7CFB\u5217:\u8F89\u591C\u5927\u5C0F\u59D0,\u604B\u7231");
        Anime secondSeason = anime(1L,
                "\u8F89\u591C\u5927\u5C0F\u59D0\u60F3\u8BA9\u6211\u544A\u767D\uFF1F\u7B2C\u4E8C\u5B63",
                "2020-04-11",
                "\u7CFB\u5217:\u8F89\u591C\u5927\u5C0F\u59D0,\u604B\u7231");

        List<String> titles = AnimeArchiveSorter.sortForArchive(List.of(movie, thirdSeason, secondSeason))
                .stream()
                .map(Anime::getTitle)
                .toList();

        assertEquals(List.of(secondSeason.getTitle(), thirdSeason.getTitle(), movie.getTitle()), titles);
    }

    @Test
    void updateTimeShouldNotMoveEditedAnimeToTheFront() {
        Anime edited = anime(1L, "Stable Archive A", null, null);
        edited.setCreateTime(LocalDateTime.of(2020, 1, 1, 0, 0));
        edited.setUpdateTime(LocalDateTime.of(2026, 1, 1, 0, 0));
        Anime next = anime(2L, "Stable Archive B", null, null);
        next.setCreateTime(LocalDateTime.of(2021, 1, 1, 0, 0));
        next.setUpdateTime(LocalDateTime.of(2021, 1, 1, 0, 0));

        List<String> titles = AnimeArchiveSorter.sortForArchive(List.of(next, edited))
                .stream()
                .map(Anime::getTitle)
                .toList();

        assertEquals(List.of("Stable Archive A", "Stable Archive B"), titles);
    }

    private static Anime anime(Long id, String title, String releaseDate, String tags) {
        Anime anime = new Anime();
        anime.setId(id);
        anime.setTitle(title);
        anime.setType("TV");
        if (releaseDate != null) {
            anime.setReleaseDate(LocalDate.parse(releaseDate));
        }
        anime.setTags(tags);
        return anime;
    }
}
