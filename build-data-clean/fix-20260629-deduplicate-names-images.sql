-- Remove duplicate character/anime records and replace duplicate anime covers.
-- Run with: mysql --default-character-set=utf8mb4 -uroot -p123456 sekai_friend < build-data/fix-20260629-deduplicate-names-images.sql

-- Move related records before deleting duplicated anime rows.
UPDATE sekai_memory_book_quote SET anime_id = 220 WHERE anime_id = 285;
UPDATE sekai_memory_book_quote SET anime_id = 211 WHERE anime_id = 287;
UPDATE sekai_memory_book_character_favorite SET anime_id = 220 WHERE anime_id = 285;
UPDATE sekai_memory_book_character_favorite SET anime_id = 211 WHERE anime_id = 287;

-- Delete duplicated anime rows for the same works.
DELETE FROM sekai_memory_book_anime WHERE user_id = 3 AND id IN (285, 287);

-- Delete duplicated character rows, keeping the earliest id for each character name.
DELETE FROM sekai_memory_book_character_favorite
WHERE user_id = 3
  AND id IN (
      637,645,683,762,763,765,774,777,778,784,785,790,791,792,793,795,796,
      797,798,799,806,807,808,812,824,825,829,830,831,839,1075,1076,1077,
      1079,1080,1081,1082,1083,1084,1085,1086,1087,1088,1090,1091,1092,
      1093,1094,1095,1097,1098,1099,1100,1102,1103,1104,1106,1108,1109,
      1110,1111,1112,1113,1114,1115,1120,1123
  );

-- Replace duplicated anime cover images with distinct verified online images.
UPDATE sekai_memory_book_anime
SET cover_url = 'https://cdn.myanimelist.net/images/anime/1799/155847.jpg?s=f38ad8dc345eaffc5480dd42ecbf236d'
WHERE user_id = 3 AND id = 49;

UPDATE sekai_memory_book_anime
SET cover_url = 'https://cdn.myanimelist.net/images/anime/1393/156075.jpg?s=e2738ea5ead34899e5036f618677353c'
WHERE user_id = 3 AND id = 165;

UPDATE sekai_memory_book_anime
SET cover_url = 'https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx21355-wRVUrGxpvIQQ.jpg'
WHERE user_id = 3 AND id = 168;

-- Replace normalized duplicate images that point to the same underlying artwork.
UPDATE sekai_memory_book_anime
SET cover_url = 'https://cdn.myanimelist.net/images/anime/1659/154920.jpg?s=b5ef5efc88dc0580c9111b11f9a9c5a4'
WHERE user_id = 3 AND id = 151;

UPDATE sekai_memory_book_character_favorite
SET image_url = 'https://s4.anilist.co/file/anilistcdn/character/large/b36765-BnLbXg0Tzzh9.png'
WHERE user_id = 3 AND id = 1117;

UPDATE sekai_memory_book_character_favorite
SET image_url = 'https://s4.anilist.co/file/anilistcdn/character/large/b36828-j5ib0adAzGMx.png'
WHERE user_id = 3 AND id = 1118;
