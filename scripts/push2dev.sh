#!/bin/bash
source "$(dirname "$0")/common.sh"

# Push directly to dev (not recommended use prpush instead)
push2dev() {
  recho git checkout dev
  recho git pull
  
  # Require a commit message
  if [[ -z "$1" ]]; then
    echo "❌ ERROR: Commit message is required."
    echo "Usage: push2dev \"Your commit message here\""
    return 1
  fi
  COMMIT_MSG="\"$1\""
  
  recho git add .
  recho git commit -m "$COMMIT_MSG"
  recho git push
}

push2dev "$@"