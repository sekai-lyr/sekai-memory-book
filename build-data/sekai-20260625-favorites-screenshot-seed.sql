USE sekai_friend;
SET NAMES utf8mb4;

SET @sekai_user_id := (SELECT id FROM sekai_memory_book_user WHERE username = 'sekai' LIMIT 1);
SET @watched_on := '2026-06-25';
SET @batch_time := '2026-06-25 13:30:00';

CREATE TEMPORARY TABLE seed_20260625_favorites (
    sort_order INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    type VARCHAR(50),
    score DECIMAL(3,1),
    cover_url VARCHAR(1000),
    release_date DATE,
    total_episodes INT,
    tags VARCHAR(255),
    memory_text TEXT,
    character_name VARCHAR(100),
    character_image_url VARCHAR(1000),
    character_reason VARCHAR(255),
    quote_content VARCHAR(500),
    quote_feeling TEXT,
    quote_tag VARCHAR(50)
);

INSERT INTO seed_20260625_favorites
(sort_order, title, type, score, cover_url, release_date, total_episodes, tags, memory_text, character_name, character_image_url, character_reason, quote_content, quote_feeling, quote_tag)
VALUES
(10, '葬送的芙莉莲', '日本/奇幻/冒险/治愈', 10.0, 'https://cdn.myanimelist.net/images/anime/1015/138006l.jpg', '2023-09-29', 28, '系列:葬送的芙莉莲,奇幻,冒险,治愈', '截图补录：长寿精灵回看勇者旅途，把时间、遗憾和温柔放进同一个故事里。', '芙莉莲', 'https://cdn.myanimelist.net/images/characters/6/507759.jpg', '看似淡漠，却把每一次相遇都慢慢放进心里。', '我想更了解人类。', '时间很长，真正重要的相遇却很短。', '治愈'),
(11, '葬送的芙莉莲 第二季', '日本/奇幻/冒险/治愈', 10.0, 'https://cdn.myanimelist.net/images/anime/1015/138006l.jpg', '2026-01-16', 10, '系列:葬送的芙莉莲,奇幻,冒险,治愈', '截图补录：北方旅途继续，适合放在芙莉莲系列后面。', '菲伦', 'https://cdn.myanimelist.net/images/characters/7/507760.jpg', '沉稳又可靠，像把旅途重新拉回日常的人。', '旅途还会继续。', '温柔不是停下，而是继续同行。', '旅途'),
(20, '我独自升级', '韩国/热血/战斗/奇幻', 10.0, 'https://cdn.myanimelist.net/images/anime/1801/142390l.jpg', '2024-01-07', 12, '系列:我独自升级,热血,战斗,奇幻', '截图补录：从最低级猎人到不断突破极限，爽点集中。', '成振宇', 'https://cdn.myanimelist.net/images/characters/8/542581.jpg', '越被逼到绝境，越能向上升级。', '我会变得更强。', '升级感明确，适合年度战斗榜。', '热血'),
(21, '我独自升级 第二季', '韩国/热血/战斗/奇幻', 10.0, 'https://cdn.myanimelist.net/images/anime/1801/142390l.jpg', '2025-01-05', 13, '系列:我独自升级,热血,战斗,奇幻', '截图补录：暗影君主线进一步展开，和第一季连续摆放。', '车海印', 'https://cdn.myanimelist.net/images/characters/16/564101.jpg', '强大又敏锐，是战斗线里很亮眼的角色。', '别停在这里。', '第二季继续把成长曲线往上推。', '战斗'),
(30, '小林家的龙女仆', '日本/日常/搞笑/治愈', 10.0, 'https://cdn.myanimelist.net/images/anime/5/85434l.jpg', '2017-01-12', 13, '系列:小林家的龙女仆,日常,搞笑,治愈', '截图补录：龙与社畜的同居日常，轻松但很有人情味。', '托尔', 'https://cdn.myanimelist.net/images/characters/4/317457.jpg', '热烈直接，像把非日常撞进普通生活。', '我想待在你身边。', '日常的可爱来自互相接纳。', '日常'),
(31, '小林家的龙女仆S', '日本/日常/搞笑/治愈', 10.0, 'https://cdn.myanimelist.net/images/anime/1252/115539l.jpg', '2021-07-08', 12, '系列:小林家的龙女仆,日常,搞笑,治愈', '截图补录：延续小林家的温暖日常，系列放一起。', '康娜', 'https://cdn.myanimelist.net/images/characters/9/317458.jpg', '安静、软萌、偶尔放电，辨识度太高。', '才不要分开。', '越平凡的饭桌，越像家。', '治愈'),
(32, '小林家的龙女仆 剧场版 怕寂寞的龙', '日本/日常/搞笑/治愈', 10.0, 'https://cdn.myanimelist.net/images/anime/1252/115539l.jpg', '2025-06-27', 1, '系列:小林家的龙女仆,剧场版,治愈', '截图补录：剧场版条目，和小林家的龙女仆系列连续摆放。', '小林', 'https://cdn.myanimelist.net/images/characters/3/317456.jpg', '平凡但可靠，是这个家真正的重心。', '这里就是家。', '剧场版补全系列回忆。', '家'),
(40, '辉夜大小姐想让我告白～天才们的恋爱头脑战～', '日本/恋爱/搞笑/校园', 10.0, 'https://cdn.myanimelist.net/images/anime/1295/106551l.jpg', '2019-01-12', 12, '系列:辉夜大小姐,恋爱,搞笑,校园', '截图补录：恋爱头脑战第一季，系列入口。', '四宫辉夜', 'https://cdn.myanimelist.net/images/characters/6/364386.jpg', '骄傲又笨拙，恋爱喜剧核心。', '先告白的人就输了。', '高智商恋爱也会变成可爱笨蛋局。', '恋爱'),
(41, '辉夜大小姐想让我告白？第二季', '日本/恋爱/搞笑/校园', 10.0, 'https://cdn.myanimelist.net/images/anime/1764/106659l.jpg', '2020-04-11', 12, '系列:辉夜大小姐,恋爱,搞笑,校园', '截图补录：第二季，继续学生会恋爱攻防。', '白银御行', 'https://cdn.myanimelist.net/images/characters/13/364385.jpg', '努力型会长，越认真越好笑。', '我也不会认输。', '恋爱里认真过头就会变成喜剧。', '搞笑'),
(42, '辉夜大小姐想让我告白-超级浪漫- 第三季', '日本/恋爱/搞笑/校园', 10.0, 'https://cdn.myanimelist.net/images/anime/1160/122627l.jpg', '2022-04-09', 13, '系列:辉夜大小姐,恋爱,搞笑,校园', '截图补录：第三季，系列高潮。', '藤原千花', 'https://cdn.myanimelist.net/images/characters/2/364387.jpg', '不可预测的粉色混乱制造机。', '书记也要闪闪发光。', '快乐本身也是推动剧情的力量。', '名场面'),
(43, '辉夜大小姐想让我告白：初吻不会结束', '日本/恋爱/搞笑/校园', 10.0, 'https://cdn.myanimelist.net/images/anime/1670/130060l.jpg', '2022-12-17', 4, '系列:辉夜大小姐,剧场版,恋爱', '截图补录：初吻篇，承接第三季后续。', '伊井野弥子', 'https://cdn.myanimelist.net/images/characters/7/404567.jpg', '认真守序，但感情线越来越有趣。', '喜欢不是比赛。', '告白之后，关系才真正开始。', '恋爱'),
(50, '鸭乃桥论的禁忌推理', '日本/推理/悬疑', 10.0, 'https://cdn.myanimelist.net/images/anime/1487/138872l.jpg', '2023-10-02', 13, '系列:鸭乃桥论,推理,悬疑', '截图补录：侦探搭档推理番第一季。', '鸭乃桥论', 'https://cdn.myanimelist.net/images/characters/8/523648.jpg', '天才但危险，推理时的存在感很强。', '真相不会自己开口。', '适合放进推理分类和时间线。', '推理'),
(51, '鸭乃桥论的禁忌推理 第二季', '日本/推理/悬疑', 10.0, 'https://cdn.myanimelist.net/images/anime/1487/138872l.jpg', '2024-10-07', 13, '系列:鸭乃桥论,推理,悬疑', '截图补录：第二季，和第一季连续摆放。', '一色都都丸', 'https://cdn.myanimelist.net/images/characters/3/523650.jpg', '善良又行动派，是天才侦探的现实锚点。', '一起找出答案吧。', '搭档关系让推理更有温度。', '搭档'),
(60, '想要成为影之实力者！', '日本/奇幻/战斗/搞笑', 9.0, 'https://cdn.myanimelist.net/images/anime/1874/121869l.jpg', '2022-10-05', 20, '系列:影之实力者,奇幻,战斗,搞笑', '截图补录：中二与暗影组织的反差爽番。', '希德·卡盖诺', 'https://cdn.myanimelist.net/images/characters/13/487994.jpg', '把中二演成现实，反差感很强。', '吾乃暗影。', '认真装酷反而成了最大笑点。', '中二'),
(61, '想要成为影之实力者！ 第二季', '日本/奇幻/战斗/搞笑', 10.0, 'https://cdn.myanimelist.net/images/anime/1889/136917l.jpg', '2023-10-04', 12, '系列:影之实力者,奇幻,战斗,搞笑', '截图补录：第二季，延续暗影庭园线。', '阿尔法', 'https://cdn.myanimelist.net/images/characters/2/487996.jpg', '优雅强大，是暗影庭园的门面。', '为了暗影大人。', '团队越壮大，中二越像史诗。', '战斗'),
(70, 'Re：从零开始的异世界生活', '日本/异世界/奇幻/冒险', 10.0, 'https://cdn.myanimelist.net/images/anime/11/79410l.jpg', '2016-04-04', 25, '系列:Re:Zero,异世界,奇幻,冒险', '截图补录：死亡回归第一季，系列入口。', '菜月昴', 'https://cdn.myanimelist.net/images/characters/15/302617.jpg', '狼狈但不放弃，是故事最痛也最亮的地方。', '我一定会救你。', '反复失败后仍然前进，才是这部的核心。', '坚持'),
(71, 'Re：从零开始的异世界生活 第二季', '日本/异世界/奇幻/冒险', 10.0, 'https://cdn.myanimelist.net/images/anime/1324/108508l.jpg', '2020-07-08', 25, '系列:Re:Zero,异世界,奇幻,冒险', '截图补录：圣域篇，和第一季连续摆放。', '艾米莉娅', 'https://cdn.myanimelist.net/images/characters/10/268173.jpg', '温柔坚定，越到后面越能看见成长。', '谢谢你相信我。', '被信任的人，也会学会相信自己。', '成长'),
(72, 'Re：从零开始的异世界生活 第三季', '日本/异世界/奇幻/冒险', 10.0, 'https://cdn.myanimelist.net/images/anime/1444/138005l.jpg', '2024-10-02', 16, '系列:Re:Zero,异世界,奇幻,冒险', '截图补录：第三季，系列继续扩展。', '雷姆', 'https://cdn.myanimelist.net/images/characters/9/311327.jpg', '温柔与坚定都很有记忆点。', '你不是一个人。', '角色羁绊是这部最能留住人的部分。', '羁绊'),
(73, 'Re：从零开始的异世界生活 第四季', '日本/异世界/奇幻/冒险', 10.0, 'https://cdn.myanimelist.net/images/anime/1444/138005l.jpg', '2026-04-01', 11, '系列:Re:Zero,异世界,奇幻,冒险', '截图补录：第四季条目，按截图加入并放在系列里。', '贝阿朵莉丝', 'https://cdn.myanimelist.net/images/characters/9/311326.jpg', '嘴硬但很重感情，契约后的陪伴很重要。', '由我来陪你。', '系列越长，陪伴越珍贵。', '陪伴'),
(80, '我推的孩子', '日本/偶像/悬疑/恋爱', 10.0, 'https://cdn.myanimelist.net/images/anime/1812/134736l.jpg', '2023-04-12', 11, '系列:我推的孩子,偶像,悬疑', '截图补录：偶像业界与复仇线结合。', '星野爱', 'https://cdn.myanimelist.net/images/characters/11/507313.jpg', '舞台上的谎言与爱都太耀眼。', '谎言也是一种爱。', '偶像光芒背后是锋利的现实。', '偶像'),
(81, '我推的孩子 第二季', '日本/偶像/悬疑/恋爱', 10.0, 'https://cdn.myanimelist.net/images/anime/1006/143302l.jpg', '2024-07-03', 13, '系列:我推的孩子,偶像,悬疑', '截图补录：第二季，舞台剧篇与复仇线继续。', '星野阿库亚', 'https://cdn.myanimelist.net/images/characters/13/507314.jpg', '冷静又执着，复仇线推动者。', '我要找到真相。', '舞台越亮，阴影越深。', '悬疑'),
(82, '我推的孩子 第三季', '日本/偶像/悬疑/恋爱', 10.0, 'https://cdn.myanimelist.net/images/anime/1006/143302l.jpg', '2026-01-14', 11, '系列:我推的孩子,偶像,悬疑', '截图补录：第三季，按截图补入系列。', '星野露比', 'https://cdn.myanimelist.net/images/characters/9/507315.jpg', '明亮外表下也藏着执念和愿望。', '我也要站上舞台。', '愿望会让人发光，也会让人受伤。', '舞台'),
(90, '租借女友', '日本/恋爱/后宫/校园', 5.0, 'https://cdn.myanimelist.net/images/anime/1902/128382l.jpg', '2020-07-11', 12, '系列:租借女友,恋爱,校园', '截图补录：租借恋爱喜剧第一季。', '水原千鹤', 'https://cdn.myanimelist.net/images/characters/9/392975.jpg', '职业感和真实感之间的反差很强。', '我会认真完成工作。', '关系从谎言开始，也可能长出真心。', '恋爱'),
(91, '租借女友 第二季', '日本/恋爱/后宫/校园', 10.0, 'https://cdn.myanimelist.net/images/anime/1102/121536l.jpg', '2022-07-02', 12, '系列:租借女友,恋爱,校园', '截图补录：第二季，和第一季连续。', '七海麻美', 'https://cdn.myanimelist.net/images/characters/13/399502.jpg', '危险又有存在感，推动关系变化。', '你真的懂喜欢吗？', '不稳定的人际关系最容易制造戏剧。', '关系'),
(92, '租借女友 第三季', '日本/恋爱/后宫/校园', 10.0, 'https://cdn.myanimelist.net/images/anime/1908/135431l.jpg', '2023-07-08', 12, '系列:租借女友,恋爱,校园', '截图补录：第三季，电影制作线。', '更科瑠夏', 'https://cdn.myanimelist.net/images/characters/5/399503.jpg', '直球又热烈，是恋爱线的加速器。', '我不会轻易放弃。', '直球有时候比绕弯更动人。', '恋爱'),
(93, '租借女友 第四季', '日本/恋爱/后宫/校园', 10.0, 'https://cdn.myanimelist.net/images/anime/1908/135431l.jpg', '2025-07-05', 12, '系列:租借女友,恋爱,校园', '截图补录：第四季，按截图加入。', '樱泽墨', 'https://cdn.myanimelist.net/images/characters/5/399504.jpg', '害羞但努力，是温柔支线。', '我想再勇敢一点。', '慢热角色也有自己的闪光。', '成长'),
(94, '租借女友 第五季', '日本/恋爱/后宫/校园', 5.5, 'https://cdn.myanimelist.net/images/anime/1908/135431l.jpg', '2026-07-01', 12, '系列:租借女友,恋爱,校园', '截图补录：第五季，按截图预留到系列。', '八重森弥妮', 'https://cdn.myanimelist.net/images/characters/9/497912.jpg', '活泼会助攻，让关系推进更直接。', '恋爱需要行动力。', '系列长线适合年度报告统计。', '恋爱'),
(100, '欢迎来到实力至上主义教室', '日本/校园/后宫/智斗', 10.0, 'https://cdn.myanimelist.net/images/anime/5/86830l.jpg', '2017-07-12', 12, '系列:实力至上主义教室,校园,智斗', '截图补录：第一季，智斗校园入口。', '绫小路清隆', 'https://cdn.myanimelist.net/images/characters/8/325873.jpg', '低调却危险，智斗核心。', '能赢就够了。', '平静表面下是完整算计。', '智斗'),
(101, '欢迎来到实力至上主义教室 第二季', '日本/校园/后宫/智斗', 10.0, 'https://cdn.myanimelist.net/images/anime/1240/122493l.jpg', '2022-07-04', 13, '系列:实力至上主义教室,校园,智斗', '截图补录：第二季，和第一季连续。', '堀北铃音', 'https://cdn.myanimelist.net/images/characters/11/325874.jpg', '从孤高到逐渐成长，变化明显。', '我会证明自己。', '成长也是一种胜利。', '校园'),
(102, '欢迎来到实力至上主义教室 第三季', '日本/校园/后宫/智斗', 10.0, 'https://cdn.myanimelist.net/images/anime/1332/139318l.jpg', '2024-01-03', 13, '系列:实力至上主义教室,校园,智斗', '截图补录：第三季，持续补完系列。', '轻井泽惠', 'https://cdn.myanimelist.net/images/characters/14/325875.jpg', '外柔内韧，角色层次很强。', '我会自己站起来。', '被保护之外，也可以变强。', '成长'),
(103, '欢迎来到实力至上主义教室 第四季', '日本/校园/后宫/智斗', 10.0, 'https://cdn.myanimelist.net/images/anime/1332/139318l.jpg', '2026-04-08', 16, '系列:实力至上主义教室,校园,智斗', '截图补录：第四季，按截图加入系列。', '坂柳有栖', 'https://cdn.myanimelist.net/images/characters/10/362732.jpg', '聪明、优雅且压迫感很足。', '胜负很快就会明白。', '高手之间的试探最有味道。', '智斗'),
(110, '咒术回战', '日本/热血/战斗/奇幻', 10.0, 'https://cdn.myanimelist.net/images/anime/1171/109222l.jpg', '2020-10-03', 24, '系列:咒术回战,热血,战斗', '截图补录：咒术系列第一季。', '虎杖悠仁', 'https://cdn.myanimelist.net/images/characters/11/427601.jpg', '热血、善良，也承担着宿傩的危险。', '我想让人正确地死去。', '热血外壳下有清晰的死亡命题。', '热血'),
(111, '咒术回战 0', '日本/热血/战斗/奇幻', 10.0, 'https://cdn.myanimelist.net/images/anime/1121/119044l.jpg', '2021-12-24', 1, '系列:咒术回战,剧场版,战斗', '截图补录：前传剧场版，放入咒术系列。', '乙骨忧太', 'https://cdn.myanimelist.net/images/characters/8/455379.jpg', '温柔但强大，前传核心。', '这是纯爱。', '一句话把战斗和情感都定住了。', '名场面'),
(112, '咒术回战 第二季', '日本/热血/战斗/奇幻', 10.0, 'https://cdn.myanimelist.net/images/anime/1792/138022l.jpg', '2023-07-06', 23, '系列:咒术回战,热血,战斗', '截图补录：怀玉玉折与涩谷事变。', '五条悟', 'https://cdn.myanimelist.net/images/characters/15/422168.jpg', '最强的轻佻感和孤独感都很有记忆点。', '天上天下，唯我独尊。', '强大的人也会被时代推着走。', '战斗'),
(113, '咒术回战 第三季', '日本/热血/战斗/奇幻', 10.0, 'https://cdn.myanimelist.net/images/anime/1792/138022l.jpg', '2026-01-08', 12, '系列:咒术回战,热血,战斗', '截图补录：第三季，按截图补入系列。', '伏黑惠', 'https://cdn.myanimelist.net/images/characters/13/422170.jpg', '冷静又有潜力，术式很有辨识度。', '我会选择救人。', '战斗番里选择比力量更难。', '选择'),
(120, '夜樱家的大作战', '日本/搞笑/恋爱/战斗', 10.0, 'https://cdn.myanimelist.net/images/anime/1714/140700l.jpg', '2024-04-07', 27, '系列:夜樱家的大作战,搞笑,战斗', '截图补录：家族、间谍和恋爱混合。', '朝野太阳', 'https://cdn.myanimelist.net/images/characters/4/526625.jpg', '被卷入夜樱家后不断成长。', '我会保护家人。', '家族番的热闹和战斗并存。', '家族'),
(121, '夜樱家的大作战 第二季', '日本/搞笑/恋爱/战斗', 10.0, 'https://cdn.myanimelist.net/images/anime/1714/140700l.jpg', '2026-04-05', 11, '系列:夜樱家的大作战,搞笑,战斗', '截图补录：第二季，和第一季连续。', '夜樱六美', 'https://cdn.myanimelist.net/images/characters/13/526626.jpg', '温柔但背负家族秘密。', '我们是一家人。', '继续扩展家族关系线。', '家族'),
(130, '魔法少女与恶曾是敌人', '日本/奇幻/恋爱/搞笑', 10.0, 'https://cdn.myanimelist.net/images/anime/1793/141229l.jpg', '2024-07-09', 12, '奇幻,恋爱,搞笑', '截图补录：魔法少女和恶之参谋的反差恋爱。', '白夜', 'https://cdn.myanimelist.net/images/characters/11/544369.jpg', '温柔纯净，和恶阵营形成可爱反差。', '敌人也会心动。', '短篇恋爱感很干净。', '恋爱'),
(140, '想吃掉我的非人少女', '日本/奇幻/百合/治愈', 10.0, 'https://cdn.myanimelist.net/images/anime/1768/93291l.jpg', '2025-10-02', 13, '奇幻,百合,治愈', '截图补录：按截图加入非人少女条目。', '八百岁比名子', 'https://cdn.myanimelist.net/images/characters/16/115711.jpg', '孤独感与被需要的关系很抓人。', '我会陪着你。', '带一点危险感的治愈关系。', '治愈'),
(150, '更衣人偶坠入爱河', '日本/恋爱/校园/日常', 10.0, 'https://cdn.myanimelist.net/images/anime/1179/119897l.jpg', '2022-01-09', 12, '系列:更衣人偶坠入爱河,恋爱,校园', '截图补录：cos 与纯爱结合，第一季。', '喜多川海梦', 'https://cdn.myanimelist.net/images/characters/3/514695.jpg', '直率、闪亮，也尊重别人的热爱。', '喜欢就要说出来。', '热爱会把人照亮。', '热爱'),
(151, '更衣人偶坠入爱河 第二季', '日本/恋爱/校园/日常', 10.0, 'https://cdn.myanimelist.net/images/anime/1024/150787l.jpg', '2025-07-06', 12, '系列:更衣人偶坠入爱河,恋爱,校园', '截图补录：第二季，和第一季连续。', '五条新菜', 'https://cdn.myanimelist.net/images/characters/5/472608.jpg', '认真打磨技艺，也认真面对关系。', '我想做得更好。', '手艺和喜欢都需要慢慢练习。', '成长'),
(160, '我们仍未知道那天所看见的花的名字', '日本/青春/治愈/催泪', 10.0, 'https://cdn.myanimelist.net/images/anime/5/79697l.jpg', '2011-04-15', 11, '青春,治愈,催泪', '截图补录：未闻花名，夏天、朋友和遗憾。', '本间芽衣子', 'https://cdn.myanimelist.net/images/characters/16/115711.jpg', '天真温柔，是所有人放不下的夏天。', '找到我了。', '回忆里最痛的地方往往也最温柔。', '催泪'),
(170, '亲爱的弗兰克斯', '日本/科幻/机战/恋爱', 10.0, 'https://cdn.myanimelist.net/images/anime/1614/90408l.jpg', '2018-01-13', 24, '科幻,机战,恋爱', '截图补录：机战外壳下的青春与爱。', '02', 'https://cdn.myanimelist.net/images/characters/8/345194.jpg', '危险、孤独，又强烈渴望被爱。', 'Darling。', '一句称呼就是整个故事的情绪。', '恋爱'),
(180, '可塑性记忆', '日本/科幻/恋爱/催泪', 10.0, 'https://cdn.myanimelist.net/images/anime/4/72750l.jpg', '2015-04-05', 13, '科幻,恋爱,催泪', '截图补录：有限时间里的陪伴。', '艾拉', 'https://cdn.myanimelist.net/images/characters/11/284838.jpg', '安静笨拙，却让离别更有重量。', '愿你有美好的回忆。', '时间有限，所以回忆更珍贵。', '催泪'),
(190, '夏洛特 Charlotte', '日本/校园/超能力/青春', 10.0, 'https://cdn.myanimelist.net/images/anime/12/74683l.jpg', '2015-07-05', 13, '校园,超能力,青春', '截图补录：超能力青春故事。', '乙坂有宇', 'https://cdn.myanimelist.net/images/characters/8/294999.jpg', '从任性到承担，成长跨度很大。', '我会全部夺走。', '能力越强，代价越沉。', '成长'),
(200, '刀剑神域 第一季', '日本/战斗/奇幻/冒险', 10.0, 'https://cdn.myanimelist.net/images/anime/11/39717l.jpg', '2012-07-08', 25, '系列:刀剑神域,战斗,冒险', '截图补录：SAO 第一季，系列入口。', '桐人', 'https://cdn.myanimelist.net/images/characters/7/204821.jpg', '黑衣剑士，早期网游番代表角色。', '我不会让你死。', '游戏世界里的生存感很强。', '战斗'),
(201, '刀剑神域 第二季', '日本/战斗/奇幻/冒险', 10.0, 'https://cdn.myanimelist.net/images/anime/1223/121999l.jpg', '2014-07-05', 24, '系列:刀剑神域,战斗,冒险', '截图补录：GGO 与圣剑篇等，和第一季连续。', '亚丝娜', 'https://cdn.myanimelist.net/images/characters/15/262053.jpg', '温柔但战斗力很强，是系列核心。', '我也要和你并肩。', '并肩作战比单人英雄更有回忆感。', '羁绊'),
(202, '刀剑神域：序列之争 剧场版', '日本/战斗/奇幻/剧场版', 10.0, 'https://cdn.myanimelist.net/images/anime/4/83811l.jpg', '2017-02-18', 1, '系列:刀剑神域,剧场版,战斗', '截图补录：序列之争剧场版。', '结衣', 'https://cdn.myanimelist.net/images/characters/6/175813.jpg', '像家人一样连接着大家。', '大家要在一起。', '剧场版补上现实与虚拟的连接。', '剧场版'),
(210, '黑子的篮球', '日本/运动/热血/竞技', 10.0, 'https://cdn.myanimelist.net/images/anime/11/50453l.jpg', '2012-04-08', 25, '系列:黑子的篮球,运动,热血', '截图补录：篮球热血第一季。', '黑子哲也', 'https://cdn.myanimelist.net/images/characters/5/170061.jpg', '存在感薄弱却是队伍的传球核心。', '我是影子。', '影子也能让队友发光。', '运动'),
(211, '黑子的篮球 第二季', '日本/运动/热血/竞技', 10.0, 'https://cdn.myanimelist.net/images/anime/9/56155l.jpg', '2013-10-06', 25, '系列:黑子的篮球,运动,热血', '截图补录：第二季，继续奇迹世代对决。', '火神大我', 'https://cdn.myanimelist.net/images/characters/9/170063.jpg', '爆发力十足，和黑子的组合很燃。', '我要赢。', '搭档互补是运动番最爽的部分。', '热血'),
(212, '黑子的篮球 第三季', '日本/运动/热血/竞技', 10.0, 'https://cdn.myanimelist.net/images/anime/4/68299l.jpg', '2015-01-11', 25, '系列:黑子的篮球,运动,热血', '截图补录：第三季，系列决战。', '黄濑凉太', 'https://cdn.myanimelist.net/images/characters/10/170065.jpg', '天赋型选手，复制能力名场面很多。', '还没结束。', '最后一球之前都不能认输。', '竞技'),
(213, '黑子的篮球剧场版：LAST GAME', '日本/运动/热血/剧场版', 10.0, 'https://cdn.myanimelist.net/images/anime/3/86033l.jpg', '2017-03-18', 1, '系列:黑子的篮球,剧场版,运动', '截图补录：LAST GAME 剧场版。', '赤司征十郎', 'https://cdn.myanimelist.net/images/characters/11/170067.jpg', '压迫感强，奇迹世代代表人物。', '胜利就是一切。', '剧场版适合补完系列收束。', '剧场版');

