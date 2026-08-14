SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SET @submissions_intro_beats_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'song_submissions'
    AND COLUMN_NAME = 'intro_beats'
);
SET @drop_submissions_intro_beats := IF(
  @submissions_intro_beats_exists > 0,
  'ALTER TABLE song_submissions DROP COLUMN intro_beats',
  'DO 0'
);
PREPARE drop_submissions_intro_beats_stmt FROM @drop_submissions_intro_beats;
EXECUTE drop_submissions_intro_beats_stmt;
DEALLOCATE PREPARE drop_submissions_intro_beats_stmt;

SET @submissions_beats_per_line_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'song_submissions'
    AND COLUMN_NAME = 'beats_per_line'
);
SET @drop_submissions_beats_per_line := IF(
  @submissions_beats_per_line_exists > 0,
  'ALTER TABLE song_submissions DROP COLUMN beats_per_line',
  'DO 0'
);
PREPARE drop_submissions_beats_per_line_stmt FROM @drop_submissions_beats_per_line;
EXECUTE drop_submissions_beats_per_line_stmt;
DEALLOCATE PREPARE drop_submissions_beats_per_line_stmt;

SET @submissions_bpm_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'song_submissions'
    AND COLUMN_NAME = 'bpm'
);
SET @drop_submissions_bpm := IF(
  @submissions_bpm_exists > 0,
  'ALTER TABLE song_submissions DROP COLUMN bpm',
  'DO 0'
);
PREPARE drop_submissions_bpm_stmt FROM @drop_submissions_bpm;
EXECUTE drop_submissions_bpm_stmt;
DEALLOCATE PREPARE drop_submissions_bpm_stmt;

SET @songs_intro_beats_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'songs'
    AND COLUMN_NAME = 'intro_beats'
);
SET @drop_songs_intro_beats := IF(
  @songs_intro_beats_exists > 0,
  'ALTER TABLE songs DROP COLUMN intro_beats',
  'DO 0'
);
PREPARE drop_songs_intro_beats_stmt FROM @drop_songs_intro_beats;
EXECUTE drop_songs_intro_beats_stmt;
DEALLOCATE PREPARE drop_songs_intro_beats_stmt;

SET @songs_beats_per_line_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'songs'
    AND COLUMN_NAME = 'beats_per_line'
);
SET @drop_songs_beats_per_line := IF(
  @songs_beats_per_line_exists > 0,
  'ALTER TABLE songs DROP COLUMN beats_per_line',
  'DO 0'
);
PREPARE drop_songs_beats_per_line_stmt FROM @drop_songs_beats_per_line;
EXECUTE drop_songs_beats_per_line_stmt;
DEALLOCATE PREPARE drop_songs_beats_per_line_stmt;

SET @songs_bpm_exists := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'songs'
    AND COLUMN_NAME = 'bpm'
);
SET @drop_songs_bpm := IF(
  @songs_bpm_exists > 0,
  'ALTER TABLE songs DROP COLUMN bpm',
  'DO 0'
);
PREPARE drop_songs_bpm_stmt FROM @drop_songs_bpm;
EXECUTE drop_songs_bpm_stmt;
DEALLOCATE PREPARE drop_songs_bpm_stmt;
