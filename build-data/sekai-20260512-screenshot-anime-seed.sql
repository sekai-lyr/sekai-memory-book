USE sekai_friend;
SET NAMES utf8mb4;

SET @sekai_user_id := (SELECT id FROM sekai_memory_book_user WHERE username = 'sekai' LIMIT 1);
SET @watched_on := '2026-05-12';

CREATE TEMPORARY TABLE seed_20260512_anime (
    title VARCHAR(100) NOT NULL,
    type VARCHAR(50),
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

INSERT INTO seed_20260512_anime
(title, type, status, score, cover_url, watch_date, release_date, total_episodes, current_episode, last_watch_date, tags)
VALUES
('政宗君的复仇', '日本/搞笑/恋爱/青春/校园/励志/美少女', '看完', 10.0, 'https://myanimelist.net/images/anime/12/83709l.jpg', @watched_on, '2017-01-05', 12, 12, @watched_on, '搞笑,恋爱,青春,校园,励志,美少女'),
('政宗君的复仇第二季', '日本/恋爱/校园/搞笑', '看完', 9.0, 'https://myanimelist.net/images/anime/1667/135587l.jpg', @watched_on, '2023-07-03', 12, 12, @watched_on, '恋爱,校园,搞笑'),
('堀与宫村', '日本/搞笑/恋爱/校园', '看完', 10.0, 'https://myanimelist.net/images/anime/1695/111486l.jpg', @watched_on, '2021-01-10', 13, 13, @watched_on, '搞笑,恋爱,校园'),
('堀与宫村 piece', '日本/恋爱/日常/搞笑', '看完', 10.0, 'https://myanimelist.net/images/anime/1007/136277l.jpg', @watched_on, '2023-07-01', 13, 13, @watched_on, '恋爱,日常,搞笑'),
('败犬女主太多了！', '日本/恋爱/校园/搞笑/青春', '看完', 10.0, 'https://myanimelist.net/images/anime/1332/143513l.jpg', @watched_on, '2024-07-14', 12, 12, @watched_on, '恋爱,校园,搞笑,青春'),
('剧场总集篇 孤独摇滚', '日本/日常/百合/搞笑/青春/治愈/校园/音乐/漫画改', '看完', 10.0, 'https://myanimelist.net/images/anime/1256/142261l.jpg', @watched_on, '2024-06-07', 2, 2, @watched_on, '日常,百合,搞笑,青春,治愈,校园,音乐,漫画改'),
('碧蓝之海', '日本/搞笑/青春/校园/运动', '看完', 10.0, 'https://myanimelist.net/images/anime/1302/94882l.jpg', @watched_on, '2018-07-14', 12, 12, @watched_on, '搞笑,青春,校园,运动'),
('碧蓝之海 第二季', '日本/搞笑/校园/运动/恋爱/青春/漫画改', '看完', 10.0, 'https://myanimelist.net/images/anime/1108/150583l.jpg', @watched_on, '2025-07-08', 12, 12, @watched_on, '搞笑,校园,运动,恋爱,青春,漫画改'),
('天气之子', '日本/热血/战斗/科幻/奇幻/冒险', '看完', 10.0, 'https://myanimelist.net/images/anime/1880/101146l.jpg', @watched_on, '2019-07-19', 1, 1, @watched_on, '热血,战斗,科幻,奇幻,冒险'),
('你的名字', '日本/爱情/动画/剧情', '看完', 10.0, 'https://myanimelist.net/images/anime/5/87048l.jpg', @watched_on, '2016-08-26', 1, 1, @watched_on, '爱情,动画,剧情'),
('言叶之庭', '日本/爱情/动画', '看完', 10.0, 'https://myanimelist.net/images/anime/1591/144565l.jpg', @watched_on, '2013-05-31', 1, 1, @watched_on, '爱情,动画'),
('秒速五厘米', '日本/爱情/动画/剧情', '看完', 10.0, 'https://myanimelist.net/images/anime/1410/112994l.jpg', @watched_on, '2007-03-03', 1, 1, @watched_on, '爱情,动画,剧情'),
('全职法师第一季', '大陆/热血/战斗/奇幻/魔法', '看完', 8.0, 'https://myanimelist.net/images/anime/1248/153777l.jpg', @watched_on, '2016-09-02', 12, 12, @watched_on, '热血,战斗,奇幻,魔法'),
('全职法师第二季', '大陆/热血/战斗/奇幻/魔法', '看完', 10.0, 'https://myanimelist.net/images/anime/4/87726l.jpg', @watched_on, '2017-09-15', 12, 12, @watched_on, '热血,战斗,奇幻,魔法'),
('全职法师第三季', '大陆/热血/战斗/奇幻/魔法', '看完', 10.0, 'https://myanimelist.net/images/anime/1398/95679l.jpg', @watched_on, '2018-10-13', 12, 12, @watched_on, '热血,战斗,奇幻,魔法'),
('全职法师第四季', '大陆/热血/战斗/奇幻/校园/魔法/竞技', '看完', 10.0, 'https://myanimelist.net/images/anime/1925/105375l.jpg', @watched_on, '2020-05-27', 12, 12, @watched_on, '热血,战斗,奇幻,校园,魔法,竞技'),
('全职法师第五季', '大陆/热血/战斗/奇幻/校园/魔法/竞技', '看完', 10.0, 'https://myanimelist.net/images/anime/1974/114887l.jpg', @watched_on, '2021-07-28', 12, 12, @watched_on, '热血,战斗,奇幻,校园,魔法,竞技'),
('全职法师 第六季', '大陆/奇幻/战斗/校园', '看完', 10.0, 'https://myanimelist.net/images/anime/1695/155861l.jpg', @watched_on, '2023-06-02', 12, 12, @watched_on, '奇幻,战斗,校园'),
('全职法师 特别篇 神秘委托', '大陆/奇幻/都市/冒险', '看完', 10.0, 'https://myanimelist.net/images/anime/1695/155861l.jpg', @watched_on, '2024-08-16', 6, 6, @watched_on, '奇幻,都市,冒险'),
('凹凸世界第一季', '大陆/搞笑/热血/战斗/科幻/冒险/励志/机战/竞技', '看完', 10.0, 'https://myanimelist.net/images/anime/5/81494l.jpg', @watched_on, '2015-11-13', 32, 32, @watched_on, '搞笑,热血,战斗,科幻,冒险,励志,机战,竞技'),
('凹凸世界第二季', '大陆/搞笑/热血/战斗/科幻/冒险/励志/机战/竞技', '看完', 10.0, 'https://myanimelist.net/images/anime/7/87766l.jpg', @watched_on, '2017-10-08', 20, 20, @watched_on, '搞笑,热血,战斗,科幻,冒险,励志,机战,竞技'),
('凹凸世界第三季', '大陆/搞笑/热血/战斗/科幻/冒险/励志/机战/竞技', '看完', 10.0, 'https://myanimelist.net/images/anime/1306/102590l.jpg', @watched_on, '2019-01-25', 38, 38, @watched_on, '搞笑,热血,战斗,科幻,冒险,励志,机战,竞技'),
('凹凸世界第四季', '大陆/搞笑/战斗/热血', '看完', 10.0, 'https://myanimelist.net/images/anime/1569/125291l.jpg', @watched_on, '2022-04-29', 20, 20, @watched_on, '搞笑,战斗,热血'),
('凹凸世界·新生', '大陆/热血', '看完', 10.0, 'https://myanimelist.net/images/anime/1919/148484l.jpg', @watched_on, '2025-04-25', 4, 4, @watched_on, '热血'),
('男女之间的友情存在吗？（不，不存在!!）', '日本/日常/校园/恋爱/青春/轻小说改', '看完', 10.0, 'https://myanimelist.net/images/anime/1429/150067l.jpg', @watched_on, '2025-04-04', 12, 12, @watched_on, '日常,校园,恋爱,青春,轻小说改'),
('我的青春恋爱物语果然有问题 第一季', '日本/搞笑/恋爱/青春/校园/美少女', '看完', 10.0, 'https://myanimelist.net/images/anime/1786/120117l.jpg', @watched_on, '2013-04-05', 13, 13, @watched_on, '搞笑,恋爱,青春,校园,美少女'),
('我的青春恋爱物语果然有问题 第二季', '日本/搞笑/恋爱/青春/校园/美少女', '看完', 10.0, 'https://myanimelist.net/images/anime/11/75376l.jpg', @watched_on, '2015-04-03', 13, 13, @watched_on, '搞笑,恋爱,青春,校园,美少女'),
('我的青春恋爱物语果然有问题 第三季', '日本/搞笑/恋爱/青春/校园/美少女', '看完', 10.0, 'https://myanimelist.net/images/anime/1958/107912l.jpg', @watched_on, '2020-07-10', 12, 12, @watched_on, '搞笑,恋爱,青春,校园,美少女'),
('更衣人偶坠入爱河', '日本/搞笑/恋爱', '看完', 10.0, 'https://myanimelist.net/images/anime/1179/119897l.jpg', @watched_on, '2022-01-09', 12, 12, @watched_on, '搞笑,恋爱'),
('更衣人偶坠入爱河 第二季', '日本/搞笑/恋爱/校园/日常/青春/漫画改', '看完', 10.0, 'https://myanimelist.net/images/anime/1024/150787l.jpg', @watched_on, '2025-07-06', 12, 12, @watched_on, '搞笑,恋爱,校园,日常,青春,漫画改'),
('可塑性记忆', '日本/搞笑/科幻/恋爱/催泪', '看完', 10.0, 'https://myanimelist.net/images/anime/4/72750l.jpg', @watched_on, '2015-04-05', 13, 13, @watched_on, '搞笑,科幻,恋爱,催泪'),
('未闻花名', '日本/恋爱/青春', '看完', 10.0, 'https://myanimelist.net/images/anime/5/79697l.jpg', @watched_on, '2011-04-15', 11, 11, @watched_on, '恋爱,青春'),
('我想要吃掉你的胰脏', '日本/爱情/动画/青春/剧情', '看完', 10.0, 'https://myanimelist.net/images/anime/1768/93291l.jpg', @watched_on, '2018-09-01', 1, 1, @watched_on, '爱情,动画,青春,剧情'),
('亲爱的弗兰克斯', '日本/热血/战斗/科幻/机战/美少女', '看完', 10.0, 'https://myanimelist.net/images/anime/1614/90408l.jpg', @watched_on, '2018-01-13', 24, 24, @watched_on, '热血,战斗,科幻,机战,美少女'),
('破灭之国', '日本/战斗/奇幻/魔法', '看完', 1.0, 'https://myanimelist.net/images/anime/1610/138189l.jpg', @watched_on, '2023-10-07', 12, 12, @watched_on, '战斗,奇幻,魔法'),
('寄宿学校的朱丽叶', '日本/恋爱/青春/校园/魔法', '看完', 10.0, 'https://myanimelist.net/images/anime/1089/93456l.jpg', @watched_on, '2018-10-06', 12, 12, @watched_on, '恋爱,青春,校园,魔法'),
('亚托莉 -我挚爱的时光', '日本/科幻/恋爱', '看完', 10.0, 'https://myanimelist.net/images/anime/1693/144909l.jpg', @watched_on, '2024-07-14', 13, 13, @watched_on, '科幻,恋爱'),
('夏日口袋', '日本/日常/恋爱/催泪/游戏改', '看完', 10.0, 'https://myanimelist.net/images/anime/1691/148602l.jpg', @watched_on, '2025-04-07', 26, 26, @watched_on, '日常,恋爱,催泪,游戏改'),
('今天开始做明星', '大陆/伪娘', '看完', 10.0, 'https://myanimelist.net/images/anime/1623/105487l.jpg', @watched_on, '2019-12-27', 13, 13, @watched_on, '伪娘'),
('今天开始做明星之天使情歌', '大陆/动画', '看完', 10.0, 'https://myanimelist.net/images/anime/1158/141557l.jpg', @watched_on, '2021-08-13', 1, 1, @watched_on, '动画'),
('今天开始闪耀登场', '大陆/青春/都市/励志', '看完', 10.0, 'https://myanimelist.net/images/anime/1189/155921l.jpg', @watched_on, '2023-04-20', 15, 15, @watched_on, '青春,都市,励志');

INSERT INTO sekai_memory_book_anime
    (user_id, title, type, status, score, cover_url, watch_date, release_date, total_episodes, current_episode, last_watch_date, tags)
SELECT @sekai_user_id, title, type, status, score, cover_url, watch_date, release_date, total_episodes, current_episode, last_watch_date, tags
FROM seed_20260512_anime seed
WHERE @sekai_user_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM sekai_memory_book_anime existing
      WHERE existing.user_id = @sekai_user_id
        AND existing.title = seed.title
  );

