CREATE DATABASE IF NOT EXISTS sekai_friend
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE sekai_friend;

CREATE TABLE IF NOT EXISTS sekai_memory_book_user (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    nickname VARCHAR(50) DEFAULT NULL,
    phone_number VARCHAR(20) DEFAULT NULL UNIQUE,

    membership_plan VARCHAR(20) NOT NULL DEFAULT 'FREE',
    pro_expire_time DATETIME DEFAULT NULL,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP
),
    cover_url VARCHAR(1000) DEFAULT NULL,
    watch_date DATE DEFAULT NULL,
    memory_text TEXT DEFAULT NULL,
    tags VARCHAR(255) DEFAULT NULL,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_anime_user_id (user_id)
)瑙掕壊鏀惰棌琛?;

CREATE TABLE IF NOT EXISTS sekai_memory_book_quote (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    anime_id BIGINT DEFAULT NULL,
    character_name VARCHAR(100) DEFAULT NULL,
    content VARCHAR(500) NOT NULL,
    feeling TEXT DEFAULT NULL鏍囩',
    video_url VARCHAR(1000) DEFAULT NULL,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_quote_user_id (user_id)
)DEMO',
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    paid_time DATETIME DEFAULT NULL,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_order_user_id (user_id),
    INDEX idx_order_status (status)
);

