#!/usr/bin/env bash
set -euo pipefail

ENV_FILE="${CODEX_TELEGRAM_ENV_FILE:-${HOME}/.codex/secrets/telegram.env}"
CAPTION="Христианский сборник песен screenshots"
DRY_RUN=0

usage() {
  cat <<'USAGE'
Usage:
  scripts/send-telegram-screenshots.sh [--caption "text"] <file.png> [file.png...]
  scripts/send-telegram-screenshots.sh --dry-run [--caption "text"] <file.png> [file.png...]

Environment:
  CODEX_TELEGRAM_BOT_TOKEN  Telegram bot token.
  CODEX_TELEGRAM_CHAT_ID    Telegram chat id.
  CODEX_TELEGRAM_ENV_FILE   Optional env file path. Default: ~/.codex/secrets/telegram.env
USAGE
}

FILES=()
while [ "$#" -gt 0 ]; do
  case "$1" in
    --caption)
      CAPTION="${2:-}"
      shift 2
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --help)
      usage
      exit 0
      ;;
    *)
      FILES+=("$1")
      shift
      ;;
  esac
done

if [ "${#FILES[@]}" -eq 0 ]; then
  usage
  exit 2
fi

for file in "${FILES[@]}"; do
  if [ ! -f "$file" ]; then
    echo "ERROR: screenshot file not found: $file" >&2
    exit 2
  fi
done

if [ -f "$ENV_FILE" ]; then
  # shellcheck disable=SC1090
  source "$ENV_FILE"
fi

if [ "$DRY_RUN" -eq 1 ]; then
  echo "Telegram screenshots dry run"
  echo "Env file: $ENV_FILE"
  echo "Bot token: $([ -n "${CODEX_TELEGRAM_BOT_TOKEN:-}" ] && echo configured || echo missing)"
  echo "Chat id: $([ -n "${CODEX_TELEGRAM_CHAT_ID:-}" ] && echo configured || echo missing)"
  printf 'Files:\n'
  printf -- '- %s\n' "${FILES[@]}"
  exit 0
fi

if [ -z "${CODEX_TELEGRAM_BOT_TOKEN:-}" ]; then
  echo "ERROR: CODEX_TELEGRAM_BOT_TOKEN is not configured." >&2
  exit 2
fi

if [ -z "${CODEX_TELEGRAM_CHAT_ID:-}" ]; then
  echo "ERROR: CODEX_TELEGRAM_CHAT_ID is not configured." >&2
  exit 2
fi

if ! command -v curl >/dev/null 2>&1; then
  echo "ERROR: curl is required to send Telegram screenshots." >&2
  exit 2
fi

total="${#FILES[@]}"
index=1
for file in "${FILES[@]}"; do
  curl --fail --silent --show-error \
    --request POST \
    "https://api.telegram.org/bot${CODEX_TELEGRAM_BOT_TOKEN}/sendPhoto" \
    --form-string "chat_id=${CODEX_TELEGRAM_CHAT_ID}" \
    --form-string "caption=${CAPTION} (${index}/${total})" \
    --form "photo=@${file}" \
    >/dev/null
  index=$((index + 1))
done
