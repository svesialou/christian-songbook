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

func TestParsePreferredKeysJSON(t *testing.T) {
	keys, err := parsePreferredKeysJSON(`["G","D","A"]`)
	if err != nil {
		t.Fatalf("parsePreferredKeysJSON returned error: %v", err)
	}
	if !reflect.DeepEqual(keys, []string{"G", "D", "A"}) {
		t.Fatalf("unexpected preferred keys: %#v", keys)
	}
}

func TestParsePreferredKeysJSONEmpty(t *testing.T) {
	keys, err := parsePreferredKeysJSON("")
	if err != nil {
		t.Fatalf("parsePreferredKeysJSON returned error: %v", err)
	}
	if len(keys) != 0 {
		t.Fatalf("expected empty preferred keys, got %#v", keys)
	}
}

func TestNormalizeUserPreferences(t *testing.T) {
	preferences, err := normalizeUserPreferences(updateUserPreferencesRequest{
		Instrument:            " Guitar ",
		PreferredKeys:         []string{"G", "D", "G", "", "A"},
		CapoEnabled:           true,
		MaxCapo:               7,
		PianoTransposeEnabled: true,
		ShowOriginalKey:       true,
	})
	if err != nil {
		t.Fatalf("normalizeUserPreferences returned error: %v", err)
	}

	expected := userPreferencesResponse{
		Instrument:            "guitar",
		PreferredKeys:         []string{"G", "D", "A"},
		CapoEnabled:           true,
		MaxCapo:               7,
		PianoTransposeEnabled: true,
		ShowOriginalKey:       true,
	}
	if !reflect.DeepEqual(preferences, expected) {
		t.Fatalf("unexpected preferences: %#v", preferences)
	}
}

func TestNormalizeUserPreferencesRejectsInvalidInstrument(t *testing.T) {
	_, err := normalizeUserPreferences(updateUserPreferencesRequest{Instrument: "drums"})
	if !errors.Is(err, errValidation) {
		t.Fatalf("expected validation error, got %v", err)
	}
}

func TestNormalizeUserSongPreference(t *testing.T) {
	transposeSteps := -2
	capo := 3
	preference, err := normalizeUserSongPreference(" bog-tvoi-czar ", updateUserSongPreferenceRequest{
		TargetKey:      " G ",
		TransposeSteps: &transposeSteps,
		Capo:           &capo,
		Note:           " capo 3 ",
	})
	if err != nil {
		t.Fatalf("normalizeUserSongPreference returned error: %v", err)
	}

	expected := userSongPreferenceResponse{
		SongID:         "bog-tvoi-czar",
		TargetKey:      "G",
		TransposeSteps: &transposeSteps,
		Capo:           &capo,
		Note:           "capo 3",
	}
	if !reflect.DeepEqual(preference, expected) {
		t.Fatalf("unexpected song preference: %#v", preference)
	}
}

func TestNormalizeUserSongPreferenceRejectsInvalidTranspose(t *testing.T) {
	transposeSteps := 12
	_, err := normalizeUserSongPreference("song", updateUserSongPreferenceRequest{TransposeSteps: &transposeSteps})
	if !errors.Is(err, errValidation) {
		t.Fatalf("expected validation error, got %v", err)
	}
}

func TestNormalizeSongIDRejectsEmpty(t *testing.T) {
	_, err := normalizeSongID(" ")
	if !errors.Is(err, errValidation) {
		t.Fatalf("expected validation error, got %v", err)
	}
}

func TestSafeRedirectPath(t *testing.T) {
	cases := map[string]string{
		"":                     "/",
		"/settings":            "/settings",
		"/song/bog-tvoi-czar":  "/song/bog-tvoi-czar",
		"settings":             "/",
		"//evil.example":       "/",
		"https://evil.example": "/",
	}

	for input, expected := range cases {
		if actual := safeRedirectPath(input); actual != expected {
			t.Fatalf("safeRedirectPath(%q) = %q, expected %q", input, actual, expected)
		}
	}
}

func TestRandomURLToken(t *testing.T) {
	token, err := randomURLToken(16)
	if err != nil {
		t.Fatalf("randomURLToken returned error: %v", err)
	}
	if len(token) != 32 {
		t.Fatalf("expected 32 hex chars, got %d: %q", len(token), token)
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
