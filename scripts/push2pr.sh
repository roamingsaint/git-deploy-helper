#!/bin/bash
source "$(dirname "$0")/common.sh"

# Push current branch & create PR to dev
push2pr() {
  CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

  if [[ "$CURRENT_BRANCH" == "dev" || "$CURRENT_BRANCH" == "test" || "$CURRENT_BRANCH" == "main" ]]; then
    echo "❌ ERROR: Cannot create a PR from '$CURRENT_BRANCH'. Use a feature branch."
    return 1
  fi

  if [[ -z "$1" ]]; then
    echo "❌ ERROR: Commit message required."
    echo "Usage: prpush \"Your commit message\""
    return 1
  fi

  COMMIT_MSG="$1"

  recho git add .
  recho git commit -m "$COMMIT_MSG"
  recho git push --set-upstream origin "$CURRENT_BRANCH"

  REPO_URL=$(git config --get remote.origin.url | sed -E 's/.*github.com[:\/]([^\/]+\/[^.]+).*/\1/')
  PR_URL="https://github.com/$REPO_URL/compare/dev...$CURRENT_BRANCH?expand=1"

  echo "📌 Open this URL to create a PR: $PR_URL"
}

push2pr "$@"
