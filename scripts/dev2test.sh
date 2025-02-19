#!/bin/bash
source "$(dirname "$0")/common.sh"

dev2test() {
  echo "🚀 Merging 'dev' into 'test'..."

  recho git checkout dev
  recho git pull

  recho git checkout test
  recho git pull

  merge_output=$(recho git merge dev -m "Merge branch 'dev' into 'test'")

  if echo "$merge_output" | grep -q "CONFLICT"; then
    echo "⚠️ Merge conflict detected!"
    recho curl -u "o.yourpushbulletkey:" \
      -X POST https://api.pushbullet.com/v2/pushes \
      -d type=note -d title="🚨 Merge Conflict!" \
      -d body="❌ Merge had conflicts."
  else
    echo "✅ Merge successful!"
    recho git push
  fi
}

dev2test
