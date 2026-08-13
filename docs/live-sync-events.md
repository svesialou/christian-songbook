# Live sync event draft

## Scope
This document defines a future event model for live synchronization.

It is not a public API contract yet and does not require WebSocket, HTTP, database schema, authentication, or server implementation changes.

## Principles
- The songbook remains usable offline without a live session.
- A collection is the source library; a live setlist is a separate ordered queue.
- Live state is session-scoped and must not mutate catalog songs.
- Events are idempotent by `eventId`.
- Ordering is controlled by monotonically increasing `revision` inside one `sessionId`.
- A client must ignore events with an older `revision` than the last applied revision for the same session.
- Server time is preferred later, but local clients may use ISO timestamps for the draft phase.

## Shared envelope

```json
{
  "eventId": "evt_01HZXZ7P4R9YJ4W6M5D5E1J8Z7",
  "type": "setlist.update",
  "sessionId": "live_01HZXZ6W3T2Q4K9R7N5M2P8A1C",
  "revision": 12,
  "clientId": "client_lead_1",
  "createdAt": "2026-08-13T10:00:00.000Z",
  "payload": {}
}
```

## `setlist.update`

Updates the ordered live queue without changing the source collection.

```json
{
  "sourceCollectionId": "collection-sunday",
  "songs": [
    {
      "songId": "song-1",
      "order": 1
    },
    {
      "songId": "song-2",
      "order": 2
    }
  ],
  "activeSongId": "song-1"
}
```

Rules:
- `songs` contains only song IDs from the selected source collection or a future allowed shared catalog scope.
- `order` is explicit to avoid relying on array merge order.
- Removing a song from the live queue does not remove it from the collection.
- If `activeSongId` is removed, clients should select the first available song or show an empty live state.

## `position.update`

Updates the current place in the active live song.

```json
{
  "songId": "song-1",
  "sectionId": "verse-0",
  "sectionTitle": "Куплет 1",
  "lineIndex": 0,
  "autoPlayback": {
    "isRunning": true,
    "startedAt": "2026-08-13T10:00:04.000Z",
    "bpm": 72,
    "beatsPerLine": 4,
    "introBeats": 8
  }
}
```

Rules:
- `songId` must exist in the current live setlist.
- `sectionId` and `lineIndex` are the stable target for highlighting and smooth scroll.
- `sectionTitle` is display-only fallback for clients that cannot resolve section metadata.
- `autoPlayback` is optional; clients may still apply manual line updates.
- Audio playback and metronome transport are not included in this event.

## `role.update`

Updates a participant display preset for the session.

```json
{
  "participantId": "participant-guitar-1",
  "preset": "Chords",
  "settings": {
    "showChords": true,
    "repeatChorus": true,
    "fontScale": "large",
    "transposition": 0
  }
}
```

Rules:
- `preset` maps to local view presets such as `Lead`, `Singer`, and `Chords`.
- Participant settings affect only the participant view, not the catalog and not the live setlist.
- Future server authorization decides who can update another participant's role.

## Conflict handling draft
- Within one `sessionId`, higher `revision` wins.
- Duplicate `eventId` is ignored.
- Same revision from different clients is a conflict and should be resolved by the future server/master device before broadcasting.
- Offline clients may keep a local live queue, but must not overwrite a newer synced session without explicit user action.

## Deferred decisions
- Transport: WebSocket, SSE, long-poll, or another channel.
- Master election and permissions.
- Persistent MySQL schema for sessions, participants, revisions, and event log.
- Authentication and invite model.
- Latency and clock synchronization strategy.
