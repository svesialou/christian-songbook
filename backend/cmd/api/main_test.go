package main

import (
	"errors"
	"reflect"
	"testing"
)

func TestParsePublishedSongSectionsFlatInput(t *testing.T) {
	sections, err := parsePublishedSongSections("Line one\nLine two", "C G\nAm")
	if err != nil {
		t.Fatalf("parsePublishedSongSections returned error: %v", err)
	}
	if len(sections) != 1 {
		t.Fatalf("expected 1 section, got %d", len(sections))
	}

	section := sections[0]
	if section.SectionType != "verse" || section.Title != "Куплет 1" {
		t.Fatalf("unexpected section metadata: %#v", section)
	}
	if !reflect.DeepEqual(section.Lines, []string{"Line one", "Line two"}) {
		t.Fatalf("unexpected lines: %#v", section.Lines)
	}
	if !reflect.DeepEqual(section.Chords, [][]string{{"C", "G"}, {"Am"}}) {
		t.Fatalf("unexpected chords: %#v", section.Chords)
	}
}

func TestParsePublishedSongSectionsWithLyricsAndChordHeadings(t *testing.T) {
	lyrics := `[Куплет 1]
Line one
Line two
[Припев]
Chorus line
[Бридж]
Bridge line`
	chords := `[Куплет 1]
C
G
[Припев]
F G
[Бридж]
Am`

	sections, err := parsePublishedSongSections(lyrics, chords)
	if err != nil {
		t.Fatalf("parsePublishedSongSections returned error: %v", err)
	}
	if len(sections) != 3 {
		t.Fatalf("expected 3 sections, got %d", len(sections))
	}

	assertParsedSection(t, sections[0], "verse", "Куплет 1", []string{"Line one", "Line two"}, [][]string{{"C"}, {"G"}})
	assertParsedSection(t, sections[1], "chorus", "Припев", []string{"Chorus line"}, [][]string{{"F", "G"}})
	assertParsedSection(t, sections[2], "bridge", "Бридж", []string{"Bridge line"}, [][]string{{"Am"}})
}

func TestParsePublishedSongSectionsDistributesFlatChords(t *testing.T) {
	lyrics := `Куплет 1
Line one
Line two
Припев
Chorus line`

	sections, err := parsePublishedSongSections(lyrics, "C\nG\nF")
	if err != nil {
		t.Fatalf("parsePublishedSongSections returned error: %v", err)
	}
	if len(sections) != 2 {
		t.Fatalf("expected 2 sections, got %d", len(sections))
	}

	assertParsedSection(t, sections[0], "verse", "Куплет 1", []string{"Line one", "Line two"}, [][]string{{"C"}, {"G"}})
	assertParsedSection(t, sections[1], "chorus", "Припев", []string{"Chorus line"}, [][]string{{"F"}})
}

func TestParsePublishedSongSectionsRejectsHeadingsWithoutLyrics(t *testing.T) {
	_, err := parsePublishedSongSections("[Припев]", "")
	if !errors.Is(err, errValidation) {
		t.Fatalf("expected validation error, got %v", err)
	}
}

func assertParsedSection(
	t *testing.T,
	section parsedSongSection,
	sectionType string,
	title string,
	lines []string,
	chords [][]string,
) {
	t.Helper()

	if section.SectionType != sectionType || section.Title != title {
		t.Fatalf("unexpected section metadata: %#v", section)
	}
	if !reflect.DeepEqual(section.Lines, lines) {
		t.Fatalf("unexpected lines: %#v", section.Lines)
	}
	if !reflect.DeepEqual(section.Chords, chords) {
		t.Fatalf("unexpected chords: %#v", section.Chords)
	}
}
