function main() {
  jo -d . -- \
    -s org_id="$TRACKER_ORG_ID" \
    -s token="$TRACKER_TOKEN" \
    -s ticket_id="$TRACKER_TICKET" \
    -s action=add_comment \
    -s comment.text="Создан образ: $REF_NAME" | xargs -0 \
      python3 "$(dirname "$0")/sync_with_tracker.py"
}

main