UPDATE sekai_memory_book_anime anime
JOIN seed_20260512_anime seed ON seed.title = anime.title
SET anime.type = seed.type,
    anime.status = seed.status,
    anime.score = seed.score,
    anime.cover_url = seed.cover_url,
    anime.watch_date = seed.watch_date,
    anime.release_date = seed.release_date,
    anime.total_episodes = seed.total_episodes,
    anime.current_episode = seed.current_episode,
    anime.last_watch_date = seed.last_watch_date,
    anime.tags = seed.tags
WHERE anime.user_id = @sekai_user_id;

CREATE TEMPORARY TABLE seed_20260512_characters (
    anime_title VARCHAR(100),
    character_name VARCHAR(100),
    image_url VARCHAR(1000),
    reason VARCHAR(255),
    favorite_level TINYINT
);

INSERT INTO seed_20260512_characters
(anime_title, character_name, image_url, reason, favorite_level)
VALUES
('碧蓝之海', '北原伊织', 'https://cdn.myanimelist.net/images/characters/8/316802.jpg', '被损友和潜水社拉进热闹青春的男主。', 5),
('碧蓝之海', '今村耕平', 'https://cdn.myanimelist.net/images/characters/6/387496.jpg', '御宅气质和荒唐喜剧感都很鲜明。', 4),
('碧蓝之海', '古手川千纱', 'https://cdn.myanimelist.net/images/characters/13/322725.jpg', '认真又冷静，是潜水主题里最稳的存在。', 5),
('碧蓝之海', '吉原爱菜', 'https://cdn.myanimelist.net/images/characters/10/387487.jpg', '从胆怯到融入社团的变化很可爱。', 4),
('败犬女主太多了！', '温水和彦', 'https://cdn.myanimelist.net/images/characters/9/542556.jpg', '吐槽视角很舒服，把败犬们的青春串起来。', 5),
('败犬女主太多了！', '八奈见杏菜', 'https://cdn.myanimelist.net/images/characters/16/542560.jpg', '明明失恋却依旧活力十足。', 5),
('败犬女主太多了！', '烧盐柠檬', 'https://cdn.myanimelist.net/images/characters/11/542562.jpg', '运动系青梅的爽朗和遗憾都很动人。', 4),
('败犬女主太多了！', '小鞠知花', 'https://cdn.myanimelist.net/images/characters/15/542561.jpg', '内向但认真，文学少女的可爱很细腻。', 4),
('剧场总集篇 孤独摇滚', '后藤一里', 'https://cdn.myanimelist.net/images/characters/4/509913.jpg', '社恐却用吉他努力发光。', 5),
('剧场总集篇 孤独摇滚', '伊地知虹夏', 'https://cdn.myanimelist.net/images/characters/16/491305.jpg', '像乐队的太阳一样照顾大家。', 5),
('剧场总集篇 孤独摇滚', '山田凉', 'https://cdn.myanimelist.net/images/characters/16/491303.jpg', '自由又缺钱，冷面笑点很强。', 4),
('剧场总集篇 孤独摇滚', '喜多郁代', 'https://cdn.myanimelist.net/images/characters/10/509914.jpg', '闪亮外向，也在努力追上大家。', 5),
('全职法师第一季', '莫凡', 'https://cdn.myanimelist.net/images/characters/13/457538.jpg', '双系魔法和不服输的热血都很爽。', 5),
('全职法师第一季', '穆宁雪', 'https://cdn.myanimelist.net/images/characters/9/457427.jpg', '冷艳强大，是前期最有辨识度的角色之一。', 5),
('全职法师第一季', '叶心夏', 'https://cdn.myanimelist.net/images/characters/5/457536.jpg', '温柔治愈，支撑莫凡继续前进。', 4),
('全职法师第一季', '张小侯', 'https://cdn.myanimelist.net/images/characters/4/457540.jpg', '可靠兄弟感很足。', 4),
('凹凸世界第一季', '金', 'https://cdn.myanimelist.net/images/characters/8/617801.jpg', '热血开朗，永远向前冲。', 5),
('凹凸世界第二季', '安迷修', 'https://cdn.myanimelist.net/images/characters/5/528332.jpg', '骑士感和责任感都很突出。', 5),
('凹凸世界第三季', '黑洞', 'https://cdn.myanimelist.net/images/characters/6/504055.jpg', '神秘感很强，压迫力也足。', 4),
('男女之间的友情存在吗？（不，不存在!!）', '夏目悠', 'https://cdn.myanimelist.net/images/characters/13/588920.jpg', '把友情和恋爱边界搅得很青春。', 4),
('男女之间的友情存在吗？（不，不存在!!）', '犬塚日葵', 'https://cdn.myanimelist.net/images/characters/8/588919.jpg', '直率又耀眼，是故事的心动核心。', 5),
('男女之间的友情存在吗？（不，不存在!!）', '榎本凛音', 'https://cdn.myanimelist.net/images/characters/5/588921.jpg', '恋爱喜剧里的关系推进担当。', 4),
('更衣人偶坠入爱河', '五条新菜', 'https://cdn.myanimelist.net/images/characters/5/472608.jpg', '认真对待手艺，也认真对待海梦。', 5),
('更衣人偶坠入爱河', '喜多川海梦', 'https://cdn.myanimelist.net/images/characters/3/514695.jpg', '闪闪发光的热爱本身。', 5),
('更衣人偶坠入爱河', '乾纱寿叶', 'https://cdn.myanimelist.net/images/characters/6/459774.jpg', '傲娇又认真，cos 的执念很可爱。', 4),
('更衣人偶坠入爱河', '乾心寿', 'https://cdn.myanimelist.net/images/characters/12/458726.jpg', '温柔害羞，和姐姐形成很好的反差。', 4),
('未闻花名', '本间芽衣子', 'https://cdn.myanimelist.net/images/characters/16/115711.jpg', '天真温柔，是大家心里没愈合的夏天。', 5),
('未闻花名', '宿海仁太', 'https://cdn.myanimelist.net/images/characters/10/116629.jpg', '从逃避里重新面对朋友和过去。', 5),
('未闻花名', '安城鸣子', 'https://cdn.myanimelist.net/images/characters/10/121622.jpg', '表面活泼，心里一直放不下。', 4),
('亲爱的弗兰克斯', '广', 'https://cdn.myanimelist.net/images/characters/8/558884.jpg', '和 02 一起寻找活着的意义。', 5),
('亲爱的弗兰克斯', '02', 'https://cdn.myanimelist.net/images/characters/8/345194.jpg', '美丽危险，又极度渴望被爱。', 5),
('亲爱的弗兰克斯', '莓', 'https://cdn.myanimelist.net/images/characters/5/473102.jpg', '队长的责任感和暗恋都很真实。', 4),
('今天开始做明星', '秦雅', 'https://cdn.myanimelist.net/images/characters/15/595143.jpg', '舞台上的耀眼和生活里的反差很有趣。', 5),
('今天开始做明星', '秦泽', 'https://cdn.myanimelist.net/images/characters/9/595142.jpg', '被卷入偶像生活后的成长很欢乐。', 5),
('今天开始闪耀登场', '露露薇亚', 'https://cdn.myanimelist.net/images/characters/14/595936.jpg', '新篇章里舞台感很强的角色。', 4);

