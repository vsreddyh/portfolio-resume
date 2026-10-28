#!/usr/bin/env bash
# Fail fast when the workflow's git credential cannot push.
#
# A fine-grained PAT can read a repo and write issues while still lacking
# Contents: write. GitHub only rejects that at the receive-pack handshake, so
# without this check the failure surfaces at the very last `git push` - after
# the poller has already commented on issues, or after the sync agent has
# spent a whole run editing files.
#
# `git push --dry-run` is enough: GitHub answers the receive-pack request (the
# ref advertisement) before any object or ref update is sent. The ref name is
# throwaway so that a stale local branch cannot turn this into a
# non-fast-forward rejection.
set -euo pipefail

err="$(mktemp)"
trap 'rm -f "$err"' EXIT
ref="refs/heads/ci/preflight-${GITHUB_RUN_ID:-$$}"

if git push --dry-run origin "HEAD:$ref" 2>"$err"; then
  echo "ok: credential can push to origin"
  exit 0
fi

{
  echo "error: this workflow's credential cannot push to this repository."
  echo "       It can read the repo and write issues, but is missing"
  echo "       Contents: Read and write, so git push returns 403."
  echo "       Replace REPO_SYNC_TOKEN with a PAT that has it, then re-run."
  echo "--- git push --dry-run output ---"
  sed 's/^/  /' "$err"
} >&2
exit 1
