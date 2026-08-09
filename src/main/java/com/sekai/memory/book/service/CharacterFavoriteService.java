package com.sekai.memory.book.service;

import com.sekai.memory.book.model.CharacterFavorite;

import java.util.List;

public interface CharacterFavoriteService {

    List<CharacterFavorite> listByUserId(Long userId);

    List<CharacterFavorite> listByUserId(Long userId, int page, int pageSize);

    int countByUserId(Long userId);

    boolean add(CharacterFavorite characterFavorite);

    boolean update(CharacterFavorite characterFavorite, Long userId);

    boolean delete(Long id, Long userId);
}
