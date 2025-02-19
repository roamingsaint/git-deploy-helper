#!/bin/bash

# Load helper functions
source "$(dirname "$0")/helpers/eb_cmds.sh"

# Load environment variables from a .env file located in the current project directory
if [[ -f .env ]]; then
  export $(grep -v '^#' .env | xargs)
else
  echo "⚠️ WARNING: .env file not found in $(pwd). Please create one based on .env.example."
fi

# Function to run a command with an echo
recho() {
  cmd="$*"
  echo "~ Running: $cmd"
  eval "$cmd"
}
