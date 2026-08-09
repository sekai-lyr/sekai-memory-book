USE sekai_friend;
SET NAMES utf8mb4;

SET @sekai_user_id := (SELECT id FROM sekai_memory_book_user WHERE username = 'sekai' LIMIT 1);
SET @watched_on := '2026-05-12';

CREATE TEMPORARY TABLE seed_20260512_more_anime (
    title VARCHAR(100) NOT NULL,
    type VARCHAR(100),
    status VARCHAR(20),
    score DECIMAL(3,1),
    cover_url VARCHAR(1000),
    watch_date DATE,
    release_date DATE,
    total_episodes INT,
    current_episode INT,
    last_watch_date DATE,
    tags VARCHAR(255)
);

INSERT INTO seed_20260512_more_anime
(title, type, status, score, cover_url, watch_date, release_date, total_episodes, current_episode, last_watch_date, tags)
VALUES
('烟花', '日本/动画,剧情', '看完', 10.0, 'https://myanimelist.net/images/anime/10/86521l.jpg', @watched_on, '2017-08-18', 1, 1, @watched_on, '动画,剧情'),
('刀剑神域：序列之争剧场版', '日本/科幻,动作,动画', '看完', 10.0, 'https://myanimelist.net/images/anime/1557/123313l.jpg', @watched_on, '2017-02-18', 1, 1, @watched_on, '科幻,动作,动画'),
('BanG Dream! Episode of Roselia I: 约定', '日本/动画,青春,音乐', '看完', 10.0, 'https://myanimelist.net/images/anime/1867/119189l.jpg', @watched_on, '2021-04-23', 1, 1, @watched_on, '动画,青春,音乐'),
('黑子的篮球剧场版：LAST GAME', '日本/动作,动画,运动', '看完', 10.0, 'https://myanimelist.net/images/anime/2/83106l.jpg', @watched_on, '2017-03-18', 1, 1, @watched_on, '动作,动画,运动'),
('轻音少女', '日本/搞笑,冒险,青春,校园,治愈,励志,美少女', '看完', 10.0, 'https://myanimelist.net/images/anime/10/76120l.jpg', @watched_on, '2009-04-03', 14, 14, @watched_on, '搞笑,青春,校园,治愈,音乐'),
('轻音少女 第二季', '日本/搞笑,冒险,青春,校园,治愈,励志,美少女', '看完', 10.0, 'https://myanimelist.net/images/anime/10/76120l.jpg', @watched_on, '2010-04-07', 27, 27, @watched_on, '搞笑,青春,校园,治愈,音乐'),
('轻音少女 剧场版', '日本/爱情,动画,青春', '看完', 10.0, 'https://myanimelist.net/images/anime/5/76233l.jpg', @watched_on, '2011-12-03', 1, 1, @watched_on, '动画,青春,音乐'),
('孤独摇滚！', '日本/奇幻', '看完', 10.0, 'https://myanimelist.net/images/anime/1448/127956l.jpg', @watched_on, '2022-10-09', 12, 12, @watched_on, '音乐,搞笑,日常,青春'),
('吹响！上低音号', '日本/校园,治愈,励志,百合', '看完', 10.0, 'https://myanimelist.net/images/anime/1517/142072l.jpg', @watched_on, '2015-04-08', 13, 13, @watched_on, '校园,治愈,励志,音乐'),
('吹响！上低音号第二季', '日本/校园,治愈,励志,百合', '看完', 10.0, 'https://myanimelist.net/images/anime/10/81155l.jpg', @watched_on, '2016-10-06', 13, 13, @watched_on, '校园,治愈,励志,音乐'),
('吹响！上低音号第三季', '日本/日常,校园,百合,青春,励志', '看完', 1.0, 'https://myanimelist.net/images/anime/1216/142086l.jpg', @watched_on, '2024-04-07', 13, 13, @watched_on, '日常,校园,百合,青春,励志,音乐'),
('吹响！上低音号剧场版合集', '日本/校园,治愈,励志,百合', '看完', 10.0, 'https://myanimelist.net/images/anime/8/81156l.jpg', @watched_on, '2016-04-23', 4, 4, @watched_on, '校园,治愈,励志,音乐,剧场版'),
('金牌得主', '日本/运动,励志,竞技,漫画改,热血,萝莉', '看完', 10.0, 'https://myanimelist.net/images/anime/1029/146850l.jpg', @watched_on, '2025-01-05', 13, 13, @watched_on, '运动,励志,竞技,热血'),
('金牌得主 第二季', '日本/热血,竞技,励志,运动,萝莉,漫画改', '看完', 10.0, 'https://myanimelist.net/images/anime/1828/155038l.jpg', @watched_on, '2026-01-01', 9, 9, @watched_on, '运动,励志,竞技,热血'),
('想吃掉我的非人少女', '日本/奇幻,百合,漫画改', '看完', 10.0, 'https://myanimelist.net/images/anime/1191/152368l.jpg', @watched_on, '2025-10-02', 13, 13, @watched_on, '奇幻,百合,漫画改'),
('关于我在无意间被隔壁的天使变成废柴这件事', '日本/恋爱,校园', '看完', 10.0, 'https://myanimelist.net/images/anime/1240/133638l.jpg', @watched_on, '2023-01-07', 12, 12, @watched_on, '恋爱,校园,日常'),
('关于我在无意间被隔壁的天使变成废柴这件事 第二季', '日本/校园,日常,恋爱,轻小说改', '看完', 10.0, 'https://myanimelist.net/images/anime/1989/154843l.jpg', @watched_on, '2026-04-03', 6, 6, @watched_on, '校园,日常,恋爱,轻小说改'),
('欢迎来到实力至上主义教室第四季', '日本/校园,后宫,恋爱,轻小说改', '看完', 10.0, 'https://myanimelist.net/images/anime/1176/153626l.jpg', @watched_on, '2026-01-01', 9, 9, @watched_on, '校园,后宫,恋爱,轻小说改'),
('咒术回战 第三季', '日本/奇幻,热血,战斗,搞笑,漫画改', '看完', 10.0, 'https://myanimelist.net/images/anime/1171/109222l.jpg', @watched_on, '2026-01-01', 12, 12, @watched_on, '奇幻,热血,战斗,漫画改'),
('杖与剑的魔剑谭 第二季', '日本/奇幻,热血,战斗,异世界,后宫,漫画改', '看完', 10.0, 'https://myanimelist.net/images/anime/1190/155788l.jpg', @watched_on, '2026-01-01', 5, 5, @watched_on, '奇幻,热血,战斗,漫画改'),
('夜樱家的大作战 第二季', '日本/搞笑,恋爱,战斗,漫画改', '看完', 10.0, 'https://myanimelist.net/images/anime/1230/155783l.jpg', @watched_on, '2026-01-01', 5, 5, @watched_on, '搞笑,恋爱,战斗,漫画改'),
('魔法少女与恶曾是敌人', '日本/奇幻,恋爱,搞笑,魔法', '看完', 10.0, 'https://myanimelist.net/images/anime/1653/143959l.jpg', @watched_on, '2024-07-09', 12, 12, @watched_on, '奇幻,恋爱,搞笑,魔法'),
('Love Live!', '日本/搞笑,青春,校园,励志,美少女', '看完', 10.0, 'https://myanimelist.net/images/anime/11/56849l.jpg', @watched_on, '2013-01-06', 13, 13, @watched_on, '偶像,校园,励志,音乐'),
('Love Live!第二季', '日本/搞笑,青春,校园,励志,美少女', '看完', 10.0, 'https://myanimelist.net/images/anime/10/59101l.jpg', @watched_on, '2014-04-06', 13, 13, @watched_on, '偶像,校园,励志,音乐'),
('Love Live! 虹咲学园校园偶像同好会', '日本/校园,励志,百合', '看完', 10.0, 'https://myanimelist.net/images/anime/1393/109203l.jpg', @watched_on, '2020-10-03', 13, 13, @watched_on, '偶像,校园,励志,百合'),
('Love Live! Superstar!!', '日本/校园,励志,百合', '看完', 10.0, 'https://myanimelist.net/images/anime/1758/115692l.jpg', @watched_on, '2021-07-11', 12, 12, @watched_on, '偶像,校园,励志,百合'),
('Love Live! Superstar!!第二季', '日本/校园,励志,百合', '看完', 10.0, 'https://myanimelist.net/images/anime/1238/124173l.jpg', @watched_on, '2022-07-17', 12, 12, @watched_on, '偶像,校园,励志,百合'),
('Love Live! 虹咲学园校园偶像同好会 第二季', '日本/青春,校园,励志,百合', '看完', 10.0, 'https://myanimelist.net/images/anime/1586/121947l.jpg', @watched_on, '2022-04-02', 13, 13, @watched_on, '偶像,校园,励志,百合'),
('租借女友', '日本/搞笑,校园,恋爱', '看完', 5.0, 'https://myanimelist.net/images/anime/1902/128382l.jpg', @watched_on, '2020-07-11', 12, 12, @watched_on, '搞笑,校园,恋爱'),
('租借女友 第二季', '日本/搞笑,后宫,恋爱,校园,青春', '看完', 10.0, 'https://myanimelist.net/images/anime/1070/124592l.jpg', @watched_on, '2022-07-02', 12, 12, @watched_on, '搞笑,后宫,恋爱,校园,青春'),
('租借女友 第三季', '日本/搞笑,恋爱', '看完', 10.0, 'https://myanimelist.net/images/anime/1696/136634l.jpg', @watched_on, '2023-07-08', 12, 12, @watched_on, '搞笑,恋爱'),
('租借女友 第四季', '日本/搞笑,恋爱,后宫,青春,漫画改', '看完', 10.0, 'https://myanimelist.net/images/anime/1071/150808l.jpg', @watched_on, '2025-07-05', 12, 12, @watched_on, '搞笑,恋爱,后宫,青春,漫画改'),
('租借女友 第五季', '日本/恋爱,后宫,漫画改', '看完', 5.5, 'https://myanimelist.net/images/anime/1902/128382l.jpg', @watched_on, '2026-01-01', 5, 5, @watched_on, '恋爱,后宫,漫画改'),
('Re：从零开始的异世界生活', '日本/战斗,奇幻,冒险', '看完', 10.0, 'https://myanimelist.net/images/anime/1522/128039l.jpg', @watched_on, '2016-04-04', 25, 25, @watched_on, '战斗,奇幻,冒险'),
('Re：从零开始的异世界生活 Memory Snow', '日本/战斗,奇幻,冒险', '看完', 10.0, 'https://myanimelist.net/images/anime/1081/95707l.jpg', @watched_on, '2018-10-06', 1, 1, @watched_on, '战斗,奇幻,冒险,OVA'),
('Re：从零开始的异世界生活 新编集版', '日本/战斗,奇幻,冒险', '看完', 10.0, 'https://myanimelist.net/images/anime/1522/128039l.jpg', @watched_on, '2020-01-01', 13, 13, @watched_on, '战斗,奇幻,冒险'),
('Re：从零开始的异世界生活 冰结之绊', '日本/战斗,奇幻,冒险,美少女', '看完', 10.0, 'https://myanimelist.net/images/anime/1238/104023l.jpg', @watched_on, '2019-11-08', 1, 1, @watched_on, '战斗,奇幻,冒险,美少女'),
('Re：从零开始的异世界生活第二季', '日本/战斗,奇幻,冒险,恋爱', '看完', 10.0, 'https://myanimelist.net/images/anime/1444/108005l.jpg', @watched_on, '2020-07-08', 25, 25, @watched_on, '战斗,奇幻,冒险,恋爱'),
('Re：从零开始的异世界生活第三季 反击篇', '日本/奇幻,战斗,后宫,热血,冒险,恋爱', '看完', 10.0, 'https://myanimelist.net/images/anime/1706/144725l.jpg', @watched_on, '2025-02-05', 8, 8, @watched_on, '奇幻,战斗,冒险,恋爱'),
('Re：从零开始的异世界生活第三季', '日本/奇幻,冒险,后宫,战斗', '看完', 10.0, 'https://myanimelist.net/images/anime/1706/144725l.jpg', @watched_on, '2024-10-02', 8, 8, @watched_on, '奇幻,冒险,后宫,战斗'),
('Re：从零开始的异世界生活第四季', '日本/奇幻,冒险,战斗,异世界,穿越,恋爱,悬疑,轻小', '看完', 10.0, 'https://myanimelist.net/images/anime/1540/155824l.jpg', @watched_on, '2026-01-01', 5, 5, @watched_on, '奇幻,冒险,战斗,恋爱'),
('黑色四叶草', '日本/热血,战斗,奇幻,冒险,魔法', '看完', 10.0, 'https://myanimelist.net/images/anime/2/88336l.jpg', @watched_on, '2017-10-03', 170, 170, @watched_on, '热血,战斗,奇幻,冒险,魔法'),
('我推的孩子', '日本/恋爱,猎奇,推理', '看完', 10.0, 'https://myanimelist.net/images/anime/1812/134736l.jpg', @watched_on, '2023-04-12', 11, 11, @watched_on, '偶像,推理,剧情'),
('我推的孩子 第二季', '日本/恋爱,推理,青春,美少女', '看完', 10.0, 'https://myanimelist.net/images/anime/1006/143302l.jpg', @watched_on, '2024-07-03', 13, 13, @watched_on, '偶像,推理,青春'),
('我推的孩子 第三季', '日本/奇幻,恋爱,后宫,偶像,悬疑,漫画改', '看完', 10.0, 'https://myanimelist.net/images/anime/1979/153329l.jpg', @watched_on, '2026-01-01', 11, 11, @watched_on, '偶像,悬疑,漫画改');

