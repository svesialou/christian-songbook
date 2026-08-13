SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SET @category_index_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.STATISTICS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'songs'
    AND INDEX_NAME = 'idx_songs_catalog_status_category_number'
);
SET @drop_category_index := IF(
  @category_index_exists > 0,
  'ALTER TABLE songs DROP INDEX idx_songs_catalog_status_category_number',
  'DO 0'
);
PREPARE drop_category_index_stmt FROM @drop_category_index;
EXECUTE drop_category_index_stmt;
DEALLOCATE PREPARE drop_category_index_stmt;

SET @category_column_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'songs'
    AND COLUMN_NAME = 'category'
);
SET @drop_category_column := IF(
  @category_column_exists > 0,
  'ALTER TABLE songs DROP COLUMN category',
  'DO 0'
);
PREPARE drop_category_column_stmt FROM @drop_category_column;
EXECUTE drop_category_column_stmt;
DEALLOCATE PREPARE drop_category_column_stmt;
