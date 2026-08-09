package com.sekai.memory.book.service.impl;

import com.sekai.memory.book.dataobject.SekaiMemoryBookCharacterFavoriteDO;
import com.sekai.memory.book.mapper.SekaiMemoryBookCharacterFavoriteMapper;
import com.sekai.memory.book.model.CharacterFavorite;
import com.sekai.memory.book.service.CharacterFavoriteService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CharacterFavoriteServiceImpl implements CharacterFavoriteService {

    @Resource
    private SekaiMemoryBookCharacterFavoriteMapper characterFavoriteMapper;

    @Override
    public List<CharacterFavorite> listByUserId(Long userId) {
        return characterFavoriteMapper.selectByUserId(userId).stream()
                .map(SekaiMemoryBookCharacterFavoriteDO::convertToCharacterFavorite)
                .toList();
    }

    @Override
    public List<CharacterFavorite> listByUserId(Long userId, int page, int pageSize) {
        if (userId == null) {
            return List.of();
        }
        int safePage = Math.max(page, 1);
        int safePageSize = Math.min(Math.max(pageSize, 1), 50);
        int offset = (safePage - 1) * safePageSize;
        return characterFavoriteMapper.selectPageByUserId(userId, offset, safePageSize).stream()
                .map(SekaiMemoryBookCharacterFavoriteDO::convertToCharacterFavorite)
                .toList();
    }

    @Override
    public int countByUserId(Long userId) {
        if (userId == null) {
            return 0;
        }
        return characterFavoriteMapper.countByUserId(userId);
    }

    @Override
    public boolean add(CharacterFavorite characterFavorite) {
        if (characterFavorite == null || characterFavorite.getUserId() == null
                || isBlank(characterFavorite.getCharacterName())) {
            return false;
        }
        normalize(characterFavorite);
        return characterFavoriteMapper.insertSelective(new SekaiMemoryBookCharacterFavoriteDO(characterFavorite)) > 0;
    }

    @Override
    public boolean update(CharacterFavorite characterFavorite, Long userId) {
        if (characterFavorite == null || characterFavorite.getId() == null || userId == null
                || isBlank(characterFavorite.getCharacterName())) {
            return false;
        }
        characterFavorite.setUserId(userId);
        normalize(characterFavorite);
        return characterFavoriteMapper.updateByIdAndUserId(new SekaiMemoryBookCharacterFavoriteDO(characterFavorite)) > 0;
    }

    @Override
    public boolean delete(Long id, Long userId) {
        if (id == null || userId == null) {
            return false;
        }
        return characterFavoriteMapper.deleteByIdAndUserId(id, userId) > 0;
    }

    private void normalize(CharacterFavorite characterFavorite) {
        characterFavorite.setCharacterName(trimToNull(characterFavorite.getCharacterName()));
        characterFavorite.setImageUrl(trimToNull(characterFavorite.getImageUrl()));
        characterFavorite.setReason(trimToNull(characterFavorite.getReason()));
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
}