INSERT INTO sekai_memory_book_anime
    (user_id, title, type, status, score, cover_url, watch_date, release_date, total_episodes, current_episode, last_watch_date, tags)
SELECT @sekai_user_id, title, LEFT(type, 50), status, score, cover_url, watch_date, release_date, total_episodes, current_episode, last_watch_date, tags
FROM seed_20260512_more_anime seed
WHERE @sekai_user_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM sekai_memory_book_anime existing
      WHERE existing.user_id = @sekai_user_id
        AND existing.title = seed.title
  );

UPDATE sekai_memory_book_anime anime
JOIN seed_20260512_more_anime seed ON seed.title = anime.title
SET anime.type = LEFT(seed.type, 50),
    anime.status = seed.status,
    anime.score = seed.score,
    anime.cover_url = COALESCE(seed.cover_url, anime.cover_url),
    anime.watch_date = seed.watch_date,
    anime.release_date = seed.release_date,
    anime.total_episodes = seed.total_episodes,
    anime.current_episode = seed.current_episode,
    anime.last_watch_date = seed.last_watch_date,
    anime.tags = seed.tags
WHERE anime.user_id = @sekai_user_id;

CREATE TEMPORARY TABLE seed_20260512_more_characters (
    anime_title VARCHAR(100),
    character_name VARCHAR(100),
    image_url VARCHAR(1000),
    reason VARCHAR(255),
    favorite_level TINYINT
);

