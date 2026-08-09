USE sekai_friend;

-- Keep the anime watch dates for the user whose nickname is "sekai"
-- aligned with each title's first air/release date.
UPDATE sekai_memory_book_anime a
JOIN sekai_memory_book_user u ON u.id = a.user_id
SET a.watch_date = '2022-11-11'
WHERE u.nickname = 'sekai'
  AND (a.title LIKE '%Suzume%' OR a.title LIKE '%铃芽%' OR a.title LIKE '%鈴芽%' OR a.title LIKE '%すずめ%');

UPDATE sekai_memory_book_anime a
JOIN sekai_memory_book_user u ON u.id = a.user_id
SET a.watch_date = '2021-01-10'
WHERE u.nickname = 'sekai'
  AND (a.title LIKE '%Horimiya%' OR a.title LIKE '%堀与宫村%' OR a.title LIKE '%堀與宮村%' OR a.title LIKE '%ホリミヤ%');

UPDATE sekai_memory_book_anime a
JOIN sekai_memory_book_user u ON u.id = a.user_id
SET a.watch_date = '2023-07-01'
WHERE u.nickname = 'sekai'
  AND (a.title LIKE '%Horimiya: Piece%' OR a.title LIKE '%Missing Pieces%' OR a.title LIKE '%-piece-%' OR a.title LIKE '%ホリミヤ -piece-%');

UPDATE sekai_memory_book_anime a
JOIN sekai_memory_book_user u ON u.id = a.user_id
SET a.watch_date = '2022-07-02'
WHERE u.nickname = 'sekai'
  AND (a.title LIKE '%Lycoris Recoil%' OR a.title LIKE '%LycoReco%' OR a.title LIKE '%莉可丽丝%' OR a.title LIKE '%莉可麗絲%' OR a.title LIKE '%リコリス%');

UPDATE sekai_memory_book_anime a
JOIN sekai_memory_book_user u ON u.id = a.user_id
SET a.watch_date = '2025-04-07'
WHERE u.nickname = 'sekai'
  AND a.title LIKE '%Summer Pockets%';

UPDATE sekai_memory_book_anime a
JOIN sekai_memory_book_user u ON u.id = a.user_id
SET a.watch_date = '2016-09-17'
WHERE u.nickname = 'sekai'
  AND (a.title LIKE '%Koe no Katachi%' OR a.title LIKE '%A Silent Voice%' OR a.title LIKE '%声之形%' OR a.title LIKE '%聲の形%');

UPDATE sekai_memory_book_anime a
JOIN sekai_memory_book_user u ON u.id = a.user_id
SET a.watch_date = '2023-10-07'
WHERE u.nickname = 'sekai'
  AND (a.title LIKE '%Hametsu no Oukoku%' OR a.title LIKE '%Kingdoms of Ruin%' OR a.title LIKE '%破灭之国%' OR a.title LIKE '%破滅之國%' OR a.title LIKE '%はめつのおうこく%');

UPDATE sekai_memory_book_anime a
JOIN sekai_memory_book_user u ON u.id = a.user_id
SET a.watch_date = '2014-04-26'
WHERE u.nickname = 'sekai'
  AND (a.title LIKE '%Tamako Love Story%' OR a.title LIKE '%玉子爱情故事%' OR a.title LIKE '%玉子愛情故事%' OR a.title LIKE '%たまこラブストーリー%');

UPDATE sekai_memory_book_anime a
JOIN sekai_memory_book_user u ON u.id = a.user_id
SET a.watch_date = '2023-06-29'
WHERE u.nickname = 'sekai'
  AND (a.title LIKE '%BanG Dream! It''s MyGO%' OR a.title LIKE '%BanG Dream It''s MyGO%' OR a.title LIKE '%MyGO%');

UPDATE sekai_memory_book_anime a
JOIN sekai_memory_book_user u ON u.id = a.user_id
SET a.watch_date = '2017-07-15'
WHERE u.nickname = 'sekai'
  AND (a.title LIKE '%No Game No Life%Zero%' OR a.title LIKE '%No Game, No Life%Zero%' OR a.title LIKE '%游戏人生%零%' OR a.title LIKE '%遊戲人生%零%' OR a.title LIKE '%ノーゲーム%ゼロ%');

UPDATE sekai_memory_book_anime a
JOIN sekai_memory_book_user u ON u.id = a.user_id
SET a.watch_date = '2022-04-10'
WHERE u.nickname = 'sekai'
  AND (a.title LIKE '%Shikimori%' OR a.title LIKE '%式守%' OR a.title LIKE '%可愛いだけじゃない式守さん%');

UPDATE sekai_memory_book_anime a
JOIN sekai_memory_book_user u ON u.id = a.user_id
SET a.watch_date = '2022-09-09'
WHERE u.nickname = 'sekai'
  AND (a.title LIKE '%Natsu e no Tunnel%' OR a.title LIKE '%Tunnel to Summer%' OR a.title LIKE '%夏へのトンネル%' OR a.title LIKE '%通往夏天的隧道%');

UPDATE sekai_memory_book_anime a
JOIN sekai_memory_book_user u ON u.id = a.user_id
SET a.watch_date = '2025-01-17'
WHERE u.nickname = 'sekai'
  AND (a.title LIKE '%Project Sekai%' OR a.title LIKE '%Project SEKAI%' OR a.title LIKE '%Kowareta Sekai%' OR a.title LIKE '%世界计划%' OR a.title LIKE '%世界計畫%');

UPDATE sekai_memory_book_anime a
JOIN sekai_memory_book_user u ON u.id = a.user_id
SET a.watch_date = '2013-04-05'
WHERE u.nickname = 'sekai'
  AND (a.title LIKE '%Yahari Ore no Seishun Love Comedy wa Machigatteiru%' OR a.title LIKE '%My Teen Romantic Comedy SNAFU%' OR a.title LIKE '%Oregairu%' OR a.title LIKE '%俺ガイル%' OR a.title LIKE '%青春恋爱喜剧%');

UPDATE sekai_memory_book_anime a
JOIN sekai_memory_book_user u ON u.id = a.user_id
SET a.watch_date = '2015-04-03'
WHERE u.nickname = 'sekai'
  AND (a.title LIKE '%Yahari Ore no Seishun Love Comedy wa Machigatteiru%Zoku%' OR a.title LIKE '%My Teen Romantic Comedy SNAFU%TOO%' OR a.title LIKE '%Oregairu%Zoku%' OR a.title LIKE '%俺ガイル%続%' OR a.title LIKE '%青春恋爱喜剧%续%');
