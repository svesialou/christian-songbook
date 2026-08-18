SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SET @songs_authors_json_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'songs'
    AND COLUMN_NAME = 'authors_json'
);
SET @add_songs_authors_json := IF(
  @songs_authors_json_exists = 0,
  'ALTER TABLE songs ADD COLUMN authors_json JSON NULL AFTER category',
  'DO 0'
);
PREPARE add_songs_authors_json_stmt FROM @add_songs_authors_json;
EXECUTE add_songs_authors_json_stmt;
DEALLOCATE PREPARE add_songs_authors_json_stmt;

SET @submissions_authors_json_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'song_submissions'
    AND COLUMN_NAME = 'authors_json'
);
SET @add_submissions_authors_json := IF(
  @submissions_authors_json_exists = 0,
  'ALTER TABLE song_submissions ADD COLUMN authors_json JSON NULL AFTER category',
  'DO 0'
);
PREPARE add_submissions_authors_json_stmt FROM @add_submissions_authors_json;
EXECUTE add_submissions_authors_json_stmt;
DEALLOCATE PREPARE add_submissions_authors_json_stmt;

SET @submissions_source_authors_json_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'song_submissions'
    AND COLUMN_NAME = 'source_authors_json'
);
SET @add_submissions_source_authors_json := IF(
  @submissions_source_authors_json_exists = 0,
  'ALTER TABLE song_submissions ADD COLUMN source_authors_json JSON NULL AFTER source_title',
  'DO 0'
);
PREPARE add_submissions_source_authors_json_stmt FROM @add_submissions_source_authors_json;
EXECUTE add_submissions_source_authors_json_stmt;
DEALLOCATE PREPARE add_submissions_source_authors_json_stmt;