INSERT INTO seed_20260512_more_characters
(anime_title, character_name, image_url, reason, favorite_level)
VALUES
('烟花', 'Oikawa, Nazuna', 'https://cdn.myanimelist.net/images/characters/10/334378.jpg?s=e95977e4d0375471bd48b569a7317a17', '烟花 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('烟花', 'Shimada, Norimichi', 'https://cdn.myanimelist.net/images/characters/14/334377.jpg?s=5d98fb4a1337276df713c6e86236a57e', '烟花 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('烟花', 'Miura, Haruko', 'https://cdn.myanimelist.net/images/characters/2/364552.jpg?s=ff9623f92f58da34f2bcc259fc39d6dd', '烟花 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('刀剑神域：序列之争剧场版', 'Kirigaya, Kazuto', 'https://cdn.myanimelist.net/images/characters/7/204821.jpg?s=6a96a832b35d0ff3af9292bdb082546e', '刀剑神域：序列之争剧场版 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('刀剑神域：序列之争剧场版', 'Yuuki, Asuna', 'https://cdn.myanimelist.net/images/characters/15/262053.jpg?s=449153df46cce80307c9f8ae622b4514', '刀剑神域：序列之争剧场版 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('刀剑神域：序列之争剧场版', 'Yuna', 'https://cdn.myanimelist.net/images/characters/15/314285.jpg?s=9aeece2337c7c72301c9f548a533c1a9', '刀剑神域：序列之争剧场版 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('BanG Dream! Episode of Roselia I: 约定', 'Minato, Yukina', 'https://cdn.myanimelist.net/images/characters/13/403710.jpg?s=50d2f6ddbad819a1a4146164cc32fd83', 'BanG Dream! Episode of Roselia I: 约定 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('BanG Dream! Episode of Roselia I: 约定', 'Imai, Lisa', 'https://cdn.myanimelist.net/images/characters/2/368416.jpg?s=305bbeb3a8783487004d411a9ed457fa', 'BanG Dream! Episode of Roselia I: 约定 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('BanG Dream! Episode of Roselia I: 约定', 'Hikawa, Sayo', 'https://cdn.myanimelist.net/images/characters/13/365749.jpg?s=3ef105b13a95684c10f677af50d00a42', 'BanG Dream! Episode of Roselia I: 约定 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('黑子的篮球剧场版：LAST GAME', 'Kuroko, Tetsuya', 'https://cdn.myanimelist.net/images/characters/3/258381.jpg?s=48b1c05a2e426be1ad1726cbbb5e210b', '黑子的篮球剧场版：LAST GAME 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('黑子的篮球剧场版：LAST GAME', 'Aomine, Daiki', 'https://cdn.myanimelist.net/images/characters/9/246745.jpg?s=d52cc81c1470ab893dd2b389070a871e', '黑子的篮球剧场版：LAST GAME 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('黑子的篮球剧场版：LAST GAME', 'Akashi, Seijuurou', 'https://cdn.myanimelist.net/images/characters/4/275813.jpg?s=516396f259b08c9bdcd400f0ac86afde', '黑子的篮球剧场版：LAST GAME 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('轻音少女', 'Hirasawa, Yui', 'https://cdn.myanimelist.net/images/characters/6/326131.jpg?s=20869a72ce294f22b20a5464f48ae576', '轻音少女 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('轻音少女', 'Akiyama, Mio', 'https://cdn.myanimelist.net/images/characters/11/48547.jpg?s=cc5ab1310b7f663aad2050da6c4664c9', '轻音少女 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('轻音少女', 'Nakano, Azusa', 'https://cdn.myanimelist.net/images/characters/15/86736.jpg?s=ecd00a6a480e9a7a988d43f34912a658', '轻音少女 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('轻音少女 第二季', 'Hirasawa, Yui', 'https://cdn.myanimelist.net/images/characters/6/326131.jpg?s=20869a72ce294f22b20a5464f48ae576', '轻音少女 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('轻音少女 第二季', 'Akiyama, Mio', 'https://cdn.myanimelist.net/images/characters/11/48547.jpg?s=cc5ab1310b7f663aad2050da6c4664c9', '轻音少女 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('轻音少女 第二季', 'Nakano, Azusa', 'https://cdn.myanimelist.net/images/characters/15/86736.jpg?s=ecd00a6a480e9a7a988d43f34912a658', '轻音少女 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('轻音少女 剧场版', 'Hirasawa, Yui', 'https://cdn.myanimelist.net/images/characters/6/326131.jpg?s=20869a72ce294f22b20a5464f48ae576', '轻音少女 剧场版 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('轻音少女 剧场版', 'Akiyama, Mio', 'https://cdn.myanimelist.net/images/characters/11/48547.jpg?s=cc5ab1310b7f663aad2050da6c4664c9', '轻音少女 剧场版 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('轻音少女 剧场版', 'Nakano, Azusa', 'https://cdn.myanimelist.net/images/characters/15/86736.jpg?s=ecd00a6a480e9a7a988d43f34912a658', '轻音少女 剧场版 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('孤独摇滚！', 'Gotou, Hitori', 'https://cdn.myanimelist.net/images/characters/4/509913.jpg?s=b2ea13d31512f5f75c890100acd4d32c', '孤独摇滚！ 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('孤独摇滚！', 'Yamada, Ryou', 'https://cdn.myanimelist.net/images/characters/16/491303.jpg?s=fa93ec272f438f378b075cba03e76875', '孤独摇滚！ 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('孤独摇滚！', 'Ijichi, Nijika', 'https://cdn.myanimelist.net/images/characters/16/491305.jpg?s=3f2ab4809df1b2d7ef8b4f10ef35b05f', '孤独摇滚！ 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('吹响！上低音号', 'Oumae, Kumiko', 'https://cdn.myanimelist.net/images/characters/8/280130.jpg?s=dda6aac9e5f37c1795478e7c53e45779', '吹响！上低音号 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('吹响！上低音号', 'Kousaka, Reina', 'https://cdn.myanimelist.net/images/characters/5/354305.jpg?s=cb7e46d1ef97e9fe5dd71fcdd40e0dde', '吹响！上低音号 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('吹响！上低音号', 'Katou, Hazuki', 'https://cdn.myanimelist.net/images/characters/5/354300.jpg?s=8b5851ecce0482ae1cbe9aeadcdfc321', '吹响！上低音号 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('吹响！上低音号第二季', 'Oumae, Kumiko', 'https://cdn.myanimelist.net/images/characters/8/280130.jpg?s=dda6aac9e5f37c1795478e7c53e45779', '吹响！上低音号第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('吹响！上低音号第二季', 'Kousaka, Reina', 'https://cdn.myanimelist.net/images/characters/5/354305.jpg?s=cb7e46d1ef97e9fe5dd71fcdd40e0dde', '吹响！上低音号第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('吹响！上低音号第二季', 'Tanaka, Asuka', 'https://cdn.myanimelist.net/images/characters/10/319400.jpg?s=30fa4f38d22e720c7b2221fbccb24c23', '吹响！上低音号第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('吹响！上低音号第三季', 'Oumae, Kumiko', 'https://cdn.myanimelist.net/images/characters/8/280130.jpg?s=dda6aac9e5f37c1795478e7c53e45779', '吹响！上低音号第三季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('吹响！上低音号第三季', 'Kousaka, Reina', 'https://cdn.myanimelist.net/images/characters/5/354305.jpg?s=cb7e46d1ef97e9fe5dd71fcdd40e0dde', '吹响！上低音号第三季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('吹响！上低音号第三季', 'Tanaka, Asuka', 'https://cdn.myanimelist.net/images/characters/10/319400.jpg?s=30fa4f38d22e720c7b2221fbccb24c23', '吹响！上低音号第三季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('吹响！上低音号剧场版合集', 'Oumae, Kumiko', 'https://cdn.myanimelist.net/images/characters/8/280130.jpg?s=dda6aac9e5f37c1795478e7c53e45779', '吹响！上低音号剧场版合集 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('吹响！上低音号剧场版合集', 'Kousaka, Reina', 'https://cdn.myanimelist.net/images/characters/5/354305.jpg?s=cb7e46d1ef97e9fe5dd71fcdd40e0dde', '吹响！上低音号剧场版合集 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('吹响！上低音号剧场版合集', 'Katou, Hazuki', 'https://cdn.myanimelist.net/images/characters/5/354300.jpg?s=8b5851ecce0482ae1cbe9aeadcdfc321', '吹响！上低音号剧场版合集 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('金牌得主 第二季', 'Yuitsuka, Inori', 'https://cdn.myanimelist.net/images/characters/7/579734.jpg?s=dfa422860c5ef8de5125ef23c450a518', '金牌得主 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('金牌得主 第二季', 'Akeuraji, Tsukasa', 'https://cdn.myanimelist.net/images/characters/8/517162.jpg?s=47dfe271283d84f167ca1a06c4fc1358', '金牌得主 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('金牌得主 第二季', 'Kamisaki, Hikaru', 'https://cdn.myanimelist.net/images/characters/14/579733.jpg?s=1c4114cac5c5a7ad350379137e66ac84', '金牌得主 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('想吃掉我的非人少女', 'Yaotose, Hinako', 'https://cdn.myanimelist.net/images/characters/2/583508.jpg?s=dbf6b856b21c5b62d564b195cdf58575', '想吃掉我的非人少女 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('想吃掉我的非人少女', 'Oumi, Shiori', 'https://cdn.myanimelist.net/images/characters/16/583509.jpg?s=90ff4c2694c8a32080cfb75296cc3202', '想吃掉我的非人少女 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('想吃掉我的非人少女', 'Yashiro, Miko', 'https://cdn.myanimelist.net/images/characters/7/583507.jpg?s=b8aa61f1e474dcc729a1dc4c11affab2', '想吃掉我的非人少女 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('关于我在无意间被隔壁的天使变成废柴这件事', 'Shiina, Mahiru', 'https://cdn.myanimelist.net/images/characters/3/624218.jpg?s=b0ef759ce448ec55a21dc982e7da100a', '关于我在无意间被隔壁的天使变成废柴这件事 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('关于我在无意间被隔壁的天使变成废柴这件事', 'Fujimiya, Amane', 'https://cdn.myanimelist.net/images/characters/15/624219.jpg?s=c1fd2a52293ed3e76e269720f27f2826', '关于我在无意间被隔壁的天使变成废柴这件事 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('关于我在无意间被隔壁的天使变成废柴这件事', 'Shirakawa, Chitose', 'https://cdn.myanimelist.net/images/characters/16/624220.jpg?s=dd25d54b61de504bfd097348f2975882', '关于我在无意间被隔壁的天使变成废柴这件事 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('欢迎来到实力至上主义教室第四季', 'Ayanokouji, Kiyotaka', 'https://cdn.myanimelist.net/images/characters/4/539058.jpg?s=b3479dd539992cf50ab1bfd6f38dd0c4', '欢迎来到实力至上主义教室第四季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('欢迎来到实力至上主义教室第四季', 'Horikita, Suzune', 'https://cdn.myanimelist.net/images/characters/16/433767.jpg?s=de877dbcfe6d022f5f32d47c4e70e2a2', '欢迎来到实力至上主义教室第四季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('欢迎来到实力至上主义教室第四季', 'Karuizawa, Kei', 'https://cdn.myanimelist.net/images/characters/7/539083.jpg?s=83aea38bdb29a47e0945705307804de7', '欢迎来到实力至上主义教室第四季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('咒术回战 第三季', 'Gojou, Satoru', 'https://cdn.myanimelist.net/images/characters/15/422168.jpg?s=7c1dfc26a9b3a6652da616a0fec7af01', '咒术回战 第三季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('咒术回战 第三季', 'Itadori, Yuuji', 'https://cdn.myanimelist.net/images/characters/6/467646.jpg?s=9e1cb7b0c6c7f145661e8ee93f32215d', '咒术回战 第三季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('咒术回战 第三季', 'Fushiguro, Megumi', 'https://cdn.myanimelist.net/images/characters/12/621887.jpg?s=fb8e12884d38886ba643f4f2509b22d6', '咒术回战 第三季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('杖与剑的魔剑谭 第二季', 'Serfort, Elfaria Albis', 'https://cdn.myanimelist.net/images/characters/2/563704.jpg?s=042ae5d743fde476fbd1c40a501a457b', '杖与剑的魔剑谭 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('杖与剑的魔剑谭 第二季', 'Serfort, Will', 'https://cdn.myanimelist.net/images/characters/8/537716.jpg?s=1ebc4a01835f8ab76518ebce8c7bdff2', '杖与剑的魔剑谭 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('杖与剑的魔剑谭 第二季', 'Loire, Colette', 'https://cdn.myanimelist.net/images/characters/11/539536.jpg?s=8e729f4f5efb4537cf869a8000e39d7d', '杖与剑的魔剑谭 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('夜樱家的大作战 第二季', 'Yozakura, Mutsumi', 'https://cdn.myanimelist.net/images/characters/7/628629.jpg?s=758459918f466d1860060d7bada4d140', '夜樱家的大作战 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('夜樱家的大作战 第二季', 'Asano, Taiyou', 'https://cdn.myanimelist.net/images/characters/2/523024.jpg?s=011422b4f499170666aa1950e02a2d1b', '夜樱家的大作战 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('夜樱家的大作战 第二季', 'Yozakura, Kyouichirou', 'https://cdn.myanimelist.net/images/characters/2/523027.jpg?s=af575269bc1745ec8886598c0e936ec3', '夜樱家的大作战 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('魔法少女与恶曾是敌人', 'Mimori, Byakuya', 'https://cdn.myanimelist.net/images/characters/10/558273.jpg?s=1f8c0a9e03909a58e71a2a5fe887b842', '魔法少女与恶曾是敌人 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('魔法少女与恶曾是敌人', 'Miller, Shun', 'https://cdn.myanimelist.net/images/characters/10/555769.jpg?s=f856ab3baa1628a317cd0340c040c5cb', '魔法少女与恶曾是敌人 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('魔法少女与恶曾是敌人', 'Kagari, Hibana', 'https://cdn.myanimelist.net/images/characters/10/558274.jpg?s=adc92d804578aff42ba16d52def86aa8', '魔法少女与恶曾是敌人 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Love Live!第二季', 'Nishikino, Maki', 'https://cdn.myanimelist.net/images/characters/9/196139.jpg?s=3f244b83a2a151fb8d44833dd464f96f', 'Love Live!第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Love Live!第二季', 'Yazawa, Niko', 'https://cdn.myanimelist.net/images/characters/9/200929.jpg?s=389f1b4fe5b20bc82aac275a89b688d6', 'Love Live!第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Love Live!第二季', 'Toujou, Nozomi', 'https://cdn.myanimelist.net/images/characters/10/295027.jpg?s=cbfc5a84e30a9085c319aa541c4d136a', 'Love Live!第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Love Live! 虹咲学园校园偶像同好会', 'Tennouji, Rina', 'https://cdn.myanimelist.net/images/characters/3/421043.jpg?s=9986d4a347380c0f5a05d7735181c8a8', 'Love Live! 虹咲学园校园偶像同好会 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Love Live! 虹咲学园校园偶像同好会', 'Yuuki, Setsuna', 'https://cdn.myanimelist.net/images/characters/9/421041.jpg?s=3b89889b504bc908fde7a9c8c8fd8a10', 'Love Live! 虹咲学园校园偶像同好会 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Love Live! 虹咲学园校园偶像同好会', 'Konoe, Kanata', 'https://cdn.myanimelist.net/images/characters/10/565836.jpg?s=3398e144af19d2c3665237ccd0359c6c', 'Love Live! 虹咲学园校园偶像同好会 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Love Live! Superstar!!', 'Shibuya, Kanon', 'https://cdn.myanimelist.net/images/characters/3/458089.jpg?s=772014c66fe6e50fb0c2e7fbef6a58d5', 'Love Live! Superstar!! 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Love Live! Superstar!!', 'Tang, Keke', 'https://cdn.myanimelist.net/images/characters/16/458836.jpg?s=da332f7312e01ba8292c4816ef556ad6', 'Love Live! Superstar!! 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Love Live! Superstar!!', 'Heanna, Sumire', 'https://cdn.myanimelist.net/images/characters/7/458091.jpg?s=f437ee6e5d66635799a4e48a38d247a7', 'Love Live! Superstar!! 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Love Live! Superstar!!第二季', 'Shibuya, Kanon', 'https://cdn.myanimelist.net/images/characters/3/458089.jpg?s=772014c66fe6e50fb0c2e7fbef6a58d5', 'Love Live! Superstar!!第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Love Live! Superstar!!第二季', 'Tang, Keke', 'https://cdn.myanimelist.net/images/characters/16/458836.jpg?s=da332f7312e01ba8292c4816ef556ad6', 'Love Live! Superstar!!第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Love Live! Superstar!!第二季', 'Heanna, Sumire', 'https://cdn.myanimelist.net/images/characters/7/458091.jpg?s=f437ee6e5d66635799a4e48a38d247a7', 'Love Live! Superstar!!第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('租借女友', 'Ichinose, Chizuru', 'https://cdn.myanimelist.net/images/characters/4/484261.jpg?s=51eb91f1b831e6dbab1a1eb625f28caf', '租借女友 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('租借女友', 'Kinoshita, Kazuya', 'https://cdn.myanimelist.net/images/characters/9/396701.jpg?s=99585bacf71f5c4f8807f0ea127787b3', '租借女友 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('租借女友', 'Sakurasawa, Sumi', 'https://cdn.myanimelist.net/images/characters/9/484263.jpg?s=9924e6a1ea2aaccea309f5302f454bb1', '租借女友 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('租借女友 第二季', 'Ichinose, Chizuru', 'https://cdn.myanimelist.net/images/characters/4/484261.jpg?s=51eb91f1b831e6dbab1a1eb625f28caf', '租借女友 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('租借女友 第二季', 'Kinoshita, Kazuya', 'https://cdn.myanimelist.net/images/characters/9/396701.jpg?s=99585bacf71f5c4f8807f0ea127787b3', '租借女友 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('租借女友 第二季', 'Sakurasawa, Sumi', 'https://cdn.myanimelist.net/images/characters/9/484263.jpg?s=9924e6a1ea2aaccea309f5302f454bb1', '租借女友 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('租借女友 第三季', 'Ichinose, Chizuru', 'https://cdn.myanimelist.net/images/characters/4/484261.jpg?s=51eb91f1b831e6dbab1a1eb625f28caf', '租借女友 第三季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('租借女友 第三季', 'Kinoshita, Kazuya', 'https://cdn.myanimelist.net/images/characters/9/396701.jpg?s=99585bacf71f5c4f8807f0ea127787b3', '租借女友 第三季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('租借女友 第三季', 'Sakurasawa, Sumi', 'https://cdn.myanimelist.net/images/characters/9/484263.jpg?s=9924e6a1ea2aaccea309f5302f454bb1', '租借女友 第三季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('租借女友 第四季', 'Ichinose, Chizuru', 'https://cdn.myanimelist.net/images/characters/4/484261.jpg?s=51eb91f1b831e6dbab1a1eb625f28caf', '租借女友 第四季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('租借女友 第四季', 'Kinoshita, Kazuya', 'https://cdn.myanimelist.net/images/characters/9/396701.jpg?s=99585bacf71f5c4f8807f0ea127787b3', '租借女友 第四季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('租借女友 第四季', 'Sakurasawa, Sumi', 'https://cdn.myanimelist.net/images/characters/9/484263.jpg?s=9924e6a1ea2aaccea309f5302f454bb1', '租借女友 第四季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('租借女友 第五季', 'Ichinose, Chizuru', 'https://cdn.myanimelist.net/images/characters/4/484261.jpg?s=51eb91f1b831e6dbab1a1eb625f28caf', '租借女友 第五季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('租借女友 第五季', 'Kinoshita, Kazuya', 'https://cdn.myanimelist.net/images/characters/9/396701.jpg?s=99585bacf71f5c4f8807f0ea127787b3', '租借女友 第五季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('租借女友 第五季', 'Sakurasawa, Sumi', 'https://cdn.myanimelist.net/images/characters/9/484263.jpg?s=9924e6a1ea2aaccea309f5302f454bb1', '租借女友 第五季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活', 'Natsuki, Subaru', 'https://cdn.myanimelist.net/images/characters/15/315153.jpg?s=48e475fa71e56bb47eb93594fe10359d', 'Re：从零开始的异世界生活 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活', 'Emilia', 'https://cdn.myanimelist.net/images/characters/16/551926.jpg?s=22728d0269f40fb353a31a54545ded00', 'Re：从零开始的异世界生活 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活', 'Rem', 'https://cdn.myanimelist.net/images/characters/9/311327.jpg?s=3246595cd08261824d0dbf11a44c7229', 'Re：从零开始的异世界生活 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活 Memory Snow', 'Natsuki, Subaru', 'https://cdn.myanimelist.net/images/characters/15/315153.jpg?s=48e475fa71e56bb47eb93594fe10359d', 'Re：从零开始的异世界生活 Memory Snow 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活 Memory Snow', 'Emilia', 'https://cdn.myanimelist.net/images/characters/16/551926.jpg?s=22728d0269f40fb353a31a54545ded00', 'Re：从零开始的异世界生活 Memory Snow 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活 Memory Snow', 'Rem', 'https://cdn.myanimelist.net/images/characters/9/311327.jpg?s=3246595cd08261824d0dbf11a44c7229', 'Re：从零开始的异世界生活 Memory Snow 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活 新编集版', 'Natsuki, Subaru', 'https://cdn.myanimelist.net/images/characters/15/315153.jpg?s=48e475fa71e56bb47eb93594fe10359d', 'Re：从零开始的异世界生活 新编集版 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活 新编集版', 'Emilia', 'https://cdn.myanimelist.net/images/characters/16/551926.jpg?s=22728d0269f40fb353a31a54545ded00', 'Re：从零开始的异世界生活 新编集版 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活 新编集版', 'Rem', 'https://cdn.myanimelist.net/images/characters/9/311327.jpg?s=3246595cd08261824d0dbf11a44c7229', 'Re：从零开始的异世界生活 新编集版 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活 冰结之绊', 'Emilia', 'https://cdn.myanimelist.net/images/characters/16/551926.jpg?s=22728d0269f40fb353a31a54545ded00', 'Re：从零开始的异世界生活 冰结之绊 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活 冰结之绊', 'Pack', 'https://cdn.myanimelist.net/images/characters/15/300489.jpg?s=e41c0d4ad13c017d2da734c423858bce', 'Re：从零开始的异世界生活 冰结之绊 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活 冰结之绊', 'Rem', 'https://cdn.myanimelist.net/images/characters/9/311327.jpg?s=3246595cd08261824d0dbf11a44c7229', 'Re：从零开始的异世界生活 冰结之绊 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活第二季', 'Natsuki, Subaru', 'https://cdn.myanimelist.net/images/characters/15/315153.jpg?s=48e475fa71e56bb47eb93594fe10359d', 'Re：从零开始的异世界生活第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活第二季', 'Emilia', 'https://cdn.myanimelist.net/images/characters/16/551926.jpg?s=22728d0269f40fb353a31a54545ded00', 'Re：从零开始的异世界生活第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活第二季', 'Rem', 'https://cdn.myanimelist.net/images/characters/9/311327.jpg?s=3246595cd08261824d0dbf11a44c7229', 'Re：从零开始的异世界生活第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活第三季 反击篇', 'Natsuki, Subaru', 'https://cdn.myanimelist.net/images/characters/15/315153.jpg?s=48e475fa71e56bb47eb93594fe10359d', 'Re：从零开始的异世界生活第三季 反击篇 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活第三季 反击篇', 'Emilia', 'https://cdn.myanimelist.net/images/characters/16/551926.jpg?s=22728d0269f40fb353a31a54545ded00', 'Re：从零开始的异世界生活第三季 反击篇 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活第三季 反击篇', 'Rem', 'https://cdn.myanimelist.net/images/characters/9/311327.jpg?s=3246595cd08261824d0dbf11a44c7229', 'Re：从零开始的异世界生活第三季 反击篇 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活第三季', 'Natsuki, Subaru', 'https://cdn.myanimelist.net/images/characters/15/315153.jpg?s=48e475fa71e56bb47eb93594fe10359d', 'Re：从零开始的异世界生活第三季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活第三季', 'Emilia', 'https://cdn.myanimelist.net/images/characters/16/551926.jpg?s=22728d0269f40fb353a31a54545ded00', 'Re：从零开始的异世界生活第三季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活第三季', 'Rem', 'https://cdn.myanimelist.net/images/characters/9/311327.jpg?s=3246595cd08261824d0dbf11a44c7229', 'Re：从零开始的异世界生活第三季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活第四季', 'Natsuki, Subaru', 'https://cdn.myanimelist.net/images/characters/15/315153.jpg?s=48e475fa71e56bb47eb93594fe10359d', 'Re：从零开始的异世界生活第四季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活第四季', 'Emilia', 'https://cdn.myanimelist.net/images/characters/16/551926.jpg?s=22728d0269f40fb353a31a54545ded00', 'Re：从零开始的异世界生活第四季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('Re：从零开始的异世界生活第四季', 'Rem', 'https://cdn.myanimelist.net/images/characters/9/311327.jpg?s=3246595cd08261824d0dbf11a44c7229', 'Re：从零开始的异世界生活第四季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('黑色四叶草', 'Asta', 'https://cdn.myanimelist.net/images/characters/8/312836.jpg?s=f4ea6f575c53db8908baf0f874e33e70', '黑色四叶草 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('黑色四叶草', 'Silva, Noelle', 'https://cdn.myanimelist.net/images/characters/14/338844.jpg?s=37d6d1f99de07821983285b9a3ac2614', '黑色四叶草 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('黑色四叶草', 'Yuno', 'https://cdn.myanimelist.net/images/characters/6/318765.jpg?s=dbc2307d86d0e001e31b9aad6f12b21c', '黑色四叶草 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('我推的孩子', 'Arima, Kana', 'https://cdn.myanimelist.net/images/characters/6/503733.jpg?s=6dddc82129535b664f8d5f0ba1e5b14b', '我推的孩子 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('我推的孩子', 'Hoshino, Ai', 'https://cdn.myanimelist.net/images/characters/6/496453.jpg?s=586f73ec11e59e6a6acc659afe9fb660', '我推的孩子 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('我推的孩子', 'Hoshino, Aquamarine', 'https://cdn.myanimelist.net/images/characters/8/512509.jpg?s=0fbc9c40821bab48c922aa336708bb33', '我推的孩子 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('我推的孩子 第二季', 'Arima, Kana', 'https://cdn.myanimelist.net/images/characters/6/503733.jpg?s=6dddc82129535b664f8d5f0ba1e5b14b', '我推的孩子 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('我推的孩子 第二季', 'Kurokawa, Akane', 'https://cdn.myanimelist.net/images/characters/6/592737.jpg?s=602e780d91b34622645cf66e520d7ba6', '我推的孩子 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('我推的孩子 第二季', 'Hoshino, Aquamarine', 'https://cdn.myanimelist.net/images/characters/8/512509.jpg?s=0fbc9c40821bab48c922aa336708bb33', '我推的孩子 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('我推的孩子 第三季', 'Arima, Kana', 'https://cdn.myanimelist.net/images/characters/6/503733.jpg?s=6dddc82129535b664f8d5f0ba1e5b14b', '我推的孩子 第三季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('我推的孩子 第三季', 'Kurokawa, Akane', 'https://cdn.myanimelist.net/images/characters/6/592737.jpg?s=602e780d91b34622645cf66e520d7ba6', '我推的孩子 第三季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('我推的孩子 第三季', 'Hoshino, Aquamarine', 'https://cdn.myanimelist.net/images/characters/8/512509.jpg?s=0fbc9c40821bab48c922aa336708bb33', '我推的孩子 第三季 的主要角色，承载了这部作品最鲜明的记忆点。', 5);

INSERT INTO sekai_memory_book_character_favorite
    (user_id, anime_id, character_name, image_url, reason, favorite_level)
SELECT @sekai_user_id, MIN(anime.id), seed.character_name,
       SUBSTRING_INDEX(GROUP_CONCAT(seed.image_url ORDER BY seed.anime_title SEPARATOR '||'), '||', 1),
       SUBSTRING_INDEX(GROUP_CONCAT(seed.reason ORDER BY seed.anime_title SEPARATOR '||'), '||', 1),
       MAX(seed.favorite_level)
FROM seed_20260512_more_characters seed
JOIN sekai_memory_book_anime anime
  ON anime.user_id = @sekai_user_id
 AND anime.title = seed.anime_title
WHERE @sekai_user_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM sekai_memory_book_character_favorite existing
      WHERE existing.user_id = @sekai_user_id
        AND existing.character_name = seed.character_name
  )
