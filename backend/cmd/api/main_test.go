package main

import (
	"errors"
	"reflect"
	"testing"
)

func TestParseLeadSheetSectionsFlatInput(t *testing.T) {
	sections, err := parseLeadSheetSections("C G\nLine one\nAm\nLine two")
	if err != nil {
		t.Fatalf("parseLeadSheetSections returned error: %v", err)
	}
	if len(sections) != 1 {
		t.Fatalf("expected 1 section, got %d", len(sections))
	}

	assertParsedSection(t, sections[0], "verse", "Куплет 1", []string{"Line one", "Line two"}, [][]string{{"C", "G"}, {"Am"}})
}

func TestParseLeadSheetSectionsKeepsWrittenOrder(t *testing.T) {
	leadSheet := `[Куплет 1]
C
Line one
[Припев]
F G
Chorus line
[Куплет 2]
Am
Line two
[Припев]
F G
Chorus line repeat`

	sections, err := parseLeadSheetSections(leadSheet)
	if err != nil {
		t.Fatalf("parseLeadSheetSections returned error: %v", err)
	}
	if len(sections) != 4 {
		t.Fatalf("expected 4 sections, got %d", len(sections))
	}

	assertParsedSection(t, sections[0], "verse", "Куплет 1", []string{"Line one"}, [][]string{{"C"}})
	assertParsedSection(t, sections[1], "chorus", "Припев", []string{"Chorus line"}, [][]string{{"F", "G"}})
	assertParsedSection(t, sections[2], "verse", "Куплет 2", []string{"Line two"}, [][]string{{"Am"}})
	assertParsedSection(t, sections[3], "chorus", "Припев", []string{"Chorus line repeat"}, [][]string{{"F", "G"}})
}

func TestParseLeadSheetSectionsRecognizesExtendedHeadings(t *testing.T) {
	leadSheet := `[Вступление]
C
Intro line
[Запев 1]
G
Verse line
[Пред припев]
Am
Prechorus line
[Проигрыш]
F
Instrumental line
[Концовка]
C
Outro line`

	sections, err := parseLeadSheetSections(leadSheet)
	if err != nil {
		t.Fatalf("parseLeadSheetSections returned error: %v", err)
	}
	if len(sections) != 5 {
		t.Fatalf("expected 5 sections, got %d", len(sections))
	}

	assertParsedSection(t, sections[0], "intro", "Вступление", []string{"Intro line"}, [][]string{{"C"}})
	assertParsedSection(t, sections[1], "verse", "Запев 1", []string{"Verse line"}, [][]string{{"G"}})
	assertParsedSection(t, sections[2], "prechorus", "Пред припев", []string{"Prechorus line"}, [][]string{{"Am"}})
	assertParsedSection(t, sections[3], "instrumental", "Проигрыш", []string{"Instrumental line"}, [][]string{{"F"}})
	assertParsedSection(t, sections[4], "outro", "Концовка", []string{"Outro line"}, [][]string{{"C"}})
}

func TestParseLeadSheetSectionsRecognizesRepeatSuffix(t *testing.T) {
	leadSheet := `[Припев x2]
F G
Chorus line
[Куплет х2]
C
Verse line`

	sections, err := parseLeadSheetSections(leadSheet)
	if err != nil {
		t.Fatalf("parseLeadSheetSections returned error: %v", err)
	}
	if len(sections) != 2 {
		t.Fatalf("expected 2 sections, got %d", len(sections))
	}

	assertParsedSection(t, sections[0], "chorus", "Припев x2", []string{"Chorus line"}, [][]string{{"F", "G"}})
	assertParsedSection(t, sections[1], "verse", "Куплет х2", []string{"Verse line"}, [][]string{{"C"}})
}

func TestParseLeadSheetSectionsRejectsHeadingsWithoutLyrics(t *testing.T) {
	_, err := parseLeadSheetSections("[Припев]")
	if !errors.Is(err, errValidation) {
		t.Fatalf("expected validation error, got %v", err)
	}
}

func TestMergeLegacyLeadSheet(t *testing.T) {
	leadSheet := mergeLegacyLeadSheet("[Куплет 1]\nLine one\nLine two", "C G\nAm")
	expected := "[Куплет 1]\nC G\nLine one\nAm\nLine two"
	if leadSheet != expected {
		t.Fatalf("unexpected lead sheet:\n%s", leadSheet)
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

func TestNormalizeAuthors(t *testing.T) {
	authors, err := normalizeAuthors([]string{" Hillsong ", "", "hillsong", "Bethel Music"})
	if err != nil {
		t.Fatalf("normalizeAuthors returned error: %v", err)
	}
	expected := []string{"Hillsong", "Bethel Music"}
	if !reflect.DeepEqual(authors, expected) {
		t.Fatalf("unexpected authors: %#v", authors)
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
