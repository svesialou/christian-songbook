SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SET @songs_sheet_music_url_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'songs'
    AND COLUMN_NAME = 'sheet_music_url'
);
SET @add_songs_sheet_music_url := IF(
  @songs_sheet_music_url_exists = 0,
  'ALTER TABLE songs ADD COLUMN sheet_music_url VARCHAR(1000) NULL AFTER lead_sheet',
  'DO 0'
);
PREPARE add_songs_sheet_music_url_stmt FROM @add_songs_sheet_music_url;
EXECUTE add_songs_sheet_music_url_stmt;
DEALLOCATE PREPARE add_songs_sheet_music_url_stmt;

SET @submissions_sheet_music_url_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'song_submissions'
    AND COLUMN_NAME = 'sheet_music_url'
);
SET @add_submissions_sheet_music_url := IF(
  @submissions_sheet_music_url_exists = 0,
  'ALTER TABLE song_submissions ADD COLUMN sheet_music_url VARCHAR(1000) NULL AFTER lead_sheet',
  'DO 0'
);
PREPARE add_submissions_sheet_music_url_stmt FROM @add_submissions_sheet_music_url;
EXECUTE add_submissions_sheet_music_url_stmt;
DEALLOCATE PREPARE add_submissions_sheet_music_url_stmt;