GROUP BY seed.character_name;

CREATE TEMPORARY TABLE seed_20260512_more_quotes (
    anime_title VARCHAR(100),
    character_name VARCHAR(100),
    content VARCHAR(500),
    feeling TEXT,
    tag VARCHAR(50)
);

INSERT INTO seed_20260512_more_quotes
(anime_title, character_name, content, feeling, tag)
VALUES
('烟花', 'Oikawa, Nazuna', '我会继续向前。', '烟花 的角色短句，适合放在回忆台词里。', '前进'),
('烟花', 'Shimada, Norimichi', '我会继续向前。', '烟花 的角色短句，适合放在回忆台词里。', '前进'),
('烟花', 'Miura, Haruko', '我会继续向前。', '烟花 的角色短句，适合放在回忆台词里。', '前进'),
('刀剑神域：序列之争剧场版', 'Kirigaya, Kazuto', '我会继续向前。', '刀剑神域：序列之争剧场版 的角色短句，适合放在回忆台词里。', '前进'),
('刀剑神域：序列之争剧场版', 'Yuuki, Asuna', '我会继续向前。', '刀剑神域：序列之争剧场版 的角色短句，适合放在回忆台词里。', '前进'),
('刀剑神域：序列之争剧场版', 'Yuna', '我会继续向前。', '刀剑神域：序列之争剧场版 的角色短句，适合放在回忆台词里。', '前进'),
('BanG Dream! Episode of Roselia I: 约定', 'Minato, Yukina', '我会继续向前。', 'BanG Dream! Episode of Roselia I: 约定 的角色短句，适合放在回忆台词里。', '前进'),
('BanG Dream! Episode of Roselia I: 约定', 'Imai, Lisa', '我会继续向前。', 'BanG Dream! Episode of Roselia I: 约定 的角色短句，适合放在回忆台词里。', '前进'),
('BanG Dream! Episode of Roselia I: 约定', 'Hikawa, Sayo', '我会继续向前。', 'BanG Dream! Episode of Roselia I: 约定 的角色短句，适合放在回忆台词里。', '前进'),
('黑子的篮球剧场版：LAST GAME', 'Kuroko, Tetsuya', '我会继续向前。', '黑子的篮球剧场版：LAST GAME 的角色短句，适合放在回忆台词里。', '前进'),
('黑子的篮球剧场版：LAST GAME', 'Aomine, Daiki', '我会继续向前。', '黑子的篮球剧场版：LAST GAME 的角色短句，适合放在回忆台词里。', '前进'),
('黑子的篮球剧场版：LAST GAME', 'Akashi, Seijuurou', '我会继续向前。', '黑子的篮球剧场版：LAST GAME 的角色短句，适合放在回忆台词里。', '前进'),
('轻音少女', 'Hirasawa, Yui', '我会继续向前。', '轻音少女 的角色短句，适合放在回忆台词里。', '前进'),
('轻音少女', 'Akiyama, Mio', '我会继续向前。', '轻音少女 的角色短句，适合放在回忆台词里。', '前进'),
('轻音少女', 'Nakano, Azusa', '我会继续向前。', '轻音少女 的角色短句，适合放在回忆台词里。', '前进'),
('轻音少女 第二季', 'Hirasawa, Yui', '我会继续向前。', '轻音少女 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('轻音少女 第二季', 'Akiyama, Mio', '我会继续向前。', '轻音少女 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('轻音少女 第二季', 'Nakano, Azusa', '我会继续向前。', '轻音少女 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('轻音少女 剧场版', 'Hirasawa, Yui', '我会继续向前。', '轻音少女 剧场版 的角色短句，适合放在回忆台词里。', '前进'),
('轻音少女 剧场版', 'Akiyama, Mio', '我会继续向前。', '轻音少女 剧场版 的角色短句，适合放在回忆台词里。', '前进'),
('轻音少女 剧场版', 'Nakano, Azusa', '我会继续向前。', '轻音少女 剧场版 的角色短句，适合放在回忆台词里。', '前进'),
('孤独摇滚！', 'Gotou, Hitori', '我会继续向前。', '孤独摇滚！ 的角色短句，适合放在回忆台词里。', '前进'),
('孤独摇滚！', 'Yamada, Ryou', '我会继续向前。', '孤独摇滚！ 的角色短句，适合放在回忆台词里。', '前进'),
('孤独摇滚！', 'Ijichi, Nijika', '我会继续向前。', '孤独摇滚！ 的角色短句，适合放在回忆台词里。', '前进'),
('吹响！上低音号', 'Oumae, Kumiko', '我会继续向前。', '吹响！上低音号 的角色短句，适合放在回忆台词里。', '前进'),
('吹响！上低音号', 'Kousaka, Reina', '我会继续向前。', '吹响！上低音号 的角色短句，适合放在回忆台词里。', '前进'),
('吹响！上低音号', 'Katou, Hazuki', '我会继续向前。', '吹响！上低音号 的角色短句，适合放在回忆台词里。', '前进'),
('吹响！上低音号第二季', 'Oumae, Kumiko', '我会继续向前。', '吹响！上低音号第二季 的角色短句，适合放在回忆台词里。', '前进'),
('吹响！上低音号第二季', 'Kousaka, Reina', '我会继续向前。', '吹响！上低音号第二季 的角色短句，适合放在回忆台词里。', '前进'),
('吹响！上低音号第二季', 'Tanaka, Asuka', '我会继续向前。', '吹响！上低音号第二季 的角色短句，适合放在回忆台词里。', '前进'),
('吹响！上低音号第三季', 'Oumae, Kumiko', '我会继续向前。', '吹响！上低音号第三季 的角色短句，适合放在回忆台词里。', '前进'),
('吹响！上低音号第三季', 'Kousaka, Reina', '我会继续向前。', '吹响！上低音号第三季 的角色短句，适合放在回忆台词里。', '前进'),
('吹响！上低音号第三季', 'Tanaka, Asuka', '我会继续向前。', '吹响！上低音号第三季 的角色短句，适合放在回忆台词里。', '前进'),
('吹响！上低音号剧场版合集', 'Oumae, Kumiko', '我会继续向前。', '吹响！上低音号剧场版合集 的角色短句，适合放在回忆台词里。', '前进'),
('吹响！上低音号剧场版合集', 'Kousaka, Reina', '我会继续向前。', '吹响！上低音号剧场版合集 的角色短句，适合放在回忆台词里。', '前进'),
('吹响！上低音号剧场版合集', 'Katou, Hazuki', '我会继续向前。', '吹响！上低音号剧场版合集 的角色短句，适合放在回忆台词里。', '前进'),
('金牌得主 第二季', 'Yuitsuka, Inori', '我会继续向前。', '金牌得主 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('金牌得主 第二季', 'Akeuraji, Tsukasa', '我会继续向前。', '金牌得主 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('金牌得主 第二季', 'Kamisaki, Hikaru', '我会继续向前。', '金牌得主 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('想吃掉我的非人少女', 'Yaotose, Hinako', '我会继续向前。', '想吃掉我的非人少女 的角色短句，适合放在回忆台词里。', '前进'),
('想吃掉我的非人少女', 'Oumi, Shiori', '我会继续向前。', '想吃掉我的非人少女 的角色短句，适合放在回忆台词里。', '前进'),
('想吃掉我的非人少女', 'Yashiro, Miko', '我会继续向前。', '想吃掉我的非人少女 的角色短句，适合放在回忆台词里。', '前进'),
('关于我在无意间被隔壁的天使变成废柴这件事', 'Shiina, Mahiru', '我会继续向前。', '关于我在无意间被隔壁的天使变成废柴这件事 的角色短句，适合放在回忆台词里。', '前进'),
('关于我在无意间被隔壁的天使变成废柴这件事', 'Fujimiya, Amane', '我会继续向前。', '关于我在无意间被隔壁的天使变成废柴这件事 的角色短句，适合放在回忆台词里。', '前进'),
('关于我在无意间被隔壁的天使变成废柴这件事', 'Shirakawa, Chitose', '我会继续向前。', '关于我在无意间被隔壁的天使变成废柴这件事 的角色短句，适合放在回忆台词里。', '前进'),
('欢迎来到实力至上主义教室第四季', 'Ayanokouji, Kiyotaka', '我会继续向前。', '欢迎来到实力至上主义教室第四季 的角色短句，适合放在回忆台词里。', '前进'),
('欢迎来到实力至上主义教室第四季', 'Horikita, Suzune', '我会继续向前。', '欢迎来到实力至上主义教室第四季 的角色短句，适合放在回忆台词里。', '前进'),
('欢迎来到实力至上主义教室第四季', 'Karuizawa, Kei', '我会继续向前。', '欢迎来到实力至上主义教室第四季 的角色短句，适合放在回忆台词里。', '前进'),
('咒术回战 第三季', 'Gojou, Satoru', '我会继续向前。', '咒术回战 第三季 的角色短句，适合放在回忆台词里。', '前进'),
('咒术回战 第三季', 'Itadori, Yuuji', '我会继续向前。', '咒术回战 第三季 的角色短句，适合放在回忆台词里。', '前进'),
('咒术回战 第三季', 'Fushiguro, Megumi', '我会继续向前。', '咒术回战 第三季 的角色短句，适合放在回忆台词里。', '前进'),
('杖与剑的魔剑谭 第二季', 'Serfort, Elfaria Albis', '我会继续向前。', '杖与剑的魔剑谭 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('杖与剑的魔剑谭 第二季', 'Serfort, Will', '我会继续向前。', '杖与剑的魔剑谭 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('杖与剑的魔剑谭 第二季', 'Loire, Colette', '我会继续向前。', '杖与剑的魔剑谭 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('夜樱家的大作战 第二季', 'Yozakura, Mutsumi', '我会继续向前。', '夜樱家的大作战 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('夜樱家的大作战 第二季', 'Asano, Taiyou', '我会继续向前。', '夜樱家的大作战 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('夜樱家的大作战 第二季', 'Yozakura, Kyouichirou', '我会继续向前。', '夜樱家的大作战 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('魔法少女与恶曾是敌人', 'Mimori, Byakuya', '我会继续向前。', '魔法少女与恶曾是敌人 的角色短句，适合放在回忆台词里。', '前进'),
('魔法少女与恶曾是敌人', 'Miller, Shun', '我会继续向前。', '魔法少女与恶曾是敌人 的角色短句，适合放在回忆台词里。', '前进'),
('魔法少女与恶曾是敌人', 'Kagari, Hibana', '我会继续向前。', '魔法少女与恶曾是敌人 的角色短句，适合放在回忆台词里。', '前进'),
('Love Live!第二季', 'Nishikino, Maki', '我会继续向前。', 'Love Live!第二季 的角色短句，适合放在回忆台词里。', '前进'),
('Love Live!第二季', 'Yazawa, Niko', '我会继续向前。', 'Love Live!第二季 的角色短句，适合放在回忆台词里。', '前进'),
('Love Live!第二季', 'Toujou, Nozomi', '我会继续向前。', 'Love Live!第二季 的角色短句，适合放在回忆台词里。', '前进'),
('Love Live! 虹咲学园校园偶像同好会', 'Tennouji, Rina', '我会继续向前。', 'Love Live! 虹咲学园校园偶像同好会 的角色短句，适合放在回忆台词里。', '前进'),
('Love Live! 虹咲学园校园偶像同好会', 'Yuuki, Setsuna', '我会继续向前。', 'Love Live! 虹咲学园校园偶像同好会 的角色短句，适合放在回忆台词里。', '前进'),
('Love Live! 虹咲学园校园偶像同好会', 'Konoe, Kanata', '我会继续向前。', 'Love Live! 虹咲学园校园偶像同好会 的角色短句，适合放在回忆台词里。', '前进'),
('Love Live! Superstar!!', 'Shibuya, Kanon', '我会继续向前。', 'Love Live! Superstar!! 的角色短句，适合放在回忆台词里。', '前进'),
('Love Live! Superstar!!', 'Tang, Keke', '我会继续向前。', 'Love Live! Superstar!! 的角色短句，适合放在回忆台词里。', '前进'),
('Love Live! Superstar!!', 'Heanna, Sumire', '我会继续向前。', 'Love Live! Superstar!! 的角色短句，适合放在回忆台词里。', '前进'),
('Love Live! Superstar!!第二季', 'Shibuya, Kanon', '我会继续向前。', 'Love Live! Superstar!!第二季 的角色短句，适合放在回忆台词里。', '前进'),
('Love Live! Superstar!!第二季', 'Tang, Keke', '我会继续向前。', 'Love Live! Superstar!!第二季 的角色短句，适合放在回忆台词里。', '前进'),
('Love Live! Superstar!!第二季', 'Heanna, Sumire', '我会继续向前。', 'Love Live! Superstar!!第二季 的角色短句，适合放在回忆台词里。', '前进'),
('租借女友', 'Ichinose, Chizuru', '我会继续向前。', '租借女友 的角色短句，适合放在回忆台词里。', '前进'),
('租借女友', 'Kinoshita, Kazuya', '我会继续向前。', '租借女友 的角色短句，适合放在回忆台词里。', '前进'),
('租借女友', 'Sakurasawa, Sumi', '我会继续向前。', '租借女友 的角色短句，适合放在回忆台词里。', '前进'),
('租借女友 第二季', 'Ichinose, Chizuru', '我会继续向前。', '租借女友 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('租借女友 第二季', 'Kinoshita, Kazuya', '我会继续向前。', '租借女友 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('租借女友 第二季', 'Sakurasawa, Sumi', '我会继续向前。', '租借女友 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('租借女友 第三季', 'Ichinose, Chizuru', '我会继续向前。', '租借女友 第三季 的角色短句，适合放在回忆台词里。', '前进'),
('租借女友 第三季', 'Kinoshita, Kazuya', '我会继续向前。', '租借女友 第三季 的角色短句，适合放在回忆台词里。', '前进'),
('租借女友 第三季', 'Sakurasawa, Sumi', '我会继续向前。', '租借女友 第三季 的角色短句，适合放在回忆台词里。', '前进'),
('租借女友 第四季', 'Ichinose, Chizuru', '我会继续向前。', '租借女友 第四季 的角色短句，适合放在回忆台词里。', '前进'),
('租借女友 第四季', 'Kinoshita, Kazuya', '我会继续向前。', '租借女友 第四季 的角色短句，适合放在回忆台词里。', '前进'),
('租借女友 第四季', 'Sakurasawa, Sumi', '我会继续向前。', '租借女友 第四季 的角色短句，适合放在回忆台词里。', '前进'),
('租借女友 第五季', 'Ichinose, Chizuru', '我会继续向前。', '租借女友 第五季 的角色短句，适合放在回忆台词里。', '前进'),
('租借女友 第五季', 'Kinoshita, Kazuya', '我会继续向前。', '租借女友 第五季 的角色短句，适合放在回忆台词里。', '前进'),
('租借女友 第五季', 'Sakurasawa, Sumi', '我会继续向前。', '租借女友 第五季 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活', 'Natsuki, Subaru', '我会继续向前。', 'Re：从零开始的异世界生活 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活', 'Emilia', '我会继续向前。', 'Re：从零开始的异世界生活 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活', 'Rem', '我会继续向前。', 'Re：从零开始的异世界生活 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活 Memory Snow', 'Natsuki, Subaru', '我会继续向前。', 'Re：从零开始的异世界生活 Memory Snow 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活 Memory Snow', 'Emilia', '我会继续向前。', 'Re：从零开始的异世界生活 Memory Snow 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活 Memory Snow', 'Rem', '我会继续向前。', 'Re：从零开始的异世界生活 Memory Snow 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活 新编集版', 'Natsuki, Subaru', '我会继续向前。', 'Re：从零开始的异世界生活 新编集版 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活 新编集版', 'Emilia', '我会继续向前。', 'Re：从零开始的异世界生活 新编集版 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活 新编集版', 'Rem', '我会继续向前。', 'Re：从零开始的异世界生活 新编集版 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活 冰结之绊', 'Emilia', '我会继续向前。', 'Re：从零开始的异世界生活 冰结之绊 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活 冰结之绊', 'Pack', '我会继续向前。', 'Re：从零开始的异世界生活 冰结之绊 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活 冰结之绊', 'Rem', '我会继续向前。', 'Re：从零开始的异世界生活 冰结之绊 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活第二季', 'Natsuki, Subaru', '我会继续向前。', 'Re：从零开始的异世界生活第二季 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活第二季', 'Emilia', '我会继续向前。', 'Re：从零开始的异世界生活第二季 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活第二季', 'Rem', '我会继续向前。', 'Re：从零开始的异世界生活第二季 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活第三季 反击篇', 'Natsuki, Subaru', '我会继续向前。', 'Re：从零开始的异世界生活第三季 反击篇 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活第三季 反击篇', 'Emilia', '我会继续向前。', 'Re：从零开始的异世界生活第三季 反击篇 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活第三季 反击篇', 'Rem', '我会继续向前。', 'Re：从零开始的异世界生活第三季 反击篇 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活第三季', 'Natsuki, Subaru', '我会继续向前。', 'Re：从零开始的异世界生活第三季 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活第三季', 'Emilia', '我会继续向前。', 'Re：从零开始的异世界生活第三季 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活第三季', 'Rem', '我会继续向前。', 'Re：从零开始的异世界生活第三季 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活第四季', 'Natsuki, Subaru', '我会继续向前。', 'Re：从零开始的异世界生活第四季 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活第四季', 'Emilia', '我会继续向前。', 'Re：从零开始的异世界生活第四季 的角色短句，适合放在回忆台词里。', '前进'),
('Re：从零开始的异世界生活第四季', 'Rem', '我会继续向前。', 'Re：从零开始的异世界生活第四季 的角色短句，适合放在回忆台词里。', '前进'),
('黑色四叶草', 'Asta', '我会继续向前。', '黑色四叶草 的角色短句，适合放在回忆台词里。', '前进'),
('黑色四叶草', 'Silva, Noelle', '我会继续向前。', '黑色四叶草 的角色短句，适合放在回忆台词里。', '前进'),
('黑色四叶草', 'Yuno', '我会继续向前。', '黑色四叶草 的角色短句，适合放在回忆台词里。', '前进'),
('我推的孩子', 'Arima, Kana', '我会继续向前。', '我推的孩子 的角色短句，适合放在回忆台词里。', '前进'),
('我推的孩子', 'Hoshino, Ai', '我会继续向前。', '我推的孩子 的角色短句，适合放在回忆台词里。', '前进'),
('我推的孩子', 'Hoshino, Aquamarine', '我会继续向前。', '我推的孩子 的角色短句，适合放在回忆台词里。', '前进'),
('我推的孩子 第二季', 'Arima, Kana', '我会继续向前。', '我推的孩子 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('我推的孩子 第二季', 'Kurokawa, Akane', '我会继续向前。', '我推的孩子 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('我推的孩子 第二季', 'Hoshino, Aquamarine', '我会继续向前。', '我推的孩子 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('我推的孩子 第三季', 'Arima, Kana', '我会继续向前。', '我推的孩子 第三季 的角色短句，适合放在回忆台词里。', '前进'),
('我推的孩子 第三季', 'Kurokawa, Akane', '我会继续向前。', '我推的孩子 第三季 的角色短句，适合放在回忆台词里。', '前进'),
('我推的孩子 第三季', 'Hoshino, Aquamarine', '我会继续向前。', '我推的孩子 第三季 的角色短句，适合放在回忆台词里。', '前进');

INSERT INTO sekai_memory_book_quote
    (user_id, anime_id, character_name, content, feeling, tag)
SELECT @sekai_user_id, anime.id, seed.character_name, seed.content,
       SUBSTRING_INDEX(GROUP_CONCAT(seed.feeling ORDER BY seed.feeling SEPARATOR '||'), '||', 1),
       seed.tag
FROM seed_20260512_more_quotes seed
JOIN sekai_memory_book_anime anime
  ON anime.user_id = @sekai_user_id
 AND anime.title = seed.anime_title
WHERE @sekai_user_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM sekai_memory_book_quote existing
      WHERE existing.user_id = @sekai_user_id
        AND existing.anime_id = anime.id
        AND existing.character_name = seed.character_name
        AND existing.content = seed.content
  )
GROUP BY anime.id, seed.character_name, seed.content, seed.tag;
