#!/bin/bash

# Determine the path of the git-deploy-helper project
GIT_DEPLOY_HELPER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$GIT_DEPLOY_HELPER_DIR/helpers/eb_cmds.sh"

# Load .env only if inside a Git project
if git rev-parse --is-inside-work-tree &>/dev/null; then
  if [[ -f "$(pwd)/.env" ]]; then
    export $(grep -v '^#' "$(pwd)/.env" | xargs)
  else
    echo "⚠️ WARNING: .env file not found in $(pwd). Please create one based on .env.example."
  fi
fi

# Function to run a command with an echo
recho() {
  cmd="$*"
  echo "~ Running: $cmd"
  eval "$cmd"
}
