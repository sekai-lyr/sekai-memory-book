USE sekai_friend;

SET @schema_name = DATABASE();

SET @sql = (
    SELECT IF(
        COUNT(*) = 0,
        'ALTER TABLE sekai_memory_book_anime ADD COLUMN total_episodes INT DEFAULT NULL COMMENT ''总集数''',
        'SELECT 1'
    )
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = @schema_name
      AND TABLE_NAME = 'sekai_memory_book_anime'
      AND COLUMN_NAME = 'total_episodes'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @sql = (
    SELECT IF(
        COUNT(*) = 0,
        'ALTER TABLE sekai_memory_book_anime ADD COLUMN current_episode INT DEFAULT NULL COMMENT ''当前看到第几集''',
        'SELECT 1'
    )
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = @schema_name
      AND TABLE_NAME = 'sekai_memory_book_anime'
      AND COLUMN_NAME = 'current_episode'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @sql = (
    SELECT IF(
        COUNT(*) = 0,
        'ALTER TABLE sekai_memory_book_anime ADD COLUMN last_watch_date DATE DEFAULT NULL COMMENT ''最近观看日期''',
        'SELECT 1'
    )
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = @schema_name
      AND TABLE_NAME = 'sekai_memory_book_anime'
      AND COLUMN_NAME = 'last_watch_date'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
