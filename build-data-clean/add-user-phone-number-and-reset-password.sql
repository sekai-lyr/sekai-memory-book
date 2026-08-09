USE sekai_friend;
SET NAMES utf8mb4;

SET @phone_column_exists := (
    SELECT COUNT(1)
    FROM information_schema.columns
    WHERE table_schema = DATABASE()
      AND table_name = 'sekai_memory_book_user'
      AND column_name = 'phone_number'
);

SET @add_phone_column_sql := IF(
        @phone_column_exists = 0,
        'ALTER TABLE sekai_memory_book_user ADD COLUMN phone_number VARCHAR(20) DEFAULT NULL手机号'' AFTER avatar',
        'SELECT 1'
    );
PREPARE add_phone_column_stmt FROM @add_phone_column_sql;
EXECUTE add_phone_column_stmt;
DEALLOCATE PREPARE add_phone_column_stmt;

SET @phone_index_exists := (
    SELECT COUNT(1)
    FROM information_schema.statistics
    WHERE table_schema = DATABASE()
      AND table_name = 'sekai_memory_book_user'
      AND index_name = 'uk_sekai_memory_book_user_phone_number'
);

SET @add_phone_index_sql := IF(
        @phone_index_exists = 0,
        'ALTER TABLE sekai_memory_book_user ADD UNIQUE KEY uk_sekai_memory_book_user_phone_number (phone_number)',
        'SELECT 1'
    );
PREPARE add_phone_index_stmt FROM @add_phone_index_sql;
EXECUTE add_phone_index_stmt;
DEALLOCATE PREPARE add_phone_index_stmt;

UPDATE sekai_memory_book_user
SET phone_number = '18652929653'
WHERE username = 'sekai';
