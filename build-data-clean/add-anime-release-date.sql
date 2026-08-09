USE sekai_friend;

SET @schema_name = DATABASE();

SET @sql = (
    SELECT IF(
        COUNT(*) = 0,
        'ALTER TABLE sekai_memory_book_anime ADD COLUMN release_date DATE DEFAULT NULL上映/开播日�?'',
        'SELECT 1'
    )
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = @schema_name
      AND TABLE_NAME = 'sekai_memory_book_anime'
      AND COLUMN_NAME = 'release_date'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

UPDATE sekai_memory_book_anime SET release_date = '2024-04-07' WHERE id = 1;
UPDATE sekai_memory_book_anime SET release_date = '2022-07-13' WHERE id = 3;
UPDATE sekai_memory_book_anime SET release_date = '2024-07-14' WHERE id = 4;
UPDATE sekai_memory_book_anime SET release_date = '2018-10-06' WHERE id = 5;
UPDATE sekai_memory_book_anime SET release_date = '2017-01-05' WHERE id = 6;
UPDATE sekai_memory_book_anime SET release_date = '2023-07-03' WHERE id = 7;
UPDATE sekai_memory_book_anime SET release_date = '2019-07-19' WHERE id = 9;
UPDATE sekai_memory_book_anime SET release_date = '2016-08-26' WHERE id = 10;
UPDATE sekai_memory_book_anime SET release_date = '2013-05-31' WHERE id = 11;
UPDATE sekai_memory_book_anime SET release_date = '2007-03-03' WHERE id = 12;
UPDATE sekai_memory_book_anime SET release_date = '2015-04-05' WHERE id = 13;
UPDATE sekai_memory_book_anime SET release_date = '2018-09-01' WHERE id = 14;
UPDATE sekai_memory_book_anime SET release_date = '2021-10-01' WHERE id = 15;
UPDATE sekai_memory_book_anime SET release_date = '2026-01-22' WHERE id = 16;
UPDATE sekai_memory_book_anime SET release_date = '2025-10-12' WHERE id = 17;
UPDATE sekai_memory_book_anime SET release_date = '2025-01-17' WHERE id = 22;
UPDATE sekai_memory_book_anime SET release_date = '2023-06-29' WHERE id = 23;
UPDATE sekai_memory_book_anime SET release_date = '2014-04-09' WHERE id = 24;
UPDATE sekai_memory_book_anime SET release_date = '2013-04-05' WHERE id = 25;
UPDATE sekai_memory_book_anime SET release_date = '2015-04-03' WHERE id = 26;
UPDATE sekai_memory_book_anime SET release_date = '2020-07-10' WHERE id = 27;
UPDATE sekai_memory_book_anime SET release_date = '2021-01-10' WHERE id = 28;
UPDATE sekai_memory_book_anime SET release_date = '2023-07-01' WHERE id = 29;
UPDATE sekai_memory_book_anime SET release_date = '2023-10-07' WHERE id = 30;
UPDATE sekai_memory_book_anime SET release_date = '2025-04-07' WHERE id = 31;
UPDATE sekai_memory_book_anime SET release_date = '2022-07-02' WHERE id = 32;
UPDATE sekai_memory_book_anime SET release_date = '2022-04-10' WHERE id = 33;
UPDATE sekai_memory_book_anime SET release_date = '2022-11-11' WHERE id = 34;
UPDATE sekai_memory_book_anime SET release_date = '2022-09-09' WHERE id = 35;
UPDATE sekai_memory_book_anime SET release_date = '2017-07-15' WHERE id = 36;
UPDATE sekai_memory_book_anime SET release_date = '2016-09-17' WHERE id = 37;
UPDATE sekai_memory_book_anime SET release_date = '2014-04-26' WHERE id = 38;

