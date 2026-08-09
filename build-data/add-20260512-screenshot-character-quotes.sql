USE sekai_friend;

SET NAMES utf8mb4;
SET @sekai_user_id := (SELECT id FROM sekai_memory_book_user WHERE username = 'sekai' LIMIT 1);

UPDATE sekai_memory_book_anime
SET status = '看完',
    current_episode = total_episodes,
    last_watch_date = COALESCE(last_watch_date, '2026-05-12'),
    watch_date = COALESCE(watch_date, '2026-05-12')
WHERE user_id = @sekai_user_id
  AND title IN (
      '最近的侦探真没用',
      '9-nine- 支配者的王冠',
      '选择项目',
      '莉可丽丝',
      '莉可丽丝 Friends are thieves of time.',
      '想要成为影之实力者！',
      '想要成为影之实力者！ 第二季',
      '薰香花朵凛然绽放',
      '瑠璃的宝石',
      '时光流逝，饭菜依旧美味',
      '剧场版世界计划 破碎的世界与无法歌唱的初音未来',
      '鸭乃桥论的禁忌推理',
      '鸭乃桥论的禁忌推理 第二季',
      '新 狼与香辛料',
      '吹响！上低音号剧场版合集',
      '金牌得主',
      '金牌得主 第二季',
      '想吃掉我的非人少女',
      '关于我在无意间被隔壁的天使变成废柴这件事',
      '关于我在无意间被隔壁的天使变成废柴这件事 第二季',
      '欢迎来到实力至上主义教室第四季',
      '咒术回战 第三季',
      '杖与剑的魔剑谭 第二季',
      '夜樱家的大作战 第二季',
      '魔法少女与恶曾是敌人',
      'Love Live!',
      'Love Live!第二季',
      'Love Live! 虹咲学园校园偶像同好会',
      'Love Live! 虹咲学园校园偶像同好会 第二季',
      'Love Live! Superstar!!',
      'Love Live! Superstar!!第二季',
      '租借女友',
      '租借女友 第二季',
      '租借女友 第三季',
      '租借女友 第四季',
      '租借女友 第五季',
      'Re：从零开始的异世界生活',
      'Re：从零开始的异世界生活 Memory Snow',
      'Re：从零开始的异世界生活 冰结之绊',
      'Re：从零开始的异世界生活 新编集版',
      'Re：从零开始的异世界生活第二季',
      'Re：从零开始的异世界生活第三季',
      'Re：从零开始的异世界生活第三季 反击篇',
      'Re：从零开始的异世界生活第四季',
      '黑色四叶草',
      '我推的孩子',
      '我推的孩子 第二季',
      '我推的孩子 第三季'
  );

