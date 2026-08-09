package com.sekai.memory.book.service;

import com.sekai.memory.book.model.Anime;

import java.util.List;

public interface AnimeService {

    List<Anime> listByUserId(Long userId);

    List<Anime> listByUserId(Long userId, String keyword, int page, int pageSize);

    int countByUserId(Long userId, String keyword);

    Anime getByIdAndUserId(Long id, Long userId);

    Anime getById(Long id);

    boolean add(Anime anime);

    boolean update(Anime anime, Long userId);

    boolean delete(Long id, Long userId);
}
