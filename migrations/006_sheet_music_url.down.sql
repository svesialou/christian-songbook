SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SET @submissions_sheet_music_url_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'song_submissions'
    AND COLUMN_NAME = 'sheet_music_url'
);
SET @drop_submissions_sheet_music_url := IF(
  @submissions_sheet_music_url_exists = 1,
  'ALTER TABLE song_submissions DROP COLUMN sheet_music_url',
  'DO 0'
);
PREPARE drop_submissions_sheet_music_url_stmt FROM @drop_submissions_sheet_music_url;
EXECUTE drop_submissions_sheet_music_url_stmt;
DEALLOCATE PREPARE drop_submissions_sheet_music_url_stmt;

SET @songs_sheet_music_url_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'songs'
    AND COLUMN_NAME = 'sheet_music_url'
);
SET @drop_songs_sheet_music_url := IF(
  @songs_sheet_music_url_exists = 1,
  'ALTER TABLE songs DROP COLUMN sheet_music_url',
  'DO 0'
);
PREPARE drop_songs_sheet_music_url_stmt FROM @drop_songs_sheet_music_url;
EXECUTE drop_songs_sheet_music_url_stmt;
DEALLOCATE PREPARE drop_songs_sheet_music_url_stmt;
