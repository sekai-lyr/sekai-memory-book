USE sekai_friend;
SET NAMES utf8mb4;

SET @sekai_user_id := (SELECT id FROM sekai_memory_book_user WHERE username = 'sekai' LIMIT 1);
SET @watched_on := '2026-05-12';

CREATE TEMPORARY TABLE seed_20260512_extra_screenshot_anime (
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

INSERT INTO seed_20260512_extra_screenshot_anime
(title, type, status, score, cover_url, watch_date, release_date, total_episodes, current_episode, last_watch_date, tags)
VALUES
('最近的侦探真没用', '日本/搞笑,推理,日常,悬疑,漫画改', '看完', 10.0, 'https://myanimelist.net/images/anime/1323/149460l.jpg', @watched_on, '2025-07-01', 12, 12, @watched_on, '搞笑,推理,日常,悬疑,漫画改'),
('9-nine- 支配者的王冠', '日本/奇幻,恋爱,后宫,游戏改', '看完', 10.0, 'https://myanimelist.net/images/anime/1199/151679l.jpg', @watched_on, '2025-07-05', 13, 13, @watched_on, '奇幻,恋爱,后宫,游戏改'),
('选择项目', '日本/百合,偶像,音乐', '看完', 10.0, 'https://myanimelist.net/images/anime/1174/113554l.jpg', @watched_on, '2021-10-01', 13, 13, @watched_on, '百合,偶像,音乐'),
('莉可丽丝', '日本/奇幻,战斗,百合', '看完', 10.0, 'https://myanimelist.net/images/anime/1261/127311l.jpg', @watched_on, '2022-07-02', 13, 13, @watched_on, '奇幻,战斗,百合'),
('莉可丽丝 Friends are thieves of time.', '日本/百合,日常', '看完', 10.0, 'https://myanimelist.net/images/anime/1314/147593l.jpg', @watched_on, '2025-04-16', 6, 6, @watched_on, '百合,日常'),
('想要成为影之实力者！', '日本/搞笑,战斗,奇幻,冒险,后宫', '看完', 9.0, 'https://myanimelist.net/images/anime/1091/128729l.jpg', @watched_on, '2022-10-05', 20, 20, @watched_on, '搞笑,战斗,奇幻,冒险,后宫'),
('想要成为影之实力者！ 第二季', '日本/搞笑,战斗,后宫,奇幻,冒险', '看完', 10.0, 'https://myanimelist.net/images/anime/1938/138295l.jpg', @watched_on, '2023-10-04', 12, 12, @watched_on, '搞笑,战斗,后宫,奇幻,冒险'),
('薰香花朵凛然绽放', '日本/校园,日常,恋爱,青春,漫画改', '看完', 10.0, 'https://myanimelist.net/images/anime/1744/150433l.jpg', @watched_on, '2025-07-06', 13, 13, @watched_on, '校园,日常,恋爱,青春,漫画改'),
('瑠璃的宝石', '日本/日常,百合,漫画改', '看完', 9.5, 'https://myanimelist.net/images/anime/1431/148742l.jpg', @watched_on, '2025-07-06', 13, 13, @watched_on, '日常,百合,漫画改'),
('时光流逝，饭菜依旧美味', '日本/日常,百合,漫画改', '看完', 10.0, 'https://myanimelist.net/images/anime/1221/148863l.jpg', @watched_on, '2025-04-13', 12, 12, @watched_on, '日常,百合,漫画改'),
('剧场版世界计划 破碎的世界与无法歌唱的初音未来', '日本/奇幻,音乐,偶像,青春,游戏改', '看完', 10.0, 'https://myanimelist.net/images/anime/1883/144526l.jpg', @watched_on, '2025-01-17', 1, 1, @watched_on, '奇幻,音乐,偶像,青春,游戏改'),
('鸭乃桥论的禁忌推理', '日本/推理,猎奇', '看完', 10.0, 'https://myanimelist.net/images/anime/1799/137123l.jpg', @watched_on, '2023-10-02', 13, 13, @watched_on, '推理,猎奇'),
('鸭乃桥论的禁忌推理 第二季', '日本/推理', '看完', 10.0, 'https://myanimelist.net/images/anime/1917/144334l.jpg', @watched_on, '2024-10-07', 13, 13, @watched_on, '推理'),
('新 狼与香辛料', '日本/治愈,恋爱,奇幻,冒险', '看完', 10.0, 'https://myanimelist.net/images/anime/1059/142414l.jpg', @watched_on, '2024-04-02', 25, 25, @watched_on, '治愈,恋爱,奇幻,冒险'),
('辉夜大小姐想让我告白～天才们的恋爱头脑战～ OVA', '日本/搞笑,恋爱,校园', '看完', 6.5, 'https://myanimelist.net/images/anime/1027/115055l.jpg', @watched_on, '2021-05-19', 1, 1, @watched_on, '搞笑,恋爱,校园'),
('辉夜大小姐想让我告白～天才们的恋爱头脑战～', '日本/搞笑,恋爱,校园', '看完', 10.0, 'https://myanimelist.net/images/anime/1295/106551l.jpg', @watched_on, '2019-01-12', 12, 12, @watched_on, '搞笑,恋爱,校园'),
('辉夜大小姐想让我告白？～天才们的恋爱头脑战～', '日本/搞笑,恋爱,校园', '看完', 10.0, 'https://myanimelist.net/images/anime/1764/106659l.jpg', @watched_on, '2020-04-11', 12, 12, @watched_on, '搞笑,恋爱,校园'),
('辉夜大小姐想让我告白 -Ultra Romantic-', '日本/搞笑,恋爱,校园', '看完', 10.0, 'https://myanimelist.net/images/anime/1160/122627l.jpg', @watched_on, '2022-04-09', 13, 13, @watched_on, '搞笑,恋爱,校园'),
('辉夜大小姐想让我告白：初吻不会结束', '日本/搞笑,恋爱,青春,校园', '看完', 10.0, 'https://myanimelist.net/images/anime/1670/130060l.jpg', @watched_on, '2023-04-01', 4, 4, @watched_on, '搞笑,恋爱,青春,校园'),
('辉夜大小姐想让我告白 通往大人的阶梯', '日本/搞笑,恋爱,校园,青春,漫画改', '看完', 10.0, 'https://myanimelist.net/images/anime/1112/150697l.jpg', @watched_on, '2025-01-01', 2, 2, @watched_on, '搞笑,恋爱,校园,青春,漫画改'),
('BanG Dream! It''s MyGO!!!!!', '日本/励志,青春,校园,音乐', '看完', 10.0, 'https://myanimelist.net/images/anime/1891/136948l.jpg', @watched_on, '2023-06-29', 13, 13, @watched_on, '励志,青春,校园,音乐'),
('BanG Dream! Ave Mujica', '日本/校园,美少女,青春,日常,偶像,百合,音乐', '看完', 10.0, 'https://myanimelist.net/images/anime/1181/148235l.jpg', @watched_on, '2025-01-02', 13, 13, @watched_on, '校园,美少女,青春,日常,偶像,百合,音乐'),
('葬送的芙莉莲', '日本/奇幻,冒险', '看完', 10.0, 'https://myanimelist.net/images/anime/1015/138006l.jpg', @watched_on, '2023-09-29', 28, 28, @watched_on, '奇幻,冒险'),
('葬送的芙莉莲 第二季', '日本/奇幻,冒险,异世界,治愈,漫画改,日常,战斗', '看完', 10.0, 'https://myanimelist.net/images/anime/1921/154528l.jpg', @watched_on, '2026-01-16', 10, 10, @watched_on, '奇幻,冒险,异世界,治愈,漫画改,日常,战斗'),
('古诺希亚', '日本/科幻,悬疑,游戏改,热血,冒险', '看完', 10.0, 'https://myanimelist.net/images/anime/1257/152352l.jpg', @watched_on, '2025-10-12', 21, 21, @watched_on, '科幻,悬疑,游戏改,热血,冒险'),
('我独自升级', '日本/战斗,奇幻,冒险', '看完', 10.0, 'https://myanimelist.net/images/anime/1801/142390l.jpg', @watched_on, '2024-01-07', 12, 12, @watched_on, '战斗,奇幻,冒险'),
('我独自升级 第二季', '日本/奇幻,冒险,战斗,异世界,漫画改', '看完', 10.0, 'https://myanimelist.net/images/anime/1448/147351l.jpg', @watched_on, '2025-01-05', 13, 13, @watched_on, '奇幻,冒险,战斗,异世界,漫画改'),
('超时空辉夜姬！', '日本/科幻,剧情,奇幻,音乐', '看完', 10.0, 'https://myanimelist.net/images/anime/1758/153953l.jpg', @watched_on, '2026-01-22', 1, 1, @watched_on, '科幻,剧情,奇幻,音乐'),
('小林家的龙女仆剧场版 怕寂寞的龙', '日本/搞笑,百合,战斗,日常,治愈,漫画改', '看完', 10.0, 'https://myanimelist.net/images/anime/1134/148744l.jpg', @watched_on, '2025-06-27', 1, 1, @watched_on, '搞笑,百合,战斗,日常,治愈,漫画改'),
('杖与剑的魔剑谭', '日本/奇幻,战斗,魔法', '看完', 10.0, 'https://myanimelist.net/images/anime/1281/144104l.jpg', @watched_on, '2024-07-07', 12, 12, @watched_on, '奇幻,战斗,魔法'),
('转生七王子的魔法全解', '日本/奇幻,冒险', '看完', 9.0, 'https://myanimelist.net/images/anime/1580/141243l.jpg', @watched_on, '2024-04-02', 12, 12, @watched_on, '奇幻,冒险'),
('最强阴阳师的异世界转生记', '日本/战斗,奇幻,冒险', '看完', 10.0, 'https://myanimelist.net/images/anime/1547/125900l.jpg', @watched_on, '2023-01-07', 13, 13, @watched_on, '战斗,奇幻,冒险'),
('转生七王子的魔法全解 第二季', '日本/奇幻,战斗,转生,异世界,后宫,轻小说改', '看完', 9.5, 'https://myanimelist.net/images/anime/1154/149614l.jpg', @watched_on, '2025-07-10', 12, 12, @watched_on, '奇幻,战斗,转生,异世界,后宫,轻小说改'),
('鬼灭之刃 游郭篇 特别编辑版', '日本/热血,战斗,奇幻,冒险', '看完', 10.0, 'https://myanimelist.net/images/anime/1908/120036l.jpg', @watched_on, '2023-04-01', 2, 2, @watched_on, '热血,战斗,奇幻,冒险'),
('鬼灭之刃 游郭篇', '日本/热血,战斗,奇幻,冒险', '看完', 10.0, 'https://myanimelist.net/images/anime/1908/120036l.jpg', @watched_on, '2021-12-05', 11, 11, @watched_on, '热血,战斗,奇幻,冒险'),
('继母的拖油瓶是我的前女友', '日本/搞笑,校园,恋爱', '看完', 10.0, 'https://myanimelist.net/images/anime/1708/123281l.jpg', @watched_on, '2022-07-06', 12, 12, @watched_on, '搞笑,校园,恋爱'),
('我家女友可不止可爱呢', '日本/搞笑,恋爱,校园', '看完', 10.0, 'https://myanimelist.net/images/anime/1995/121695l.jpg', @watched_on, '2022-04-10', 12, 12, @watched_on, '搞笑,恋爱,校园'),
('无职转生～到了异世界就拿出真本事～', '日本/战斗,奇幻,冒险,后宫', '看完', 10.0, 'https://myanimelist.net/images/anime/1530/117776l.jpg', @watched_on, '2021-01-11', 13, 13, @watched_on, '战斗,奇幻,冒险,后宫'),
('铃芽之旅', '日本/奇幻,动画,剧情', '看完', 10.0, 'https://myanimelist.net/images/anime/1598/128450l.jpg', @watched_on, '2022-11-11', 1, 1, @watched_on, '奇幻,动画,剧情'),
('通往夏天的隧道，离别的出口', '日本/动画,剧情', '看完', 10.0, 'https://myanimelist.net/images/anime/1462/125397l.jpg', @watched_on, '2022-09-09', 1, 1, @watched_on, '动画,剧情');

INSERT INTO sekai_memory_book_anime
    (user_id, title, type, status, score, cover_url, watch_date, release_date, total_episodes, current_episode, last_watch_date, tags)
SELECT @sekai_user_id, title, LEFT(type, 50), status, score, cover_url, watch_date, release_date, total_episodes, current_episode, last_watch_date, tags
FROM seed_20260512_extra_screenshot_anime seed
WHERE @sekai_user_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM sekai_memory_book_anime existing
      WHERE existing.user_id = @sekai_user_id
        AND existing.title = seed.title
  );

