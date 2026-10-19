#!/usr/bin/env bash
# Poller: one open `repo-sync` issue per watched repo when its default branch moves.
# Reads .github/repo-sync.json, compares HEAD SHAs against .github/repo-sync-state.json.
#
# Env:
#   GH_TOKEN   - PAT (REPO_SYNC_TOKEN). Required for writes; issues filed with it
#                re-trigger `issues: opened` workflows (GITHUB_TOKEN would not).
#   TARGET_REPO, LABEL, CONFIG, STATE_FILE - override defaults below.
#   DRY_RUN=1  - report actions without creating issues or touching state.
set -euo pipefail

TARGET_REPO="${TARGET_REPO:-vsreddyh/portfolio-resume}"
LABEL="${LABEL:-repo-sync}"
CONFIG="${CONFIG:-.github/repo-sync.json}"
STATE_FILE="${STATE_FILE:-.github/repo-sync-state.json}"
DRY_RUN="${DRY_RUN:-0}"

export GH_TOKEN="${GH_TOKEN:-${REPO_SYNC_TOKEN:-}}"
if [[ -z "$GH_TOKEN" && "$DRY_RUN" != "1" ]]; then
  echo "error: GH_TOKEN/REPO_SYNC_TOKEN is required (or set DRY_RUN=1)" >&2
  exit 1
fi

gh label create "$LABEL" --repo "$TARGET_REPO" --color "1f883d" \
  --description "Upstream repo update detected by poller" 2>/dev/null || true

tmp_state="$(mktemp)"
cp "$STATE_FILE" "$tmp_state"
changed=0

while IFS= read -r entry; do
  repo="$(jq -r .repo <<<"$entry")"
  portfolio="$(jq -r '.portfolio // "none (resume-only)"' <<<"$entry")"
  branch="$(gh api "repos/$repo" --jq .default_branch)"
  head_sha="$(gh api "repos/$repo/commits/$branch" --jq .sha)"
  old_sha="$(jq -r --arg r "$repo" '.[$r] // ""' "$tmp_state")"

  if [[ "$head_sha" == "$old_sha" ]]; then
    echo "SKIP $repo (unchanged $head_sha)"
    continue
  fi
  if [[ -z "$old_sha" ]]; then
    echo "BASELINE $repo ($head_sha, no prior state - recording only)"
    jq --arg r "$repo" --arg s "$head_sha" '.[$r] = $s' "$tmp_state" >"$tmp_state.new"
    mv "$tmp_state.new" "$tmp_state"
    changed=1
    continue
  fi

  compare_url="https://github.com/$repo/compare/$old_sha...$head_sha"
  if [[ "$DRY_RUN" == "1" ]]; then
    echo "WOULD-FILE $repo ($old_sha -> $head_sha)"
    continue
  fi

  open_issue="$(gh issue list --repo "$TARGET_REPO" --label "$LABEL" --state open \
    --search "\"$repo\" in:title" --json number --jq '.[0].number // ""')"
  if [[ -n "$open_issue" ]]; then
    echo "COMMENT $repo -> issue #$open_issue ($old_sha -> $head_sha)"
    gh issue comment "$open_issue" --repo "$TARGET_REPO" --body "$(cat <<EOF
$repo moved again: [\`$old_sha\`...\`$head_sha\`]($compare_url)

Portfolio file: \`$portfolio\`
EOF
)"
  else
    echo "FILE $repo ($old_sha -> $head_sha)"
    gh issue create --repo "$TARGET_REPO" --label "$LABEL" \
      --title "[repo-sync] $repo updated" --body "$(cat <<EOF
Upstream repo **$repo** moved on \`$branch\`:

- Before: \`$old_sha\`
- Now: \`$head_sha\`
- Diff: $compare_url

Portfolio file: \`$portfolio\` (resume: \`resume/Main_Resume.tex\`)

One open issue per repo is kept by the poller; further pushes comment here until this is closed.
EOF
)"
  fi

  jq --arg r "$repo" --arg s "$head_sha" '.[$r] = $s' "$tmp_state" >"$tmp_state.new"
  mv "$tmp_state.new" "$tmp_state"
  changed=1
done < <(jq -c '.watched[]' "$CONFIG")

if [[ "$changed" == "1" && "$DRY_RUN" != "1" ]]; then
  cp "$tmp_state" "$STATE_FILE"
  echo "STATE updated: $STATE_FILE"
elif [[ "$DRY_RUN" == "1" ]]; then
  echo "DRY-RUN: state untouched"
else
  echo "STATE unchanged"
fi
rm -f "$tmp_state"