INSERT INTO sekai_memory_book_anime
    (user_id, title, type, status, score, cover_url, watch_date, release_date, total_episodes, current_episode, last_watch_date, memory_text, tags, create_time, update_time)
SELECT @sekai_user_id,
       seed.title,
       seed.type,
       '看完',
       seed.score,
       seed.cover_url,
       @watched_on,
       seed.release_date,
       seed.total_episodes,
       seed.total_episodes,
       @watched_on,
       seed.memory_text,
       seed.tags,
       DATE_SUB(@batch_time, INTERVAL seed.sort_order MINUTE),
       DATE_SUB(@batch_time, INTERVAL seed.sort_order MINUTE)
FROM seed_20260625_favorites seed
WHERE @sekai_user_id IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM sekai_memory_book_anime existing
      WHERE existing.user_id = @sekai_user_id
        AND existing.title = seed.title
  );

UPDATE sekai_memory_book_anime anime
JOIN seed_20260625_favorites seed
  ON seed.title = anime.title
SET anime.type = seed.type,
    anime.status = '看完',
    anime.score = seed.score,
    anime.cover_url = CASE
        WHEN anime.cover_url IS NULL OR anime.cover_url = '' THEN seed.cover_url
        ELSE anime.cover_url
    END,
    anime.watch_date = COALESCE(anime.watch_date, @watched_on),
    anime.release_date = COALESCE(anime.release_date, seed.release_date),
    anime.total_episodes = COALESCE(anime.total_episodes, seed.total_episodes),
    anime.current_episode = COALESCE(anime.current_episode, seed.total_episodes),
    anime.last_watch_date = COALESCE(anime.last_watch_date, @watched_on),
    anime.memory_text = CASE
        WHEN anime.memory_text IS NULL OR anime.memory_text = '' THEN seed.memory_text
        ELSE anime.memory_text
    END,
    anime.tags = CASE
        WHEN anime.tags IS NULL OR anime.tags = '' THEN seed.tags
        ELSE anime.tags
    END
