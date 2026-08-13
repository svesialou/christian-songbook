SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

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

UPDATE songs SET category = 'Прославление' WHERE id = 'song-1';
UPDATE songs SET category = 'Молитвенные' WHERE id = 'song-2';
