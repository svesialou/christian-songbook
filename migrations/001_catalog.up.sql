SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS catalog_versions (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  version VARCHAR(64) NOT NULL,
  published_at DATETIME NOT NULL,
  is_current TINYINT(1) NOT NULL DEFAULT 0,
  notes VARCHAR(255) NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_catalog_versions_version (version),
  KEY idx_catalog_versions_current (is_current, published_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS songs (
  id VARCHAR(64) NOT NULL,
  catalog_version_id BIGINT UNSIGNED NOT NULL,
  number INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  category VARCHAR(128) NOT NULL DEFAULT 'Общее',
  default_key VARCHAR(16) NULL,
  lead_sheet MEDIUMTEXT NOT NULL,
  bpm SMALLINT UNSIGNED NULL,
  beats_per_line TINYINT UNSIGNED NULL,
  intro_beats TINYINT UNSIGNED NULL,
  status VARCHAR(32) NOT NULL DEFAULT 'published',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT fk_songs_catalog_version FOREIGN KEY (catalog_version_id) REFERENCES catalog_versions(id),
  KEY idx_songs_catalog_number (catalog_version_id, number),
  KEY idx_songs_catalog_status_number (catalog_version_id, status, number),
  KEY idx_songs_catalog_status_category_number (catalog_version_id, status, category, number),
  KEY idx_songs_title (title),
  FULLTEXT KEY ft_songs_lead_sheet (title, lead_sheet)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

START TRANSACTION;

INSERT INTO catalog_versions (version, published_at, is_current, notes)
VALUES ('2026.08.12.1', '2026-08-12 00:00:00', 1, 'Initial local seed catalog')
ON DUPLICATE KEY UPDATE
  published_at = VALUES(published_at),
  is_current = VALUES(is_current),
  notes = VALUES(notes);

SET @catalog_version_id := (SELECT id FROM catalog_versions WHERE version = '2026.08.12.1' LIMIT 1);
UPDATE catalog_versions SET is_current = 0 WHERE id <> @catalog_version_id;

-- Initial demo songs are intentionally not seeded.
-- The PWA ships a bundled catalog and MySQL should be populated through approved admin/import seed flows.
COMMIT;
