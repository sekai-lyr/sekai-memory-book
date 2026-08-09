package com.sekai.memory.book.service.impl;

import com.sekai.memory.book.dataobject.SekaiMemoryBookQuoteDO;
import com.sekai.memory.book.mapper.SekaiMemoryBookQuoteMapper;
import com.sekai.memory.book.model.Quote;
import com.sekai.memory.book.service.QuoteService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.net.URI;
import java.util.Locale;
import java.util.List;

@Service
public class QuoteServiceImpl implements QuoteService {

    @Resource
    private SekaiMemoryBookQuoteMapper quoteMapper;

    @Override
    public List<Quote> listByUserId(Long userId) {
        return quoteMapper.selectByUserId(userId).stream()
                .map(SekaiMemoryBookQuoteDO::convertToQuote)
                .toList();
    }

    @Override
    public List<Quote> listByUserId(Long userId, int page, int pageSize) {
        if (userId == null) {
            return List.of();
        }
        int safePage = Math.max(page, 1);
        int safePageSize = Math.min(Math.max(pageSize, 1), 50);
        int offset = (safePage - 1) * safePageSize;
        return quoteMapper.selectPageByUserId(userId, offset, safePageSize).stream()
                .map(SekaiMemoryBookQuoteDO::convertToQuote)
                .toList();
    }

    @Override
    public int countByUserId(Long userId) {
        if (userId == null) {
            return 0;
        }
        return quoteMapper.countByUserId(userId);
    }

    @Override
    public boolean add(Quote quote) {
        if (quote == null || quote.getUserId() == null || isBlank(quote.getContent())) {
            return false;
        }
        normalize(quote);
        return quoteMapper.insertSelective(new SekaiMemoryBookQuoteDO(quote)) > 0;
    }

    @Override
    public boolean update(Quote quote, Long userId) {
        if (quote == null || quote.getId() == null || userId == null || isBlank(quote.getContent())) {
            return false;
        }
        quote.setUserId(userId);
        normalize(quote);
        return quoteMapper.updateByIdAndUserId(new SekaiMemoryBookQuoteDO(quote)) > 0;
    }

    @Override
    public boolean delete(Long id, Long userId) {
        if (id == null || userId == null) {
            return false;
        }
        return quoteMapper.deleteByIdAndUserId(id, userId) > 0;
    }

    private void normalize(Quote quote) {
        quote.setContent(trimToNull(quote.getContent()));
        quote.setCharacterName(trimToNull(quote.getCharacterName()));
        quote.setFeeling(trimToNull(quote.getFeeling()));
        quote.setTag(trimToNull(quote.getTag()));
        quote.setVideoUrl(normalizeVideoUrl(quote.getVideoUrl()));
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

    private String normalizeVideoUrl(String value) {
        String trimmed = trimToNull(value);
        if (trimmed == null) {
            return null;
        }
        if (trimmed.startsWith("/uploads/quote-videos/")) {
            return trimmed;
        }
        try {
            URI uri = URI.create(trimmed);
            String scheme = uri.getScheme();
            if (scheme == null) {
                return null;
            }
            String lowerScheme = scheme.toLowerCase(Locale.ROOT);
            return ("http".equals(lowerScheme) || "https".equals(lowerScheme)) ? trimmed : null;
        } catch (IllegalArgumentException ex) {
            return null;
        }
    }
}
