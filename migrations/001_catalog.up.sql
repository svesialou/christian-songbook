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
  status VARCHAR(32) NOT NULL DEFAULT 'published',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT fk_songs_catalog_version FOREIGN KEY (catalog_version_id) REFERENCES catalog_versions(id),
  KEY idx_songs_catalog_number (catalog_version_id, number),
  KEY idx_songs_catalog_status_number (catalog_version_id, status, number),
  KEY idx_songs_catalog_status_category_number (catalog_version_id, status, category, number),
  KEY idx_songs_title (title)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET @category_column_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'songs'
    AND COLUMN_NAME = 'category'
);
SET @add_category_column := IF(
  @category_column_exists = 0,
  'ALTER TABLE songs ADD COLUMN category VARCHAR(128) NOT NULL DEFAULT ''Общее'' AFTER title',
  'DO 0'
);
PREPARE add_category_column_stmt FROM @add_category_column;
EXECUTE add_category_column_stmt;
DEALLOCATE PREPARE add_category_column_stmt;

SET @category_index_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.STATISTICS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'songs'
    AND INDEX_NAME = 'idx_songs_catalog_status_category_number'
);
SET @add_category_index := IF(
  @category_index_exists = 0,
  'ALTER TABLE songs ADD INDEX idx_songs_catalog_status_category_number (catalog_version_id, status, category, number)',
  'DO 0'
);
PREPARE add_category_index_stmt FROM @add_category_index;
EXECUTE add_category_index_stmt;
DEALLOCATE PREPARE add_category_index_stmt;

CREATE TABLE IF NOT EXISTS song_sections (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  song_id VARCHAR(64) NOT NULL,
  section_type VARCHAR(32) NOT NULL,
  position INT NOT NULL,
  title VARCHAR(128) NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_song_sections_song FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE,
  UNIQUE KEY uq_song_sections_song_position (song_id, position),
  KEY idx_song_sections_song_type_position (song_id, section_type, position)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS song_lines (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  section_id BIGINT UNSIGNED NOT NULL,
  position INT NOT NULL,
  text VARCHAR(500) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_song_lines_section FOREIGN KEY (section_id) REFERENCES song_sections(id) ON DELETE CASCADE,
  UNIQUE KEY uq_song_lines_section_position (section_id, position),
  KEY idx_song_lines_text (text(120))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS song_line_chords (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  line_id BIGINT UNSIGNED NOT NULL,
  position INT NOT NULL,
  chord VARCHAR(32) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_song_line_chords_line FOREIGN KEY (line_id) REFERENCES song_lines(id) ON DELETE CASCADE,
  UNIQUE KEY uq_song_line_chords_line_position (line_id, position),
  KEY idx_song_line_chords_chord (chord)
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

DELETE FROM songs WHERE catalog_version_id = @catalog_version_id AND id IN ('song-1', 'song-2');

INSERT INTO songs (id, catalog_version_id, number, title, category, default_key, status)
VALUES
  ('song-1', @catalog_version_id, 1, 'Слово есть Твоя сила', 'Прославление', 'C', 'published'),
  ('song-2', @catalog_version_id, 2, 'Только Твоё имя', 'Молитвенные', 'C', 'published');

INSERT INTO song_sections (song_id, section_type, position, title) VALUES ('song-1', 'verse', 1, 'Куплет 1');
SET @section_id := LAST_INSERT_ID();
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 1, 'Слово есть Твоя сила');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'C');
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 2, 'В Небе и в нас');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'G');
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 3, 'Слово есть Твоя сила');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'Am');
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 4, 'Нам спасенье и жизнь');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'F');

INSERT INTO song_sections (song_id, section_type, position, title) VALUES ('song-1', 'verse', 2, 'Куплет 2');
SET @section_id := LAST_INSERT_ID();
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 1, 'Твои пути веди');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'C');
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 2, 'Твои огни');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'F');
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 3, 'С нами Господь');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'G');
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 4, 'Слава Тебе');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'C');

INSERT INTO song_sections (song_id, section_type, position, title) VALUES ('song-1', 'chorus', 3, 'Припев');
SET @section_id := LAST_INSERT_ID();
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 1, 'Господь наш, Ты един');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'F');
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 2, 'Сердце поет Тебе');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'G');
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 3, 'Пусть звучит Евангелие');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'C');
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 4, 'С нами Ты до конца');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'Am');

INSERT INTO song_sections (song_id, section_type, position, title) VALUES ('song-1', 'bridge', 4, 'Мост');
SET @section_id := LAST_INSERT_ID();
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 1, 'Скорей мы в путь Твой входим');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'Dm');
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 2, 'Подняв руки и взор');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'Em');
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 3, 'Только Ты — Истина');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'C');

INSERT INTO song_sections (song_id, section_type, position, title) VALUES ('song-2', 'verse', 1, 'Куплет 1');
SET @section_id := LAST_INSERT_ID();
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 1, 'Ты — моё утро и вечер');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'F');
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 2, 'Ты — источник мира');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'G');
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 3, 'Крепче неба — Твоя рука');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'Em');
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 4, 'С нами Ты и всегда');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'Am');

INSERT INTO song_sections (song_id, section_type, position, title) VALUES ('song-2', 'verse', 2, 'Куплет 2');
SET @section_id := LAST_INSERT_ID();
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 1, 'Если путь мой тёмный');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'F');
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 2, 'Твоя любовь — свет');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'G');
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 3, 'В страхе моём Твоя любовь — дверь');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'F');
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 4, 'Вперед ведёт меня');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'C');

INSERT INTO song_sections (song_id, section_type, position, title) VALUES ('song-2', 'chorus', 3, 'Припев');
SET @section_id := LAST_INSERT_ID();
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 1, 'Только Твоё имя, только Твоё имя');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'C');
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 2, 'Поднимает меня снова');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'F');
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 3, 'Только Твоё имя, только Твоё имя');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'G');
INSERT INTO song_lines (section_id, position, text) VALUES (@section_id, 4, 'Очищает сердце моё');
SET @line_id := LAST_INSERT_ID();
INSERT INTO song_line_chords (line_id, position, chord) VALUES (@line_id, 1, 'C');

COMMIT;
