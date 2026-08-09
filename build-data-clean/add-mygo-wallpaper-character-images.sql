USE sekai_friend;

UPDATE sekai_memory_book_character_favorite
SET image_url = 'https://images2.alphacoders.com/134/1346348.png'
WHERE user_id = 3 AND character_name IN ('高松灯', '千早爱音', '要乐奈', '长崎爽世', '椎名立希');
