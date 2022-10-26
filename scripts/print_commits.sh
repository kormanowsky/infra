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
