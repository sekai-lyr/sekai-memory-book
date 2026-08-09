package com.sekai.memory.book.service.impl;

import com.sekai.memory.book.dataobject.SekaiMemoryBookAnimeDO;
import com.sekai.memory.book.mapper.SekaiMemoryBookAnimeMapper;
import com.sekai.memory.book.model.Anime;
import com.sekai.memory.book.service.AnimeService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnimeServiceImpl implements AnimeService {

    @Resource
    private SekaiMemoryBookAnimeMapper animeMapper;

    @Override
    public List<Anime> listByUserId(Long userId) {
        if (userId == null) {
            return List.of();
        }
        return AnimeArchiveSorter.sortForArchive(animeMapper.selectByUserId(userId).stream()
                .map(SekaiMemoryBookAnimeDO::convertToAnime)
                .toList());
    }

    @Override
    public List<Anime> listByUserId(Long userId, String keyword, int page, int pageSize) {
        if (userId == null) {
            return List.of();
        }
        int safePage = Math.max(page, 1);
        int safePageSize = Math.min(Math.max(pageSize, 1), 50);
        int offset = (safePage - 1) * safePageSize;
        List<Anime> sortedAnime = AnimeArchiveSorter.sortForArchive(animeMapper
                .selectFilteredByUserId(userId, trimToNull(keyword))
                .stream()
                .map(SekaiMemoryBookAnimeDO::convertToAnime)
                .toList());
        int fromIndex = Math.min(offset, sortedAnime.size());
        int toIndex = Math.min(fromIndex + safePageSize, sortedAnime.size());
        return sortedAnime.subList(fromIndex, toIndex);
    }

    @Override
    public int countByUserId(Long userId, String keyword) {
        if (userId == null) {
            return 0;
        }
        return animeMapper.countByUserId(userId, trimToNull(keyword));
    }

    @Override
    public Anime getByIdAndUserId(Long id, Long userId) {
        if (id == null || userId == null) {
            return null;
        }
        SekaiMemoryBookAnimeDO anime = animeMapper.selectByIdAndUserId(id, userId);
        return anime == null ? null : anime.convertToAnime();
    }

    @Override
    public Anime getById(Long id) {
        if (id == null) {
            return null;
        }
        SekaiMemoryBookAnimeDO anime = animeMapper.selectByPrimaryKey(id);
        return anime == null ? null : anime.convertToAnime();
    }

    @Override
    public boolean add(Anime anime) {
        if (anime == null || anime.getUserId() == null || isBlank(anime.getTitle())) {
            return false;
        }
        normalize(anime);
        return animeMapper.insertSelective(new SekaiMemoryBookAnimeDO(anime)) > 0;
    }

    @Override
    public boolean update(Anime anime, Long userId) {
        if (anime == null || anime.getId() == null || userId == null || isBlank(anime.getTitle())) {
            return false;
        }
        anime.setUserId(userId);
        normalize(anime);
        return animeMapper.updateByIdAndUserId(new SekaiMemoryBookAnimeDO(anime)) > 0;
    }

    @Override
    public boolean delete(Long id, Long userId) {
        if (id == null || userId == null) {
            return false;
        }
        return animeMapper.deleteByIdAndUserId(id, userId) > 0;
    }

    private void normalize(Anime anime) {
        anime.setTitle(trimToNull(anime.getTitle()));
        anime.setType(trimToNull(anime.getType()));
        anime.setStatus(trimToNull(anime.getStatus()));
        anime.setCoverUrl(trimToNull(anime.getCoverUrl()));
        anime.setMemoryText(trimToNull(anime.getMemoryText()));
        anime.setTags(normalizeTags(anime.getTags()));
        if (anime.getTotalEpisodes() != null && anime.getTotalEpisodes() < 0) {
            anime.setTotalEpisodes(null);
        }
        if (anime.getCurrentEpisode() != null && anime.getCurrentEpisode() < 0) {
            anime.setCurrentEpisode(null);
        }
        if (anime.getTotalEpisodes() != null && anime.getCurrentEpisode() != null
                && anime.getCurrentEpisode() > anime.getTotalEpisodes()) {
            anime.setCurrentEpisode(anime.getTotalEpisodes());
        }
        if (anime.getReleaseDate() != null && anime.getWatchDate() == null) {
            anime.setWatchDate(anime.getReleaseDate());
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private String trimToNull(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    private String normalizeTags(String value) {
        String trimmed = trimToNull(value);
        if (trimmed == null) {
            return null;
        }
        return trimmed.replace('\uFF0C', ',').replaceAll("\\s*,\\s*", ", ");
    }
}