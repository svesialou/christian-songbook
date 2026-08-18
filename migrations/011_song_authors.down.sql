SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SET @submissions_source_authors_json_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'song_submissions'
    AND COLUMN_NAME = 'source_authors_json'
);
SET @drop_submissions_source_authors_json := IF(
  @submissions_source_authors_json_exists = 1,
  'ALTER TABLE song_submissions DROP COLUMN source_authors_json',
  'DO 0'
);
PREPARE drop_submissions_source_authors_json_stmt FROM @drop_submissions_source_authors_json;
EXECUTE drop_submissions_source_authors_json_stmt;
DEALLOCATE PREPARE drop_submissions_source_authors_json_stmt;

SET @submissions_authors_json_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'song_submissions'
    AND COLUMN_NAME = 'authors_json'
);
SET @drop_submissions_authors_json := IF(
  @submissions_authors_json_exists = 1,
  'ALTER TABLE song_submissions DROP COLUMN authors_json',
  'DO 0'
);
PREPARE drop_submissions_authors_json_stmt FROM @drop_submissions_authors_json;
EXECUTE drop_submissions_authors_json_stmt;
DEALLOCATE PREPARE drop_submissions_authors_json_stmt;

SET @songs_authors_json_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'songs'
    AND COLUMN_NAME = 'authors_json'
);
SET @drop_songs_authors_json := IF(
  @songs_authors_json_exists = 1,
  'ALTER TABLE songs DROP COLUMN authors_json',
  'DO 0'
);
PREPARE drop_songs_authors_json_stmt FROM @drop_songs_authors_json;
EXECUTE drop_songs_authors_json_stmt;
DEALLOCATE PREPARE drop_songs_authors_json_stmt;
