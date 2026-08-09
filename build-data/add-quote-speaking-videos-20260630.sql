SET NAMES utf8mb4;

-- 给已有台词补“角色说话视频”。这些链接优先选择语音集、台词合集、角色自我介绍、
-- 角色 cut 或名场面切片，避免把明显带长片尾引导的杂谈视频写入台词。
-- 仅填充 video_url 为空的记录，方便人工替换成更精确的片段。

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1YA411X7MP/'
WHERE user_id = 3
  AND character_name IN ('Kousaka, Honoka', 'Sonoda, Umi', 'Minami, Kotori')
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1HR4y1z7Dy/'
WHERE user_id = 3
  AND character_name = '砂狼白子'
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1s24y1q7zP/'
WHERE user_id = 3
  AND character_name = '小鸟游星野'
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1fY411i7Jy/'
WHERE user_id = 3
  AND character_name = '黑见芹香'
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1EV411U7Lk/'
WHERE user_id = 3
  AND character_name = '亚托莉'
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1Q4421D7Qh/'
WHERE user_id = 3
  AND character_name = '斑鸠夏生'
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1aPNgeUEwY/'
WHERE user_id = 3
  AND character_name = '高松灯'
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1vu411876c/'
WHERE user_id = 3
  AND character_name = '千早爱音'
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1T1421D7HW/'
WHERE user_id = 3
  AND character_name = '要乐奈'
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1s1421D7vb/'
WHERE user_id = 3
  AND character_name IN ('长崎爽世', '长崎素世')
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1dh4y1u7m2/'
WHERE user_id = 3
  AND character_name = '椎名立希'
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV11G4y1B74n/'
WHERE user_id = 3
  AND character_name = '锦木千束'
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1wt4y1j72U/'
WHERE user_id = 3
  AND character_name = '井之上泷奈'
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1mp4y1n7oq/'
WHERE user_id = 3
  AND character_name = '天野阳菜'
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1gX4y1t7oK/'
WHERE user_id = 3
  AND character_name = '森岛帆高'
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1t5411V7QN/'
WHERE user_id = 3
  AND character_name IN ('立花泷', '宫水三叶', '名取早耶香')
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1UK411V71Q/'
WHERE user_id = 3
  AND character_name IN ('秋月孝雄', '雪野百香里')
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1Dt411o7uu/'
WHERE user_id = 3
  AND character_name IN ('远野贵树', '篠原明里')
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1FK411W7AJ/'
WHERE user_id = 3
  AND character_name = '艾拉'
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1wA411376Z/'
WHERE user_id = 3
  AND character_name = '水柿司'
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV15A411s72P/'
WHERE user_id = 3
  AND character_name IN ('山内樱良', '志贺春树', '恭子')
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV11F411k7ER/'
WHERE user_id = 3
  AND character_name = '初音未来'
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1j24y1B73L/'
WHERE user_id = 3
  AND character_name = '星乃一歌'
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1j24y1q7mQ/'
WHERE user_id = 3
  AND character_name = '宵崎奏'
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1Jv411s72h/'
WHERE user_id = 3
  AND character_name = '比企谷八幡'
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1Wp4y1y7Y6/'
WHERE user_id = 3
  AND character_name = '雪之下雪乃'
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1554y117Dm/'
WHERE user_id = 3
  AND character_name = '由比滨结衣'
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1mV411v7dH/'
WHERE user_id = 3
  AND character_name IN ('堀京子', '宫村伊澄')
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1ks4y1J7gR/'
WHERE user_id = 3
  AND character_name = '岩户铃芽'
  AND (video_url IS NULL OR video_url = '');

UPDATE sekai_memory_book_quote
SET video_url = 'https://www.bilibili.com/video/BV1M54y1h7qm/'
WHERE user_id = 3
  AND character_name = '西宫硝子'
  AND (video_url IS NULL OR video_url = '');