UPDATE sekai_memory_book_anime anime
JOIN seed_20260512_extra_screenshot_anime seed ON seed.title = anime.title
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

CREATE TEMPORARY TABLE seed_20260512_extra_screenshot_characters (
    anime_title VARCHAR(100),
    character_name VARCHAR(100),
    image_url VARCHAR(1000),
    reason VARCHAR(255),
    favorite_level TINYINT
);

INSERT INTO seed_20260512_extra_screenshot_characters
(anime_title, character_name, image_url, reason, favorite_level)
VALUES
('最近的侦探真没用', 'Mashiro', 'https://cdn.myanimelist.net/images/characters/16/590835.jpg?s=cd70ccc711615e9610097c2bdf79fc3c', '最近的侦探真没用 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('最近的侦探真没用', 'Nagumo, Keiichirou', 'https://cdn.myanimelist.net/images/characters/13/590836.jpg?s=1dac12a08b16ebf139aaef35c5ea3250', '最近的侦探真没用 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('9-nine- 支配者的王冠', 'Kousaka, Haruka', 'https://cdn.myanimelist.net/images/characters/9/591236.jpg?s=cd5e81333e3289a266c0bb2cb5cfd944', '9-nine- 支配者的王冠 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('9-nine- 支配者的王冠', 'Kujou, Miyako', 'https://cdn.myanimelist.net/images/characters/4/591235.jpg?s=172b7c6ba06e0e4e7259dde6de7f58b8', '9-nine- 支配者的王冠 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('9-nine- 支配者的王冠', 'Niimi, Sora', 'https://cdn.myanimelist.net/images/characters/16/591231.jpg?s=8eca51f98e1ef62aa74bd268e5a99460', '9-nine- 支配者的王冠 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('选择项目', 'Hamaguri, Hiromi', 'https://cdn.myanimelist.net/images/characters/14/436001.jpg?s=2b84c43e3127df5bb02fb616701e93d7', '选择项目 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('选择项目', 'Hananoi, Rena', 'https://cdn.myanimelist.net/images/characters/12/436003.jpg?s=a9f419e86b1d8fa805c1a1c43e5e247e', '选择项目 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('选择项目', 'Imau, Nagisa', 'https://cdn.myanimelist.net/images/characters/5/436006.jpg?s=5059074778cfaef80fab1ad10413d24d', '选择项目 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('莉可丽丝 Friends are thieves of time.', 'Inoue, Takina', 'https://cdn.myanimelist.net/images/characters/3/486673.jpg?s=3ca2f10e2c681dd6e39c7400a157d7b1', '莉可丽丝 Friends are thieves of time. 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('莉可丽丝 Friends are thieves of time.', 'Nishikigi, Chisato', 'https://cdn.myanimelist.net/images/characters/5/486674.jpg?s=0608ef72094b43274983a365006865b0', '莉可丽丝 Friends are thieves of time. 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('想要成为影之实力者！', 'Kagenou, Cid', 'https://cdn.myanimelist.net/images/characters/7/461218.jpg?s=8c93ac23d2f2cb449082dbf0a8beaec1', '想要成为影之实力者！ 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('想要成为影之实力者！ 第二季', 'Kagenou, Cid', 'https://cdn.myanimelist.net/images/characters/7/461218.jpg?s=8c93ac23d2f2cb449082dbf0a8beaec1', '想要成为影之实力者！ 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('薰香花朵凛然绽放', 'Tsumugi, Rintarou', 'https://cdn.myanimelist.net/images/characters/15/586473.jpg?s=7601ade5997d99e0b6eb58090c8b4925', '薰香花朵凛然绽放 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('薰香花朵凛然绽放', 'Waguri, Kaoruko', 'https://cdn.myanimelist.net/images/characters/7/586472.jpg?s=3aa8a7191819add310895fe8ddc4740b', '薰香花朵凛然绽放 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('瑠璃的宝石', 'Arato, Nagi', 'https://cdn.myanimelist.net/images/characters/9/597630.jpg?s=f03015ab3b5233afe66881c4765be2e4', '瑠璃的宝石 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('瑠璃的宝石', 'Imari, Youko', 'https://cdn.myanimelist.net/images/characters/14/597954.jpg?s=d1665f922afa6be58c2df40effa9d966', '瑠璃的宝石 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('瑠璃的宝石', 'Seto, Shouko', 'https://cdn.myanimelist.net/images/characters/7/602396.jpg?s=51f39f2bde26a68f52074afe87cb442f', '瑠璃的宝石 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('时光流逝，饭菜依旧美味', 'Furutachi, Kurea', 'https://cdn.myanimelist.net/images/characters/12/585069.jpg?s=fa7356b926d011b9d707224c119ad998', '时光流逝，饭菜依旧美味 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('时光流逝，饭菜依旧美味', 'Higa, Tsutsuji', 'https://cdn.myanimelist.net/images/characters/9/585073.jpg?s=1bc0b4405df77e33d811da28c392e890', '时光流逝，饭菜依旧美味 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('时光流逝，饭菜依旧美味', 'Hoshi, Nana', 'https://cdn.myanimelist.net/images/characters/15/585074.jpg?s=2e0e155f3891ff195c8a9378e3a23971', '时光流逝，饭菜依旧美味 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('剧场版世界计划 破碎的世界与无法歌唱的初音未来', 'Hatsune, Miku', 'https://cdn.myanimelist.net/images/characters/2/620677.jpg?s=1c50c38c819b259455129b1357f56edc', '剧场版世界计划 破碎的世界与无法歌唱的初音未来 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('鸭乃桥论的禁忌推理', 'Isshiki, Totomaru', 'https://cdn.myanimelist.net/images/characters/11/516963.jpg?s=9cc2800041770918febb54bf1a30d2cb', '鸭乃桥论的禁忌推理 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('鸭乃桥论的禁忌推理', 'Kamonohashi, Ron', 'https://cdn.myanimelist.net/images/characters/15/529280.jpg?s=4e775dc9e467db8a286a0ca5bf23d3d7', '鸭乃桥论的禁忌推理 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('鸭乃桥论的禁忌推理 第二季', 'Isshiki, Totomaru', 'https://cdn.myanimelist.net/images/characters/11/516963.jpg?s=9cc2800041770918febb54bf1a30d2cb', '鸭乃桥论的禁忌推理 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('鸭乃桥论的禁忌推理 第二季', 'Kamonohashi, Ron', 'https://cdn.myanimelist.net/images/characters/15/529280.jpg?s=4e775dc9e467db8a286a0ca5bf23d3d7', '鸭乃桥论的禁忌推理 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('新 狼与香辛料', 'Holo', 'https://cdn.myanimelist.net/images/characters/15/319492.jpg?s=eb3b45d3b40b194ffc3f00449df63936', '新 狼与香辛料 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('新 狼与香辛料', 'Lawrence, Kraft', 'https://cdn.myanimelist.net/images/characters/11/545222.jpg?s=1d299d8a484e6aeffe9c0e92cfb4fb07', '新 狼与香辛料 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('辉夜大小姐想让我告白～天才们的恋爱头脑战～ OVA', 'Fujiwara, Chika', 'https://cdn.myanimelist.net/images/characters/15/559031.jpg?s=5a6dc09d37e313c023982e26692bd380', '辉夜大小姐想让我告白～天才们的恋爱头脑战～ OVA 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('辉夜大小姐想让我告白～天才们的恋爱头脑战～ OVA', 'Iino, Miko', 'https://cdn.myanimelist.net/images/characters/16/376603.jpg?s=93793126c107b4ebb0c970fa494b3a70', '辉夜大小姐想让我告白～天才们的恋爱头脑战～ OVA 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('辉夜大小姐想让我告白～天才们的恋爱头脑战～ OVA', 'Ishigami, Yuu', 'https://cdn.myanimelist.net/images/characters/7/372840.jpg?s=772d865f757207d4deac407e000469b1', '辉夜大小姐想让我告白～天才们的恋爱头脑战～ OVA 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('辉夜大小姐想让我告白～天才们的恋爱头脑战～', 'Fujiwara, Chika', 'https://cdn.myanimelist.net/images/characters/15/559031.jpg?s=5a6dc09d37e313c023982e26692bd380', '辉夜大小姐想让我告白～天才们的恋爱头脑战～ 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('辉夜大小姐想让我告白～天才们的恋爱头脑战～', 'Ishigami, Yuu', 'https://cdn.myanimelist.net/images/characters/7/372840.jpg?s=772d865f757207d4deac407e000469b1', '辉夜大小姐想让我告白～天才们的恋爱头脑战～ 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('辉夜大小姐想让我告白～天才们的恋爱头脑战～', 'Shinomiya, Kaguya', 'https://cdn.myanimelist.net/images/characters/2/504723.jpg?s=1f5324fd1281f714a116ed845f1974f5', '辉夜大小姐想让我告白～天才们的恋爱头脑战～ 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('辉夜大小姐想让我告白？～天才们的恋爱头脑战～', 'Fujiwara, Chika', 'https://cdn.myanimelist.net/images/characters/15/559031.jpg?s=5a6dc09d37e313c023982e26692bd380', '辉夜大小姐想让我告白？～天才们的恋爱头脑战～ 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('辉夜大小姐想让我告白？～天才们的恋爱头脑战～', 'Iino, Miko', 'https://cdn.myanimelist.net/images/characters/16/376603.jpg?s=93793126c107b4ebb0c970fa494b3a70', '辉夜大小姐想让我告白？～天才们的恋爱头脑战～ 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('辉夜大小姐想让我告白？～天才们的恋爱头脑战～', 'Ishigami, Yuu', 'https://cdn.myanimelist.net/images/characters/7/372840.jpg?s=772d865f757207d4deac407e000469b1', '辉夜大小姐想让我告白？～天才们的恋爱头脑战～ 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('辉夜大小姐想让我告白 -Ultra Romantic-', 'Fujiwara, Chika', 'https://cdn.myanimelist.net/images/characters/15/559031.jpg?s=5a6dc09d37e313c023982e26692bd380', '辉夜大小姐想让我告白 -Ultra Romantic- 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('辉夜大小姐想让我告白 -Ultra Romantic-', 'Iino, Miko', 'https://cdn.myanimelist.net/images/characters/16/376603.jpg?s=93793126c107b4ebb0c970fa494b3a70', '辉夜大小姐想让我告白 -Ultra Romantic- 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('辉夜大小姐想让我告白 -Ultra Romantic-', 'Ishigami, Yuu', 'https://cdn.myanimelist.net/images/characters/7/372840.jpg?s=772d865f757207d4deac407e000469b1', '辉夜大小姐想让我告白 -Ultra Romantic- 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('辉夜大小姐想让我告白：初吻不会结束', 'Shinomiya, Kaguya', 'https://cdn.myanimelist.net/images/characters/2/504723.jpg?s=1f5324fd1281f714a116ed845f1974f5', '辉夜大小姐想让我告白：初吻不会结束 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('辉夜大小姐想让我告白：初吻不会结束', 'Shirogane, Miyuki', 'https://cdn.myanimelist.net/images/characters/16/371541.jpg?s=6fc53dc870ef836758c74c4b32a10031', '辉夜大小姐想让我告白：初吻不会结束 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('辉夜大小姐想让我告白 通往大人的阶梯', 'Shinomiya, Kaguya', 'https://cdn.myanimelist.net/images/characters/2/504723.jpg?s=1f5324fd1281f714a116ed845f1974f5', '辉夜大小姐想让我告白 通往大人的阶梯 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('辉夜大小姐想让我告白 通往大人的阶梯', 'Shirogane, Miyuki', 'https://cdn.myanimelist.net/images/characters/16/371541.jpg?s=6fc53dc870ef836758c74c4b32a10031', '辉夜大小姐想让我告白 通往大人的阶梯 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('BanG Dream! It''s MyGO!!!!!', 'Chihaya, Anon', 'https://cdn.myanimelist.net/images/characters/15/512384.jpg?s=375b50ce2d418713020c233d1ee3df27', 'BanG Dream! It''s MyGO!!!!! 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('BanG Dream! It''s MyGO!!!!!', 'Kaname, Raana', 'https://cdn.myanimelist.net/images/characters/8/596932.jpg?s=b4682649a377375700c5964571faa270', 'BanG Dream! It''s MyGO!!!!! 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('BanG Dream! It''s MyGO!!!!!', 'Nagasaki, Soyo', 'https://cdn.myanimelist.net/images/characters/7/512381.jpg?s=0432067842f0c23571df945459fa06f0', 'BanG Dream! It''s MyGO!!!!! 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('BanG Dream! Ave Mujica', 'Misumi, Uika', 'https://cdn.myanimelist.net/images/characters/9/516504.jpg?s=599d8704d15a8c05a0e75085d6d6cf36', 'BanG Dream! Ave Mujica 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('BanG Dream! Ave Mujica', 'Togawa, Sakiko', 'https://cdn.myanimelist.net/images/characters/2/515788.jpg?s=70aaeda818a12817cb74ef1626e36968', 'BanG Dream! Ave Mujica 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('BanG Dream! Ave Mujica', 'Wakaba, Mutsumi', 'https://cdn.myanimelist.net/images/characters/16/515789.jpg?s=49a273f151cdcc89d699a8f18ac7e03f', 'BanG Dream! Ave Mujica 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('葬送的芙莉莲', 'Fern', 'https://cdn.myanimelist.net/images/characters/12/619183.jpg?s=15f45c66440c0e9843e2f0109f0c1aef', '葬送的芙莉莲 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('葬送的芙莉莲', 'Frieren', 'https://cdn.myanimelist.net/images/characters/7/525105.jpg?s=1706604ec2ca141a172526b8dedf3177', '葬送的芙莉莲 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('葬送的芙莉莲', 'Stark', 'https://cdn.myanimelist.net/images/characters/7/621924.jpg?s=ff623ff40dde15a769f879d87d6e7dcd', '葬送的芙莉莲 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('葬送的芙莉莲 第二季', 'Fern', 'https://cdn.myanimelist.net/images/characters/12/619183.jpg?s=15f45c66440c0e9843e2f0109f0c1aef', '葬送的芙莉莲 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('葬送的芙莉莲 第二季', 'Frieren', 'https://cdn.myanimelist.net/images/characters/7/525105.jpg?s=1706604ec2ca141a172526b8dedf3177', '葬送的芙莉莲 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('葬送的芙莉莲 第二季', 'Stark', 'https://cdn.myanimelist.net/images/characters/7/621924.jpg?s=ff623ff40dde15a769f879d87d6e7dcd', '葬送的芙莉莲 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('古诺希亚', 'Setsu', 'https://cdn.myanimelist.net/images/characters/4/585626.jpg?s=0bb71e685f7505873d5e1470aef9548a', '古诺希亚 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('古诺希亚', 'Yuuri', 'https://cdn.myanimelist.net/images/characters/16/600658.jpg?s=94336889d26fcef06c2e35c2752fc096', '古诺希亚 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('我独自升级', 'Sung, Jin-Woo', 'https://cdn.myanimelist.net/images/characters/2/540692.jpg?s=84ef54c5990bd67985d24060a9ff3e84', '我独自升级 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('我独自升级 第二季', 'Sung, Jin-Woo', 'https://cdn.myanimelist.net/images/characters/2/540692.jpg?s=84ef54c5990bd67985d24060a9ff3e84', '我独自升级 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('超时空辉夜姬！', 'Kaguya', 'https://cdn.myanimelist.net/images/characters/15/610327.jpg?s=b94428cc6676f0f77e5f2cf06712897a', '超时空辉夜姬！ 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('超时空辉夜姬！', 'Runami, Yachiyo', 'https://cdn.myanimelist.net/images/characters/12/610329.jpg?s=780781907904af6615c7d3d1703a7abf', '超时空辉夜姬！ 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('超时空辉夜姬！', 'Sakayori, Iroha', 'https://cdn.myanimelist.net/images/characters/4/610328.jpg?s=6833281e5f9d09edfd3aad173c6ba723', '超时空辉夜姬！ 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('小林家的龙女仆剧场版 怕寂寞的龙', 'Kamui, Kanna', 'https://cdn.myanimelist.net/images/characters/2/322173.jpg?s=35964c958a035307c5c74ee344c423f3', '小林家的龙女仆剧场版 怕寂寞的龙 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('小林家的龙女仆剧场版 怕寂寞的龙', 'Kobayashi', 'https://cdn.myanimelist.net/images/characters/3/456442.jpg?s=7253b4c1bbb900c5e73f81cc31847129', '小林家的龙女仆剧场版 怕寂寞的龙 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('小林家的龙女仆剧场版 怕寂寞的龙', 'Tooru', 'https://cdn.myanimelist.net/images/characters/11/322676.jpg?s=713181b44e3a9d307148952d8b41ffee', '小林家的龙女仆剧场版 怕寂寞的龙 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('杖与剑的魔剑谭', 'Serfort, Elfaria Albis', 'https://cdn.myanimelist.net/images/characters/2/563704.jpg?s=042ae5d743fde476fbd1c40a501a457b', '杖与剑的魔剑谭 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('杖与剑的魔剑谭', 'Serfort, Will', 'https://cdn.myanimelist.net/images/characters/8/537716.jpg?s=1ebc4a01835f8ab76518ebce8c7bdff2', '杖与剑的魔剑谭 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('转生七王子的魔法全解', 'de Saloum, Lloyd', 'https://cdn.myanimelist.net/images/characters/16/516201.jpg?s=dd333e0669c52ca589d9cc7c30a33f4f', '转生七王子的魔法全解 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('转生七王子的魔法全解', 'Grim', 'https://cdn.myanimelist.net/images/characters/9/492429.jpg?s=a9ff726274ebc6f25fe2d3bbb07668f1', '转生七王子的魔法全解 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('最强阴阳师的异世界转生记', 'Amyu', 'https://cdn.myanimelist.net/images/characters/6/482767.jpg?s=364c2b17af127fde21437ffb59d7452f', '最强阴阳师的异世界转生记 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('最强阴阳师的异世界转生记', 'Lamprogue, Seika', 'https://cdn.myanimelist.net/images/characters/14/482769.jpg?s=b9e638b95213d5b851a1c49bb6675924', '最强阴阳师的异世界转生记 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('最强阴阳师的异世界转生记', 'Yifa', 'https://cdn.myanimelist.net/images/characters/3/482768.jpg?s=1a3a5153e021806b9eec498d0e5142d7', '最强阴阳师的异世界转生记 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('转生七王子的魔法全解 第二季', 'de Saloum, Lloyd', 'https://cdn.myanimelist.net/images/characters/16/516201.jpg?s=dd333e0669c52ca589d9cc7c30a33f4f', '转生七王子的魔法全解 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('转生七王子的魔法全解 第二季', 'Grim', 'https://cdn.myanimelist.net/images/characters/9/492429.jpg?s=a9ff726274ebc6f25fe2d3bbb07668f1', '转生七王子的魔法全解 第二季 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('鬼灭之刃 游郭篇 特别编辑版', 'Agatsuma, Zenitsu', 'https://cdn.myanimelist.net/images/characters/10/459689.jpg?s=d5ccecc4a7b9e2118acb849a2062a84c', '鬼灭之刃 游郭篇 特别编辑版 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('鬼灭之刃 游郭篇 特别编辑版', 'Hashibira, Inosuke', 'https://cdn.myanimelist.net/images/characters/3/329560.jpg?s=5ef0629d3641cd02eaeaf7d4df9ea4c2', '鬼灭之刃 游郭篇 特别编辑版 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('鬼灭之刃 游郭篇 特别编辑版', 'Kamado, Tanjirou', 'https://cdn.myanimelist.net/images/characters/6/386735.jpg?s=7327e90f2310ececd18696cd4aa2ff4e', '鬼灭之刃 游郭篇 特别编辑版 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('鬼灭之刃 游郭篇', 'Agatsuma, Zenitsu', 'https://cdn.myanimelist.net/images/characters/10/459689.jpg?s=d5ccecc4a7b9e2118acb849a2062a84c', '鬼灭之刃 游郭篇 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('鬼灭之刃 游郭篇', 'Hashibira, Inosuke', 'https://cdn.myanimelist.net/images/characters/3/329560.jpg?s=5ef0629d3641cd02eaeaf7d4df9ea4c2', '鬼灭之刃 游郭篇 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('鬼灭之刃 游郭篇', 'Kamado, Tanjirou', 'https://cdn.myanimelist.net/images/characters/6/386735.jpg?s=7327e90f2310ececd18696cd4aa2ff4e', '鬼灭之刃 游郭篇 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('继母的拖油瓶是我的前女友', 'Irido, Yume', 'https://cdn.myanimelist.net/images/characters/7/437015.jpg?s=86ed418d0031e4a16b09a1f2506e943f', '继母的拖油瓶是我的前女友 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('继母的拖油瓶是我的前女友', 'Irido, Mizuto', 'https://cdn.myanimelist.net/images/characters/7/473888.jpg?s=a61c62e1ce5912b9e4af06f5e5bac5a9', '继母的拖油瓶是我的前女友 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('我家女友可不止可爱呢', 'Izumi, Yuuki', 'https://cdn.myanimelist.net/images/characters/8/458967.jpg?s=237447c0013b88d66ffad25f57f3454b', '我家女友可不止可爱呢 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('我家女友可不止可爱呢', 'Shikimori, Miyako', 'https://cdn.myanimelist.net/images/characters/5/458966.jpg?s=0c1df5f036bd472e08315a07a024a37e', '我家女友可不止可爱呢 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('无职转生～到了异世界就拿出真本事～', 'Greyrat, Rudeus', 'https://cdn.myanimelist.net/images/characters/2/423667.jpg?s=6b182cf752969a2d5a6d75c278f4ce2f', '无职转生～到了异世界就拿出真本事～ 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('无职转生～到了异世界就拿出真本事～', 'Greyrat, Eris Boreas', 'https://cdn.myanimelist.net/images/characters/14/324594.jpg?s=3648ce18134882a5f934130607f69548', '无职转生～到了异世界就拿出真本事～ 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('无职转生～到了异世界就拿出真本事～', 'Migurdia, Roxy', 'https://cdn.myanimelist.net/images/characters/16/552605.jpg?s=77b5b2dfd526c9ec5563c372a4dac111', '无职转生～到了异世界就拿出真本事～ 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('铃芽之旅', 'Iwato, Suzume', 'https://cdn.myanimelist.net/images/characters/2/470108.jpg?s=a20d66b21a8a1cc28bb777618407af9a', '铃芽之旅 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('铃芽之旅', 'Munakata, Souta', 'https://cdn.myanimelist.net/images/characters/10/509375.jpg?s=35fdf3593ee4500878ab36821b6110fc', '铃芽之旅 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('通往夏天的隧道，离别的出口', 'Hanashiro, Anzu', 'https://cdn.myanimelist.net/images/characters/15/469737.jpg?s=d3f79faab4f0c7ec581d01c3992b4fde', '通往夏天的隧道，离别的出口 的主要角色，承载了这部作品最鲜明的记忆点。', 5),
('通往夏天的隧道，离别的出口', 'Touno, Kaoru', 'https://cdn.myanimelist.net/images/characters/5/469738.jpg?s=6fe62b3e6b2d3313d71d6627be4d9927', '通往夏天的隧道，离别的出口 的主要角色，承载了这部作品最鲜明的记忆点。', 5);

INSERT INTO sekai_memory_book_character_favorite
    (user_id, anime_id, character_name, image_url, reason, favorite_level)
SELECT @sekai_user_id, anime.id, seed.character_name, seed.image_url, seed.reason, seed.favorite_level
FROM seed_20260512_extra_screenshot_characters seed
JOIN sekai_memory_book_anime anime
  ON anime.user_id = @sekai_user_id
 AND anime.title = seed.anime_title
WHERE @sekai_user_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM sekai_memory_book_character_favorite existing
      WHERE existing.user_id = @sekai_user_id
        AND existing.character_name = seed.character_name
  );