INSERT INTO sekai_memory_book_character_favorite (user_id, anime_id, character_name, image_url, reason, favorite_level, create_time)
SELECT @sekai_user_id, a.id, v.character_name, v.image_url, v.reason, 5, NOW()
FROM (
    SELECT 'Love Live!' title, 'Kousaka, Honoka' character_name, 'https://cdn.myanimelist.net/images/characters/2/245793.jpg?s=eae270251d57256171786e3e369bb6f3' image_url, '总能把大家带向舞台中央。' reason
    UNION ALL SELECT 'Love Live!', 'Minami, Kotori', 'https://cdn.myanimelist.net/images/characters/3/201135.jpg?s=9adb41a829e15f4194e0291c7e98d332', '温柔细腻，是团队里让人安心的存在。'
    UNION ALL SELECT 'Love Live!', 'Sonoda, Umi', 'https://cdn.myanimelist.net/images/characters/5/196143.jpg?s=54be8eca49bead2073ef6273bbf89a87', '认真可靠，用严格守住大家的梦想。'
    UNION ALL SELECT 'Love Live!', 'Ayase, Eri', 'https://cdn.myanimelist.net/images/characters/10/200925.jpg?s=4b2b9c2abc4852fe94b56a09ca8226b9', '优雅又强大，加入后让组合更完整。'
    UNION ALL SELECT 'Love Live!', 'Hoshizora, Rin', 'https://cdn.myanimelist.net/images/characters/14/196147.jpg?s=8b62adb654b06a5f942726500237de4c', '活力满满，把快乐传给所有人。'
    UNION ALL SELECT 'Love Live!', 'Koizumi, Hanayo', 'https://cdn.myanimelist.net/images/characters/4/201133.jpg?s=6226ba7d50cc403c442cb6fdd5b8319a', '怯生生却真心热爱偶像。'
    UNION ALL SELECT 'Love Live! Superstar!!第二季', 'Arashi, Chisato', 'https://cdn.myanimelist.net/images/characters/11/458092.jpg?s=24106ebd0c5f5539ce624c6f05a471d3', '开朗稳重，像圆一样把大家连起来。'
    UNION ALL SELECT 'Love Live! Superstar!!第二季', 'Hazuki, Ren', 'https://cdn.myanimelist.net/images/characters/12/458093.jpg?s=2e09053e369cf5d6fd9708f7f5eeb83c', '端庄认真，也在舞台上找回热情。'
    UNION ALL SELECT 'Love Live! Superstar!!第二季', 'Sakurakouji, Kinako', 'https://cdn.myanimelist.net/images/characters/3/492873.jpg?s=89f4017d125af73a2f4220ee526c581f', '新成员的笨拙努力很可爱。'
    UNION ALL SELECT 'Love Live! Superstar!!第二季', 'Yoneme, Mei', 'https://cdn.myanimelist.net/images/characters/5/492874.jpg?s=62bebcc810afc4029e9c7edfadd3fdde', '嘴硬但真心喜欢偶像。'
    UNION ALL SELECT 'Love Live! Superstar!!第二季', 'Wakana, Shiki', 'https://cdn.myanimelist.net/images/characters/9/574176.jpg?s=5af895b229118cef35ac6e185d940e2b', '冷静独特，用自己的方式守护朋友。'
    UNION ALL SELECT 'Love Live! Superstar!!第二季', 'Onitsuka, Natsumi', 'https://cdn.myanimelist.net/images/characters/2/492875.jpg?s=91959893573bc9cc3f7110ce2105fed6', '精明外表下也有想发光的心。'
    UNION ALL SELECT 'Love Live! 虹咲学园校园偶像同好会 第二季', 'Uehara, Ayumu', 'https://cdn.myanimelist.net/images/characters/6/396294.jpg?s=77ea0a5e098eb7bf465cb1413f14d6a3', '一步一步走向自己的舞台。'
    UNION ALL SELECT 'Love Live! 虹咲学园校园偶像同好会 第二季', 'Takasaki, Yuu', 'https://cdn.myanimelist.net/images/characters/2/421049.jpg?s=02e4f0ad6db780090bf8367ecc255544', '用喜欢支撑每一个人的梦想。'
    UNION ALL SELECT 'Love Live! 虹咲学园校园偶像同好会 第二季', 'Nakasu, Kasumi', 'https://cdn.myanimelist.net/images/characters/8/488261.jpg?s=eb0ebc6e3dacf1157f4b1d8b2d0417fc', '可爱又不服输，舞台表现力很亮。'
    UNION ALL SELECT 'Love Live! 虹咲学园校园偶像同好会 第二季', 'Ousaka, Shizuku', 'https://cdn.myanimelist.net/images/characters/7/421048.jpg?s=9f3e56507b5575dc467b1c2280950c6b', '把戏剧感和偶像感融合得很漂亮。'
    UNION ALL SELECT 'Love Live! 虹咲学园校园偶像同好会 第二季', 'Miyashita, Ai', 'https://cdn.myanimelist.net/images/characters/3/488246.jpg?s=3fe6b798463ba417c4e63e3f36a46db0', '热情亲切，能瞬间点亮气氛。'
    UNION ALL SELECT 'Love Live! 虹咲学园校园偶像同好会 第二季', 'Asaka, Karin', 'https://cdn.myanimelist.net/images/characters/16/396297.jpg?s=7aef525285b16f1c7480683e82a60574', '成熟帅气，舞台风格很鲜明。'
    UNION ALL SELECT 'Love Live! 虹咲学园校园偶像同好会 第二季', 'Mifune, Shioriko', 'https://cdn.myanimelist.net/images/characters/12/440981.jpg?s=369037a900b308e8ede39b0d9b365d76', '严谨中藏着对舞台的热爱。'
    UNION ALL SELECT 'Love Live! 虹咲学园校园偶像同好会 第二季', 'Taylor, Mia', 'https://cdn.myanimelist.net/images/characters/8/472442.jpg?s=2fc66ad78bf9aa600b6e548bff2f2bd0', '天才气质和孤独感都很抓人。'
    UNION ALL SELECT 'Love Live! 虹咲学园校园偶像同好会 第二季', 'Verde, Emma', 'https://cdn.myanimelist.net/images/characters/7/396301.jpg?s=7a74a6fbc7813e16afef2ce433b1bca4', '温暖包容，像阳光一样稳定。'
    UNION ALL SELECT 'Re：从零开始的异世界生活', 'Ram', 'https://cdn.myanimelist.net/images/characters/15/306390.jpg?s=c627953e35df76da593d931548b7e646', '毒舌冷静，却很可靠。'
    UNION ALL SELECT 'Re：从零开始的异世界生活', 'Beatrice', 'https://cdn.myanimelist.net/images/characters/2/591066.jpg?s=c8b21170c013b5b286d0ee1345052236', '傲娇外壳下藏着漫长孤独。'
    UNION ALL SELECT 'Re：从零开始的异世界生活', 'Mathers, Roswaal L.', 'https://cdn.myanimelist.net/images/characters/12/628361.jpg?s=bc6d172058377b00d5d9bbfca9b099d9', '谜团感很强的重要角色。'
    UNION ALL SELECT 'Re：从零开始的异世界生活第二季', 'Otto Suwen', 'https://myanimelist.net/images/characters/3/438832.jpg', '关键时刻愿意站出来的朋友。'
    UNION ALL SELECT 'Re：从零开始的异世界生活第二季', 'Garfiel Tinsel', 'https://myanimelist.net/images/characters/2/563872.jpg', '野性强悍，也有柔软的一面。'
    UNION ALL SELECT 'Re：从零开始的异世界生活第三季', 'Meili Portroute', 'https://myanimelist.net/images/characters/4/628320.jpg', '危险又狡黠的存在感很强。'
    UNION ALL SELECT '租借女友', 'Nanami, Mami', 'https://cdn.myanimelist.net/images/characters/4/491833.jpg?s=32595e11e24cefba286df05f0e54859f', '甜美外表下有复杂心思。'
    UNION ALL SELECT '租借女友', 'Sarashina, Ruka', 'https://cdn.myanimelist.net/images/characters/11/409385.jpg?s=2063a5bb2d4e9f9f468702cf8a648f7b', '直率热烈，行动力很强。'
    UNION ALL SELECT '金牌得主', 'Akeuraji, Tsukasa', 'https://cdn.myanimelist.net/images/characters/8/517162.jpg?s=47dfe271283d84f167ca1a06c4fc1358', '用耐心和经验托住选手的梦想。'
    UNION ALL SELECT '金牌得主', 'Yuitsuka, Inori', 'https://cdn.myanimelist.net/images/characters/7/579734.jpg?s=dfa422860c5ef8de5125ef23c450a518', '笨拙但执着地追逐冰上的光。'
) v
JOIN sekai_memory_book_anime a ON a.user_id = @sekai_user_id AND a.title = v.title
WHERE @sekai_user_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM sekai_memory_book_character_favorite c
      WHERE c.user_id = @sekai_user_id
        AND c.character_name = v.character_name
  );

