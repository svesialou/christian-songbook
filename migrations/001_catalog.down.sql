SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

START TRANSACTION;

DELETE FROM catalog_versions WHERE version = '2026.08.12.1';

DROP TABLE IF EXISTS song_line_chords;
DROP TABLE IF EXISTS song_lines;
DROP TABLE IF EXISTS song_sections;
DROP TABLE IF EXISTS songs;
DROP TABLE IF EXISTS catalog_versions;

COMMIT;
