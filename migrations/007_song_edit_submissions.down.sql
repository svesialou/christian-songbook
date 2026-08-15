SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SET @submissions_source_index_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.STATISTICS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'song_submissions'
    AND INDEX_NAME = 'idx_song_submissions_source_song_status'
);
SET @drop_submissions_source_index := IF(
  @submissions_source_index_exists = 1,
  'ALTER TABLE song_submissions DROP INDEX idx_song_submissions_source_song_status',
  'DO 0'
);
PREPARE drop_submissions_source_index_stmt FROM @drop_submissions_source_index;
EXECUTE drop_submissions_source_index_stmt;
DEALLOCATE PREPARE drop_submissions_source_index_stmt;

SET @submissions_source_lead_sheet_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'song_submissions'
    AND COLUMN_NAME = 'source_lead_sheet'
);
SET @drop_submissions_source_lead_sheet := IF(
  @submissions_source_lead_sheet_exists = 1,
  'ALTER TABLE song_submissions DROP COLUMN source_lead_sheet',
  'DO 0'
);
PREPARE drop_submissions_source_lead_sheet_stmt FROM @drop_submissions_source_lead_sheet;
EXECUTE drop_submissions_source_lead_sheet_stmt;
DEALLOCATE PREPARE drop_submissions_source_lead_sheet_stmt;

SET @submissions_source_title_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'song_submissions'
    AND COLUMN_NAME = 'source_title'
);
SET @drop_submissions_source_title := IF(
  @submissions_source_title_exists = 1,
  'ALTER TABLE song_submissions DROP COLUMN source_title',
  'DO 0'
);
PREPARE drop_submissions_source_title_stmt FROM @drop_submissions_source_title;
EXECUTE drop_submissions_source_title_stmt;
DEALLOCATE PREPARE drop_submissions_source_title_stmt;

SET @submissions_source_song_id_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'song_submissions'
    AND COLUMN_NAME = 'source_song_id'
);
SET @drop_submissions_source_song_id := IF(
  @submissions_source_song_id_exists = 1,
  'ALTER TABLE song_submissions DROP COLUMN source_song_id',
  'DO 0'
);
PREPARE drop_submissions_source_song_id_stmt FROM @drop_submissions_source_song_id;
EXECUTE drop_submissions_source_song_id_stmt;
DEALLOCATE PREPARE drop_submissions_source_song_id_stmt;