INSERT INTO sekai_memory_book_quote (user_id, anime_id, character_name, content, feeling, tag, create_time)
SELECT @sekai_user_id, a.id, v.character_name, v.content, v.feeling, v.tag, NOW()
FROM (
    SELECT 'Love Live!' title, 'Kousaka, Honoka' character_name, '只要大家一起努力，梦想就一定会实现。' content, 'μ''s 的初心，适合放在回忆里的第一句。' feeling, '梦想' tag
    UNION ALL SELECT 'Love Live!', 'Sonoda, Umi', '即使害怕，也要向舞台迈出一步。', '认真派的勇气感。', '勇气'
    UNION ALL SELECT 'Love Live!', 'Minami, Kotori', '最重要的是大家在一起的心情。', '温柔地把团队系在一起。', '羁绊'
    UNION ALL SELECT 'Love Live! 虹咲学园校园偶像同好会 第二季', 'Yuuki, Setsuna', '喜欢就是最强的力量。', '很适合虹咲每个人各自发光的主题。', '热爱'
    UNION ALL SELECT 'Love Live! 虹咲学园校园偶像同好会 第二季', 'Takasaki, Yuu', '我想支持每个人的梦想。', '不是站在舞台上，也能成为光。', '支持'
    UNION ALL SELECT 'Love Live! 虹咲学园校园偶像同好会 第二季', 'Uehara, Ayumu', '我想把喜欢的心情唱出来。', '把小小的喜欢变成舞台。', '青春'
    UNION ALL SELECT '关于我在无意间被隔壁的天使变成废柴这件事 第二季', 'Shiina, Mahiru', '不用勉强，慢慢来就好。', '温柔日常里最治愈的那种陪伴。', '治愈'
    UNION ALL SELECT '关于我在无意间被隔壁的天使变成废柴这件事 第二季', 'Fujimiya, Amane', '我想成为能站在你身边的人。', '恋爱番里最踏实的承诺感。', '恋爱'
    UNION ALL SELECT '关于我在无意间被隔壁的天使变成废柴这件事 第二季', 'Shiina, Mahiru', '能被你珍惜，我很开心。', '把甜度和安心感都留下来。', '温柔'
    UNION ALL SELECT '金牌得主', 'Yuitsuka, Inori', '我想成为世界第一。', '小小选手最直球的梦想宣言。', '梦想'
    UNION ALL SELECT '金牌得主', 'Akeuraji, Tsukasa', '输了也没关系，重要的是继续滑下去。', '竞技番里很有力量的陪伴。', '励志'
    UNION ALL SELECT '金牌得主', 'Kamisaki, Hikaru', '我会在冰上证明自己。', '天才选手的锋芒和自尊。', '竞技'
) v
JOIN sekai_memory_book_anime a ON a.user_id = @sekai_user_id AND a.title = v.title
WHERE @sekai_user_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM sekai_memory_book_quote q
      WHERE q.user_id = @sekai_user_id
        AND q.anime_id = a.id
        AND q.content = v.content
  );
