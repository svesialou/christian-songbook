SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS song_submissions (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  category VARCHAR(128) NOT NULL DEFAULT 'Общее',
  default_key VARCHAR(16) NULL,
  lead_sheet MEDIUMTEXT NOT NULL,
  sheet_music_url VARCHAR(1000) NULL,
  submitter_name VARCHAR(128) NULL,
  submitter_email VARCHAR(255) NULL,
  note VARCHAR(1000) NULL,
  status VARCHAR(32) NOT NULL DEFAULT 'pending',
  submitted_song_id VARCHAR(64) NULL,
  rejection_reason VARCHAR(500) NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  reviewed_at DATETIME NULL,
  PRIMARY KEY (id),
  KEY idx_song_submissions_status_created (status, created_at),
  KEY idx_song_submissions_title (title),
  FULLTEXT KEY ft_song_submissions_lead_sheet (title, lead_sheet)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
