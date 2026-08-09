package com.sekai.memory.book.service;

import com.sekai.memory.book.model.Quote;

import java.util.List;

public interface QuoteService {

    List<Quote> listByUserId(Long userId);

    List<Quote> listByUserId(Long userId, int page, int pageSize);

    int countByUserId(Long userId);

    boolean add(Quote quote);

    boolean update(Quote quote, Long userId);

    boolean delete(Long id, Long userId);
}
