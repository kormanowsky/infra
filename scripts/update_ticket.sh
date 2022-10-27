function print_commits() {

  cur_tag=$(git describe --tags --abbrev=0 2>/dev/null)
  git checkout HEAD^1 >/dev/null 2>&1
  last_tag=$(git describe --tags --abbrev=0 2>/dev/null)
  rc=$?
  git checkout $cur_tag >/dev/null 2>&1
  if [[ $rc -eq 0 ]]; then
    log_filter="$last_tag..HEAD"
  else
    log_filter=""
  fi
  git --no-pager log $log_filter --oneline --format="%h %an %s"
}

function main() {
  jo -d . -- \
    -s org_id="$TRACKER_ORG_ID" \
    -s token="$TRACKER_TOKEN" \
    -s ticket_id="$TRACKER_TICKET" \
    -s action=update_ticket \
    -s update.summary="$(date +%d.%m.%Y) - TODO" \
    -s update.description="$(
      echo "ответственный за релиз TODO"
      echo "коммиты, попавшие в релиз:"
      print_commits
    )" | xargs -0 python3 "$(dirname "$0")/sync_with_tracker.py"
}

main
