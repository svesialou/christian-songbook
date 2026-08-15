SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SET @submissions_source_song_id_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'song_submissions'
    AND COLUMN_NAME = 'source_song_id'
);
SET @add_submissions_source_song_id := IF(
  @submissions_source_song_id_exists = 0,
  'ALTER TABLE song_submissions ADD COLUMN source_song_id VARCHAR(64) NULL AFTER submitted_song_id',
  'DO 0'
);
PREPARE add_submissions_source_song_id_stmt FROM @add_submissions_source_song_id;
EXECUTE add_submissions_source_song_id_stmt;
DEALLOCATE PREPARE add_submissions_source_song_id_stmt;

SET @submissions_source_title_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'song_submissions'
    AND COLUMN_NAME = 'source_title'
);
SET @add_submissions_source_title := IF(
  @submissions_source_title_exists = 0,
  'ALTER TABLE song_submissions ADD COLUMN source_title VARCHAR(255) NULL AFTER source_song_id',
  'DO 0'
);
PREPARE add_submissions_source_title_stmt FROM @add_submissions_source_title;
EXECUTE add_submissions_source_title_stmt;
DEALLOCATE PREPARE add_submissions_source_title_stmt;

SET @submissions_source_lead_sheet_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'song_submissions'
    AND COLUMN_NAME = 'source_lead_sheet'
);
SET @add_submissions_source_lead_sheet := IF(
  @submissions_source_lead_sheet_exists = 0,
  'ALTER TABLE song_submissions ADD COLUMN source_lead_sheet MEDIUMTEXT NULL AFTER source_title',
  'DO 0'
);
PREPARE add_submissions_source_lead_sheet_stmt FROM @add_submissions_source_lead_sheet;
EXECUTE add_submissions_source_lead_sheet_stmt;
DEALLOCATE PREPARE add_submissions_source_lead_sheet_stmt;

SET @submissions_source_index_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.STATISTICS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'song_submissions'
    AND INDEX_NAME = 'idx_song_submissions_source_song_status'
);
SET @add_submissions_source_index := IF(
  @submissions_source_index_exists = 0,
  'ALTER TABLE song_submissions ADD KEY idx_song_submissions_source_song_status (source_song_id, status)',
  'DO 0'
);
PREPARE add_submissions_source_index_stmt FROM @add_submissions_source_index;
EXECUTE add_submissions_source_index_stmt;
DEALLOCATE PREPARE add_submissions_source_index_stmt;
