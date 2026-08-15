SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS users (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  display_name VARCHAR(255) NOT NULL,
  email VARCHAR(320) NULL,
  avatar_url VARCHAR(1000) NULL,
  status VARCHAR(32) NOT NULL DEFAULT 'active',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_users_email (email),
  KEY idx_users_status_updated (status, updated_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS user_identities (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id BIGINT UNSIGNED NOT NULL,
  provider VARCHAR(32) NOT NULL,
  provider_subject VARCHAR(255) NOT NULL,
  email VARCHAR(320) NULL,
  email_verified TINYINT(1) NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT fk_user_identities_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  UNIQUE KEY uq_user_identities_provider_subject (provider, provider_subject),
  KEY idx_user_identities_user (user_id),
  KEY idx_user_identities_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS user_sessions (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id BIGINT UNSIGNED NOT NULL,
  session_token_hash CHAR(64) NOT NULL,
  expires_at DATETIME NOT NULL,
  revoked_at DATETIME NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT fk_user_sessions_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  UNIQUE KEY uq_user_sessions_token_hash (session_token_hash),
  KEY idx_user_sessions_user_expires (user_id, expires_at),
  KEY idx_user_sessions_expires_revoked (expires_at, revoked_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS oauth_login_states (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  provider VARCHAR(32) NOT NULL,
  state_hash CHAR(64) NOT NULL,
  redirect_path VARCHAR(512) NULL,
  expires_at DATETIME NOT NULL,
  consumed_at DATETIME NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_oauth_login_states_state_hash (state_hash),
  KEY idx_oauth_login_states_provider_expires (provider, expires_at),
  KEY idx_oauth_login_states_expires_consumed (expires_at, consumed_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS user_preferences (
  user_id BIGINT UNSIGNED NOT NULL,
  instrument VARCHAR(32) NOT NULL DEFAULT 'guitar',
  preferred_keys_json JSON NULL,
  capo_enabled TINYINT(1) NOT NULL DEFAULT 1,
  max_capo TINYINT UNSIGNED NOT NULL DEFAULT 5,
  piano_transpose_enabled TINYINT(1) NOT NULL DEFAULT 1,
  show_original_key TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id),
  CONSTRAINT fk_user_preferences_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  KEY idx_user_preferences_instrument (instrument)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS user_song_preferences (
  user_id BIGINT UNSIGNED NOT NULL,
  song_id VARCHAR(64) NOT NULL,
  target_key VARCHAR(16) NULL,
  transpose_steps TINYINT NULL,
  capo TINYINT UNSIGNED NULL,
  note VARCHAR(1000) NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, song_id),
  CONSTRAINT fk_user_song_preferences_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_user_song_preferences_song FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE,
  KEY idx_user_song_preferences_song (song_id),
  KEY idx_user_song_preferences_user_updated (user_id, updated_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
