#!/bin/bash

# Load environment variables from .env
if [[ -f .env ]]; then
  export $(grep -v '^#' .env | xargs)
else
  echo "⚠️ WARNING: .env file not found! Please create one based on .env.example."
fi

# Function to run a command with an echo
recho() {
  cmd="$*"
  echo "~ Running: $cmd"
  eval "$cmd"
}