WHERE anime.user_id = @sekai_user_id;

INSERT INTO sekai_memory_book_character_favorite
    (user_id, anime_id, character_name, image_url, reason, favorite_level, create_time)
SELECT @sekai_user_id,
       anime.id,
       seed.character_name,
       seed.character_image_url,
       seed.character_reason,
       5,
       DATE_SUB(@batch_time, INTERVAL seed.sort_order MINUTE)
FROM seed_20260625_favorites seed
JOIN sekai_memory_book_anime anime
  ON anime.user_id = @sekai_user_id
 AND anime.title = seed.title
WHERE @sekai_user_id IS NOT NULL
  AND seed.character_name IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM sekai_memory_book_character_favorite existing
      WHERE existing.user_id = @sekai_user_id
        AND existing.anime_id = anime.id
        AND existing.character_name = seed.character_name
  );

INSERT INTO sekai_memory_book_quote
    (user_id, anime_id, character_name, content, feeling, tag, create_time)
SELECT @sekai_user_id,
       anime.id,
       seed.character_name,
       seed.quote_content,
       seed.quote_feeling,
       seed.quote_tag,
       DATE_SUB(@batch_time, INTERVAL seed.sort_order MINUTE)
FROM seed_20260625_favorites seed
JOIN sekai_memory_book_anime anime
  ON anime.user_id = @sekai_user_id
 AND anime.title = seed.title
WHERE @sekai_user_id IS NOT NULL
  AND seed.quote_content IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM sekai_memory_book_quote existing
      WHERE existing.user_id = @sekai_user_id
        AND existing.anime_id = anime.id
        AND existing.content = seed.quote_content
  );

DROP TEMPORARY TABLE IF EXISTS seed_20260625_favorites;
