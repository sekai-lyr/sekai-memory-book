SET @quote_video_url_column_exists = (
    SELECT COUNT(1)
    FROM information_schema.columns
    WHERE table_schema = DATABASE()
      AND table_name = 'sekai_memory_book_quote'
      AND column_name = 'video_url'
);

SET @add_quote_video_url_sql = IF(
    @quote_video_url_column_exists = 0,
    'ALTER TABLE sekai_memory_book_quote ADD COLUMN video_url VARCHAR(1000) DEFAULT NULL COMMENT ''台词视频地址'' AFTER tag',
    'SELECT ''video_url column already exists'''
);

PREPARE add_quote_video_url_stmt FROM @add_quote_video_url_sql;
EXECUTE add_quote_video_url_stmt;
DEALLOCATE PREPARE add_quote_video_url_stmt;
