USE sekai_friend;

SET @tags_column_exists = (
    SELECT COUNT(1)
    FROM information_schema.columns
    WHERE table_schema = 'sekai_friend'
      AND table_name = 'sekai_memory_book_anime'
      AND column_name = 'tags'
);

SET @add_tags_sql = IF(
    @tags_column_exists = 0,
    'ALTER TABLE sekai_memory_book_anime ADD COLUMN tags VARCHAR(255) DEFAULT NULL标签，用逗号分隔'' AFTER memory_text',
    'SELECT ''tags column already exists'''
);

PREPARE add_tags_stmt FROM @add_tags_sql;
EXECUTE add_tags_stmt;
DEALLOCATE PREPARE add_tags_stmt;
