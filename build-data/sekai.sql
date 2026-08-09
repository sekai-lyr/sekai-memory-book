CREATE DATABASE IF NOT EXISTS sekai_friend
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE sekai_friend;

CREATE TABLE IF NOT EXISTS sekai_memory_book_user (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '鐢ㄦ埛ID',
    username VARCHAR(50) NOT NULL UNIQUE COMMENT '鐢ㄦ埛鍚嶏紝鐢ㄤ簬鐧诲綍',
    password VARCHAR(100) NOT NULL COMMENT '瀵嗙爜',
    nickname VARCHAR(50) DEFAULT NULL COMMENT '鏄电О',
    phone_number VARCHAR(20) DEFAULT NULL UNIQUE COMMENT '手机号',

    membership_plan VARCHAR(20) NOT NULL DEFAULT 'FREE' COMMENT 'membership plan',
    pro_expire_time DATETIME DEFAULT NULL COMMENT 'Pro expiration time',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '鍒涘缓鏃堕棿'
) COMMENT='鐢ㄦ埛琛?;

CREATE TABLE IF NOT EXISTS sekai_memory_book_anime (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '鐣墽ID',
    user_id BIGINT NOT NULL COMMENT '鐢ㄦ埛ID',
    title VARCHAR(100) NOT NULL COMMENT '鐣墽鍚嶇О',
    type VARCHAR(50) DEFAULT NULL COMMENT '鐣墽绫诲瀷',
    status VARCHAR(20) DEFAULT NULL COMMENT '瑙傜湅鐘舵€?,
    score DECIMAL(3,1) DEFAULT NULL COMMENT '璇勫垎',
    cover_url VARCHAR(1000) DEFAULT NULL COMMENT '鐣墽灏侀潰鍥剧墖鍦板潃',
    watch_date DATE DEFAULT NULL COMMENT '瑙傜湅鏃ユ湡',
    memory_text TEXT DEFAULT NULL COMMENT '涓汉鍥炲繂銆佽鍚庢劅',
    tags VARCHAR(255) DEFAULT NULL COMMENT '鏍囩锛岀敤閫楀彿鍒嗛殧',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '鍒涘缓鏃堕棿',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '淇敼鏃堕棿',
    INDEX idx_anime_user_id (user_id)
) COMMENT='鐣墽鍥炲繂琛?;

CREATE TABLE IF NOT EXISTS sekai_memory_book_character_favorite (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '瑙掕壊鏀惰棌ID',
    user_id BIGINT NOT NULL COMMENT '鐢ㄦ埛ID',
    anime_id BIGINT DEFAULT NULL COMMENT '鐣墽ID',
    character_name VARCHAR(100) NOT NULL COMMENT '瑙掕壊鍚嶇О',
    image_url VARCHAR(1000) DEFAULT NULL COMMENT '瑙掕壊鍥剧墖鍦板潃',
    reason VARCHAR(255) DEFAULT NULL COMMENT '鍠滄鍘熷洜',
    favorite_level TINYINT DEFAULT 5 COMMENT '鍠滅埍绋嬪害锛? 鍒?5',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '鍒涘缓鏃堕棿',
    INDEX idx_character_user_id (user_id)
) COMMENT='瑙掕壊鏀惰棌琛?;

CREATE TABLE IF NOT EXISTS sekai_memory_book_quote (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '鍙拌瘝ID',
    user_id BIGINT NOT NULL COMMENT '鐢ㄦ埛ID',
    anime_id BIGINT DEFAULT NULL COMMENT '鐣墽ID',
    character_name VARCHAR(100) DEFAULT NULL COMMENT '璇村嚭鍙拌瘝鐨勮鑹插悕',
    content VARCHAR(500) NOT NULL COMMENT '鍙拌瘝鍐呭',
    feeling TEXT DEFAULT NULL COMMENT '杩欏彞鍙拌瘝甯︽潵鐨勬劅鍙?,
    tag VARCHAR(50) DEFAULT NULL COMMENT '鏍囩',
    video_url VARCHAR(1000) DEFAULT NULL COMMENT 'quote video url',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '鍒涘缓鏃堕棿',
    INDEX idx_quote_user_id (user_id)
) COMMENT='鍙拌瘝鏀惰棌琛?;

CREATE TABLE IF NOT EXISTS sekai_memory_book_order (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'order id',
    order_no VARCHAR(64) NOT NULL UNIQUE COMMENT 'order number',
    user_id BIGINT NOT NULL COMMENT 'user id',
    plan_code VARCHAR(50) NOT NULL COMMENT 'plan code',
    amount DECIMAL(10,2) NOT NULL COMMENT 'amount',
    pay_channel VARCHAR(30) NOT NULL DEFAULT 'DEMO' COMMENT 'pay channel',
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING' COMMENT 'order status',
    paid_time DATETIME DEFAULT NULL COMMENT 'paid time',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'created time',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'updated time',
    INDEX idx_order_user_id (user_id),
    INDEX idx_order_status (status)
) COMMENT='membership order table';

