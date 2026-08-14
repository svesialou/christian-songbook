SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SET @songs_bpm_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'songs'
    AND COLUMN_NAME = 'bpm'
);
SET @add_songs_bpm := IF(
  @songs_bpm_exists = 0,
  'ALTER TABLE songs ADD COLUMN bpm SMALLINT UNSIGNED NULL AFTER default_key',
  'DO 0'
);
PREPARE add_songs_bpm_stmt FROM @add_songs_bpm;
EXECUTE add_songs_bpm_stmt;
DEALLOCATE PREPARE add_songs_bpm_stmt;

SET @songs_beats_per_line_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'songs'
    AND COLUMN_NAME = 'beats_per_line'
);
SET @add_songs_beats_per_line := IF(
  @songs_beats_per_line_exists = 0,
  'ALTER TABLE songs ADD COLUMN beats_per_line TINYINT UNSIGNED NULL AFTER bpm',
  'DO 0'
);
PREPARE add_songs_beats_per_line_stmt FROM @add_songs_beats_per_line;
EXECUTE add_songs_beats_per_line_stmt;
DEALLOCATE PREPARE add_songs_beats_per_line_stmt;

SET @songs_intro_beats_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'songs'
    AND COLUMN_NAME = 'intro_beats'
);
SET @add_songs_intro_beats := IF(
  @songs_intro_beats_exists = 0,
  'ALTER TABLE songs ADD COLUMN intro_beats TINYINT UNSIGNED NULL AFTER beats_per_line',
  'DO 0'
);
PREPARE add_songs_intro_beats_stmt FROM @add_songs_intro_beats;
EXECUTE add_songs_intro_beats_stmt;
DEALLOCATE PREPARE add_songs_intro_beats_stmt;

SET @submissions_bpm_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'song_submissions'
    AND COLUMN_NAME = 'bpm'
);
SET @add_submissions_bpm := IF(
  @submissions_bpm_exists = 0,
  'ALTER TABLE song_submissions ADD COLUMN bpm SMALLINT UNSIGNED NULL AFTER chords',
  'DO 0'
);
PREPARE add_submissions_bpm_stmt FROM @add_submissions_bpm;
EXECUTE add_submissions_bpm_stmt;
DEALLOCATE PREPARE add_submissions_bpm_stmt;

SET @submissions_beats_per_line_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'song_submissions'
    AND COLUMN_NAME = 'beats_per_line'
);
SET @add_submissions_beats_per_line := IF(
  @submissions_beats_per_line_exists = 0,
  'ALTER TABLE song_submissions ADD COLUMN beats_per_line TINYINT UNSIGNED NULL AFTER bpm',
  'DO 0'
);
PREPARE add_submissions_beats_per_line_stmt FROM @add_submissions_beats_per_line;
EXECUTE add_submissions_beats_per_line_stmt;
DEALLOCATE PREPARE add_submissions_beats_per_line_stmt;

SET @submissions_intro_beats_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'song_submissions'
    AND COLUMN_NAME = 'intro_beats'
);
SET @add_submissions_intro_beats := IF(
  @submissions_intro_beats_exists = 0,
  'ALTER TABLE song_submissions ADD COLUMN intro_beats TINYINT UNSIGNED NULL AFTER beats_per_line',
  'DO 0'
);
PREPARE add_submissions_intro_beats_stmt FROM @add_submissions_intro_beats;
EXECUTE add_submissions_intro_beats_stmt;
DEALLOCATE PREPARE add_submissions_intro_beats_stmt;