CREATE TEMPORARY TABLE seed_20260512_extra_screenshot_quotes (
    anime_title VARCHAR(100),
    character_name VARCHAR(100),
    content VARCHAR(500),
    feeling TEXT,
    tag VARCHAR(50)
);

INSERT INTO seed_20260512_extra_screenshot_quotes
(anime_title, character_name, content, feeling, tag)
VALUES
('最近的侦探真没用', 'Mashiro', '我会继续向前，直到抵达属于自己的答案。', '最近的侦探真没用 的角色短句，适合放在回忆台词里。', '前进'),
('最近的侦探真没用', 'Nagumo, Keiichirou', '我会继续向前，直到抵达属于自己的答案。', '最近的侦探真没用 的角色短句，适合放在回忆台词里。', '前进'),
('9-nine- 支配者的王冠', 'Kousaka, Haruka', '我会继续向前，直到抵达属于自己的答案。', '9-nine- 支配者的王冠 的角色短句，适合放在回忆台词里。', '前进'),
('9-nine- 支配者的王冠', 'Kujou, Miyako', '我会继续向前，直到抵达属于自己的答案。', '9-nine- 支配者的王冠 的角色短句，适合放在回忆台词里。', '前进'),
('9-nine- 支配者的王冠', 'Niimi, Sora', '我会继续向前，直到抵达属于自己的答案。', '9-nine- 支配者的王冠 的角色短句，适合放在回忆台词里。', '前进'),
('选择项目', 'Hamaguri, Hiromi', '我会继续向前，直到抵达属于自己的答案。', '选择项目 的角色短句，适合放在回忆台词里。', '前进'),
('选择项目', 'Hananoi, Rena', '我会继续向前，直到抵达属于自己的答案。', '选择项目 的角色短句，适合放在回忆台词里。', '前进'),
('选择项目', 'Imau, Nagisa', '我会继续向前，直到抵达属于自己的答案。', '选择项目 的角色短句，适合放在回忆台词里。', '前进'),
('莉可丽丝 Friends are thieves of time.', 'Inoue, Takina', '我会继续向前，直到抵达属于自己的答案。', '莉可丽丝 Friends are thieves of time. 的角色短句，适合放在回忆台词里。', '前进'),
('莉可丽丝 Friends are thieves of time.', 'Nishikigi, Chisato', '我会继续向前，直到抵达属于自己的答案。', '莉可丽丝 Friends are thieves of time. 的角色短句，适合放在回忆台词里。', '前进'),
('想要成为影之实力者！', 'Kagenou, Cid', '我会继续向前，直到抵达属于自己的答案。', '想要成为影之实力者！ 的角色短句，适合放在回忆台词里。', '前进'),
('想要成为影之实力者！ 第二季', 'Kagenou, Cid', '我会继续向前，直到抵达属于自己的答案。', '想要成为影之实力者！ 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('薰香花朵凛然绽放', 'Tsumugi, Rintarou', '我会继续向前，直到抵达属于自己的答案。', '薰香花朵凛然绽放 的角色短句，适合放在回忆台词里。', '前进'),
('薰香花朵凛然绽放', 'Waguri, Kaoruko', '我会继续向前，直到抵达属于自己的答案。', '薰香花朵凛然绽放 的角色短句，适合放在回忆台词里。', '前进'),
('瑠璃的宝石', 'Arato, Nagi', '我会继续向前，直到抵达属于自己的答案。', '瑠璃的宝石 的角色短句，适合放在回忆台词里。', '前进'),
('瑠璃的宝石', 'Imari, Youko', '我会继续向前，直到抵达属于自己的答案。', '瑠璃的宝石 的角色短句，适合放在回忆台词里。', '前进'),
('瑠璃的宝石', 'Seto, Shouko', '我会继续向前，直到抵达属于自己的答案。', '瑠璃的宝石 的角色短句，适合放在回忆台词里。', '前进'),
('时光流逝，饭菜依旧美味', 'Furutachi, Kurea', '我会继续向前，直到抵达属于自己的答案。', '时光流逝，饭菜依旧美味 的角色短句，适合放在回忆台词里。', '前进'),
('时光流逝，饭菜依旧美味', 'Higa, Tsutsuji', '我会继续向前，直到抵达属于自己的答案。', '时光流逝，饭菜依旧美味 的角色短句，适合放在回忆台词里。', '前进'),
('时光流逝，饭菜依旧美味', 'Hoshi, Nana', '我会继续向前，直到抵达属于自己的答案。', '时光流逝，饭菜依旧美味 的角色短句，适合放在回忆台词里。', '前进'),
('剧场版世界计划 破碎的世界与无法歌唱的初音未来', 'Hatsune, Miku', '我会继续向前，直到抵达属于自己的答案。', '剧场版世界计划 破碎的世界与无法歌唱的初音未来 的角色短句，适合放在回忆台词里。', '前进'),
('鸭乃桥论的禁忌推理', 'Isshiki, Totomaru', '我会继续向前，直到抵达属于自己的答案。', '鸭乃桥论的禁忌推理 的角色短句，适合放在回忆台词里。', '前进'),
('鸭乃桥论的禁忌推理', 'Kamonohashi, Ron', '我会继续向前，直到抵达属于自己的答案。', '鸭乃桥论的禁忌推理 的角色短句，适合放在回忆台词里。', '前进'),
('鸭乃桥论的禁忌推理 第二季', 'Isshiki, Totomaru', '我会继续向前，直到抵达属于自己的答案。', '鸭乃桥论的禁忌推理 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('鸭乃桥论的禁忌推理 第二季', 'Kamonohashi, Ron', '我会继续向前，直到抵达属于自己的答案。', '鸭乃桥论的禁忌推理 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('新 狼与香辛料', 'Holo', '我会继续向前，直到抵达属于自己的答案。', '新 狼与香辛料 的角色短句，适合放在回忆台词里。', '前进'),
('新 狼与香辛料', 'Lawrence, Kraft', '我会继续向前，直到抵达属于自己的答案。', '新 狼与香辛料 的角色短句，适合放在回忆台词里。', '前进'),
('辉夜大小姐想让我告白～天才们的恋爱头脑战～ OVA', 'Fujiwara, Chika', '我会继续向前，直到抵达属于自己的答案。', '辉夜大小姐想让我告白～天才们的恋爱头脑战～ OVA 的角色短句，适合放在回忆台词里。', '前进'),
('辉夜大小姐想让我告白～天才们的恋爱头脑战～ OVA', 'Iino, Miko', '我会继续向前，直到抵达属于自己的答案。', '辉夜大小姐想让我告白～天才们的恋爱头脑战～ OVA 的角色短句，适合放在回忆台词里。', '前进'),
('辉夜大小姐想让我告白～天才们的恋爱头脑战～ OVA', 'Ishigami, Yuu', '我会继续向前，直到抵达属于自己的答案。', '辉夜大小姐想让我告白～天才们的恋爱头脑战～ OVA 的角色短句，适合放在回忆台词里。', '前进'),
('辉夜大小姐想让我告白～天才们的恋爱头脑战～', 'Fujiwara, Chika', '我会继续向前，直到抵达属于自己的答案。', '辉夜大小姐想让我告白～天才们的恋爱头脑战～ 的角色短句，适合放在回忆台词里。', '前进'),
('辉夜大小姐想让我告白～天才们的恋爱头脑战～', 'Ishigami, Yuu', '我会继续向前，直到抵达属于自己的答案。', '辉夜大小姐想让我告白～天才们的恋爱头脑战～ 的角色短句，适合放在回忆台词里。', '前进'),
('辉夜大小姐想让我告白～天才们的恋爱头脑战～', 'Shinomiya, Kaguya', '我会继续向前，直到抵达属于自己的答案。', '辉夜大小姐想让我告白～天才们的恋爱头脑战～ 的角色短句，适合放在回忆台词里。', '前进'),
('辉夜大小姐想让我告白？～天才们的恋爱头脑战～', 'Fujiwara, Chika', '我会继续向前，直到抵达属于自己的答案。', '辉夜大小姐想让我告白？～天才们的恋爱头脑战～ 的角色短句，适合放在回忆台词里。', '前进'),
('辉夜大小姐想让我告白？～天才们的恋爱头脑战～', 'Iino, Miko', '我会继续向前，直到抵达属于自己的答案。', '辉夜大小姐想让我告白？～天才们的恋爱头脑战～ 的角色短句，适合放在回忆台词里。', '前进'),
('辉夜大小姐想让我告白？～天才们的恋爱头脑战～', 'Ishigami, Yuu', '我会继续向前，直到抵达属于自己的答案。', '辉夜大小姐想让我告白？～天才们的恋爱头脑战～ 的角色短句，适合放在回忆台词里。', '前进'),
('辉夜大小姐想让我告白 -Ultra Romantic-', 'Fujiwara, Chika', '我会继续向前，直到抵达属于自己的答案。', '辉夜大小姐想让我告白 -Ultra Romantic- 的角色短句，适合放在回忆台词里。', '前进'),
('辉夜大小姐想让我告白 -Ultra Romantic-', 'Iino, Miko', '我会继续向前，直到抵达属于自己的答案。', '辉夜大小姐想让我告白 -Ultra Romantic- 的角色短句，适合放在回忆台词里。', '前进'),
('辉夜大小姐想让我告白 -Ultra Romantic-', 'Ishigami, Yuu', '我会继续向前，直到抵达属于自己的答案。', '辉夜大小姐想让我告白 -Ultra Romantic- 的角色短句，适合放在回忆台词里。', '前进'),
('辉夜大小姐想让我告白：初吻不会结束', 'Shinomiya, Kaguya', '我会继续向前，直到抵达属于自己的答案。', '辉夜大小姐想让我告白：初吻不会结束 的角色短句，适合放在回忆台词里。', '前进'),
('辉夜大小姐想让我告白：初吻不会结束', 'Shirogane, Miyuki', '我会继续向前，直到抵达属于自己的答案。', '辉夜大小姐想让我告白：初吻不会结束 的角色短句，适合放在回忆台词里。', '前进'),
('辉夜大小姐想让我告白 通往大人的阶梯', 'Shinomiya, Kaguya', '我会继续向前，直到抵达属于自己的答案。', '辉夜大小姐想让我告白 通往大人的阶梯 的角色短句，适合放在回忆台词里。', '前进'),
('辉夜大小姐想让我告白 通往大人的阶梯', 'Shirogane, Miyuki', '我会继续向前，直到抵达属于自己的答案。', '辉夜大小姐想让我告白 通往大人的阶梯 的角色短句，适合放在回忆台词里。', '前进'),
('BanG Dream! It''s MyGO!!!!!', 'Chihaya, Anon', '我会继续向前，直到抵达属于自己的答案。', 'BanG Dream! It''s MyGO!!!!! 的角色短句，适合放在回忆台词里。', '前进'),
('BanG Dream! It''s MyGO!!!!!', 'Kaname, Raana', '我会继续向前，直到抵达属于自己的答案。', 'BanG Dream! It''s MyGO!!!!! 的角色短句，适合放在回忆台词里。', '前进'),
('BanG Dream! It''s MyGO!!!!!', 'Nagasaki, Soyo', '我会继续向前，直到抵达属于自己的答案。', 'BanG Dream! It''s MyGO!!!!! 的角色短句，适合放在回忆台词里。', '前进'),
('BanG Dream! Ave Mujica', 'Misumi, Uika', '我会继续向前，直到抵达属于自己的答案。', 'BanG Dream! Ave Mujica 的角色短句，适合放在回忆台词里。', '前进'),
('BanG Dream! Ave Mujica', 'Togawa, Sakiko', '我会继续向前，直到抵达属于自己的答案。', 'BanG Dream! Ave Mujica 的角色短句，适合放在回忆台词里。', '前进'),
('BanG Dream! Ave Mujica', 'Wakaba, Mutsumi', '我会继续向前，直到抵达属于自己的答案。', 'BanG Dream! Ave Mujica 的角色短句，适合放在回忆台词里。', '前进'),
('葬送的芙莉莲', 'Fern', '我会继续向前，直到抵达属于自己的答案。', '葬送的芙莉莲 的角色短句，适合放在回忆台词里。', '前进'),
('葬送的芙莉莲', 'Frieren', '我会继续向前，直到抵达属于自己的答案。', '葬送的芙莉莲 的角色短句，适合放在回忆台词里。', '前进'),
('葬送的芙莉莲', 'Stark', '我会继续向前，直到抵达属于自己的答案。', '葬送的芙莉莲 的角色短句，适合放在回忆台词里。', '前进'),
('葬送的芙莉莲 第二季', 'Fern', '我会继续向前，直到抵达属于自己的答案。', '葬送的芙莉莲 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('葬送的芙莉莲 第二季', 'Frieren', '我会继续向前，直到抵达属于自己的答案。', '葬送的芙莉莲 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('葬送的芙莉莲 第二季', 'Stark', '我会继续向前，直到抵达属于自己的答案。', '葬送的芙莉莲 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('古诺希亚', 'Setsu', '我会继续向前，直到抵达属于自己的答案。', '古诺希亚 的角色短句，适合放在回忆台词里。', '前进'),
('古诺希亚', 'Yuuri', '我会继续向前，直到抵达属于自己的答案。', '古诺希亚 的角色短句，适合放在回忆台词里。', '前进'),
('我独自升级', 'Sung, Jin-Woo', '我会继续向前，直到抵达属于自己的答案。', '我独自升级 的角色短句，适合放在回忆台词里。', '前进'),
('我独自升级 第二季', 'Sung, Jin-Woo', '我会继续向前，直到抵达属于自己的答案。', '我独自升级 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('超时空辉夜姬！', 'Kaguya', '我会继续向前，直到抵达属于自己的答案。', '超时空辉夜姬！ 的角色短句，适合放在回忆台词里。', '前进'),
('超时空辉夜姬！', 'Runami, Yachiyo', '我会继续向前，直到抵达属于自己的答案。', '超时空辉夜姬！ 的角色短句，适合放在回忆台词里。', '前进'),
('超时空辉夜姬！', 'Sakayori, Iroha', '我会继续向前，直到抵达属于自己的答案。', '超时空辉夜姬！ 的角色短句，适合放在回忆台词里。', '前进'),
('小林家的龙女仆剧场版 怕寂寞的龙', 'Kamui, Kanna', '我会继续向前，直到抵达属于自己的答案。', '小林家的龙女仆剧场版 怕寂寞的龙 的角色短句，适合放在回忆台词里。', '前进'),
('小林家的龙女仆剧场版 怕寂寞的龙', 'Kobayashi', '我会继续向前，直到抵达属于自己的答案。', '小林家的龙女仆剧场版 怕寂寞的龙 的角色短句，适合放在回忆台词里。', '前进'),
('小林家的龙女仆剧场版 怕寂寞的龙', 'Tooru', '我会继续向前，直到抵达属于自己的答案。', '小林家的龙女仆剧场版 怕寂寞的龙 的角色短句，适合放在回忆台词里。', '前进'),
('杖与剑的魔剑谭', 'Serfort, Elfaria Albis', '我会继续向前，直到抵达属于自己的答案。', '杖与剑的魔剑谭 的角色短句，适合放在回忆台词里。', '前进'),
('杖与剑的魔剑谭', 'Serfort, Will', '我会继续向前，直到抵达属于自己的答案。', '杖与剑的魔剑谭 的角色短句，适合放在回忆台词里。', '前进'),
('转生七王子的魔法全解', 'de Saloum, Lloyd', '我会继续向前，直到抵达属于自己的答案。', '转生七王子的魔法全解 的角色短句，适合放在回忆台词里。', '前进'),
('转生七王子的魔法全解', 'Grim', '我会继续向前，直到抵达属于自己的答案。', '转生七王子的魔法全解 的角色短句，适合放在回忆台词里。', '前进'),
('最强阴阳师的异世界转生记', 'Amyu', '我会继续向前，直到抵达属于自己的答案。', '最强阴阳师的异世界转生记 的角色短句，适合放在回忆台词里。', '前进'),
('最强阴阳师的异世界转生记', 'Lamprogue, Seika', '我会继续向前，直到抵达属于自己的答案。', '最强阴阳师的异世界转生记 的角色短句，适合放在回忆台词里。', '前进'),
('最强阴阳师的异世界转生记', 'Yifa', '我会继续向前，直到抵达属于自己的答案。', '最强阴阳师的异世界转生记 的角色短句，适合放在回忆台词里。', '前进'),
('转生七王子的魔法全解 第二季', 'de Saloum, Lloyd', '我会继续向前，直到抵达属于自己的答案。', '转生七王子的魔法全解 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('转生七王子的魔法全解 第二季', 'Grim', '我会继续向前，直到抵达属于自己的答案。', '转生七王子的魔法全解 第二季 的角色短句，适合放在回忆台词里。', '前进'),
('鬼灭之刃 游郭篇 特别编辑版', 'Agatsuma, Zenitsu', '我会继续向前，直到抵达属于自己的答案。', '鬼灭之刃 游郭篇 特别编辑版 的角色短句，适合放在回忆台词里。', '前进'),
('鬼灭之刃 游郭篇 特别编辑版', 'Hashibira, Inosuke', '我会继续向前，直到抵达属于自己的答案。', '鬼灭之刃 游郭篇 特别编辑版 的角色短句，适合放在回忆台词里。', '前进'),
('鬼灭之刃 游郭篇 特别编辑版', 'Kamado, Tanjirou', '我会继续向前，直到抵达属于自己的答案。', '鬼灭之刃 游郭篇 特别编辑版 的角色短句，适合放在回忆台词里。', '前进'),
('鬼灭之刃 游郭篇', 'Agatsuma, Zenitsu', '我会继续向前，直到抵达属于自己的答案。', '鬼灭之刃 游郭篇 的角色短句，适合放在回忆台词里。', '前进'),
('鬼灭之刃 游郭篇', 'Hashibira, Inosuke', '我会继续向前，直到抵达属于自己的答案。', '鬼灭之刃 游郭篇 的角色短句，适合放在回忆台词里。', '前进'),
('鬼灭之刃 游郭篇', 'Kamado, Tanjirou', '我会继续向前，直到抵达属于自己的答案。', '鬼灭之刃 游郭篇 的角色短句，适合放在回忆台词里。', '前进'),
('继母的拖油瓶是我的前女友', 'Irido, Yume', '我会继续向前，直到抵达属于自己的答案。', '继母的拖油瓶是我的前女友 的角色短句，适合放在回忆台词里。', '前进'),
('继母的拖油瓶是我的前女友', 'Irido, Mizuto', '我会继续向前，直到抵达属于自己的答案。', '继母的拖油瓶是我的前女友 的角色短句，适合放在回忆台词里。', '前进'),
('我家女友可不止可爱呢', 'Izumi, Yuuki', '我会继续向前，直到抵达属于自己的答案。', '我家女友可不止可爱呢 的角色短句，适合放在回忆台词里。', '前进'),
('我家女友可不止可爱呢', 'Shikimori, Miyako', '我会继续向前，直到抵达属于自己的答案。', '我家女友可不止可爱呢 的角色短句，适合放在回忆台词里。', '前进'),
('无职转生～到了异世界就拿出真本事～', 'Greyrat, Rudeus', '我会继续向前，直到抵达属于自己的答案。', '无职转生～到了异世界就拿出真本事～ 的角色短句，适合放在回忆台词里。', '前进'),
('无职转生～到了异世界就拿出真本事～', 'Greyrat, Eris Boreas', '我会继续向前，直到抵达属于自己的答案。', '无职转生～到了异世界就拿出真本事～ 的角色短句，适合放在回忆台词里。', '前进'),
('无职转生～到了异世界就拿出真本事～', 'Migurdia, Roxy', '我会继续向前，直到抵达属于自己的答案。', '无职转生～到了异世界就拿出真本事～ 的角色短句，适合放在回忆台词里。', '前进'),
('铃芽之旅', 'Iwato, Suzume', '我会继续向前，直到抵达属于自己的答案。', '铃芽之旅 的角色短句，适合放在回忆台词里。', '前进'),
('铃芽之旅', 'Munakata, Souta', '我会继续向前，直到抵达属于自己的答案。', '铃芽之旅 的角色短句，适合放在回忆台词里。', '前进'),
('通往夏天的隧道，离别的出口', 'Hanashiro, Anzu', '我会继续向前，直到抵达属于自己的答案。', '通往夏天的隧道，离别的出口 的角色短句，适合放在回忆台词里。', '前进'),
('通往夏天的隧道，离别的出口', 'Touno, Kaoru', '我会继续向前，直到抵达属于自己的答案。', '通往夏天的隧道，离别的出口 的角色短句，适合放在回忆台词里。', '前进');

INSERT INTO sekai_memory_book_quote
    (user_id, anime_id, character_name, content, feeling, tag)
SELECT @sekai_user_id, anime.id, seed.character_name, seed.content, seed.feeling, seed.tag
FROM seed_20260512_extra_screenshot_quotes seed
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
  );