INSERT INTO sekai_memory_book_character_favorite
    (user_id, anime_id, character_name, image_url, reason, favorite_level)
SELECT @sekai_user_id,
       anime.id,
       seed.character_name,
       seed.image_url,
       seed.reason,
       seed.favorite_level
FROM seed_20260512_characters seed
JOIN sekai_memory_book_anime anime
  ON anime.user_id = @sekai_user_id
 AND anime.title = seed.anime_title
WHERE @sekai_user_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM sekai_memory_book_character_favorite existing
      WHERE existing.user_id = @sekai_user_id
        AND existing.character_name = seed.character_name
  );

CREATE TEMPORARY TABLE seed_20260512_quotes (
    anime_title VARCHAR(100),
    character_name VARCHAR(100),
    content VARCHAR(500),
    feeling TEXT,
    tag VARCHAR(50)
);

INSERT INTO seed_20260512_quotes
(anime_title, character_name, content, feeling, tag)
VALUES
('碧蓝之海', '北原伊织', '大学生活，应该不只是喝到天亮吧。', '荒唐青春里的清醒吐槽。', '青春'),
('碧蓝之海', '古手川千纱', '既然下海，就认真看着眼前的世界。', '潜水主题的认真感。', '热爱'),
('败犬女主太多了！', '八奈见杏菜', '就算输了，也要吃饱再哭。', '败犬女主的明亮生命力。', '失恋'),
('败犬女主太多了！', '温水和彦', '旁观别人的恋爱，也会被卷进青春里。', '男主的吐槽视角。', '青春'),
('剧场总集篇 孤独摇滚', '后藤一里', '我想变得能和大家一起站上舞台。', '社恐努力向前的心愿。', '音乐'),
('剧场总集篇 孤独摇滚', '喜多郁代', '闪闪发光之前，也要先认真练习。', '外向角色背后的努力。', '努力'),
('全职法师第一季', '莫凡', '别人说不可能，我就更想试试看。', '热血升级流的爽点。', '热血'),
('全职法师第一季', '穆宁雪', '强大不是退路，是必须走下去的理由。', '冷静强者的信念感。', '魔法'),
('凹凸世界第一季', '金', '只要还有希望，就继续往前跑。', '热血主角的行动力。', '希望'),
('凹凸世界第二季', '安迷修', '骑士的剑，要指向该守护的人。', '骑士精神的帅气表达。', '守护'),
('男女之间的友情存在吗？（不，不存在!!）', '犬塚日葵', '说是朋友的时候，心跳已经不听话了。', '友情与恋爱的边界感。', '心动'),
('男女之间的友情存在吗？（不，不存在!!）', '夏目悠', '有些关系，越想证明越容易露馅。', '恋爱喜剧的微妙感。', '恋爱'),
('更衣人偶坠入爱河', '喜多川海梦', '喜欢的东西，就要大声说喜欢。', '海梦最打动人的直率。', '热爱'),
('更衣人偶坠入爱河', '五条新菜', '认真做出来的衣服，会替心意说话。', '手艺和恋爱的连接。', '认真'),
('未闻花名', '本间芽衣子', '找到我了。', '最直接也最催泪的重逢感。', '催泪'),
('未闻花名', '宿海仁太', '我们一直被那个夏天留在原地。', '面对过去的痛感。', '青春'),
('亲爱的弗兰克斯', '02', '找到你了，我的 Darling。', '02 的命运感和依恋。', '命运'),
('亲爱的弗兰克斯', '广', '和你一起飞，才像是真正活着。', '少年与少女彼此拯救。', '羁绊'),
('今天开始做明星', '秦雅', '站上舞台，就要把光唱给所有人听。', '偶像题材的舞台感。', '舞台'),
('今天开始做明星', '秦泽', '换一种身份，也要守住真正的自己。', '身份错位里的成长。', '成长');

INSERT INTO sekai_memory_book_quote
    (user_id, anime_id, character_name, content, feeling, tag)
SELECT @sekai_user_id,
       anime.id,
       seed.character_name,
       seed.content,
       seed.feeling,
       seed.tag
FROM seed_20260512_quotes seed
JOIN sekai_memory_book_anime anime
  ON anime.user_id = @sekai_user_id
 AND anime.title = seed.anime_title
WHERE @sekai_user_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM sekai_memory_book_quote existing
      WHERE existing.user_id = @sekai_user_id
        AND existing.content = seed.content
  );
