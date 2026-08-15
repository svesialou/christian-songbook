SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS user_collections (
  user_id BIGINT UNSIGNED NOT NULL,
  id VARCHAR(128) NOT NULL,
  name VARCHAR(120) NOT NULL,
  song_ids_json JSON NOT NULL,
  share_token VARCHAR(64) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, id),
  UNIQUE KEY uq_user_collections_share_token (share_token),
  KEY idx_user_collections_user_updated (user_id, updated_at),
  CONSTRAINT fk_user_collections_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
