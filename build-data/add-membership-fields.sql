USE sekai_friend;

SET @schema_name = 'sekai_friend';
SET @table_name = 'sekai_memory_book_user';

SET @add_plan = (
    SELECT IF(COUNT(*) = 0,
        'ALTER TABLE sekai_friend.sekai_memory_book_user ADD COLUMN membership_plan VARCHAR(20) NOT NULL DEFAULT ''FREE'' COMMENT ''membership plan'' AFTER avatar',
        'SELECT 1')
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = @schema_name
      AND TABLE_NAME = @table_name
      AND COLUMN_NAME = 'membership_plan'
);
PREPARE stmt FROM @add_plan;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @add_expire = (
    SELECT IF(COUNT(*) = 0,
        'ALTER TABLE sekai_friend.sekai_memory_book_user ADD COLUMN pro_expire_time DATETIME DEFAULT NULL COMMENT ''Pro expiration time'' AFTER membership_plan',
        'SELECT 1')
    FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = @schema_name
      AND TABLE_NAME = @table_name
      AND COLUMN_NAME = 'pro_expire_time'
);
PREPARE stmt FROM @add_expire;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

UPDATE sekai_memory_book_user
SET membership_plan = 'PRO',
    pro_expire_time = DATE_ADD(NOW(), INTERVAL 365 DAY)
WHERE username = 'sekai';

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
