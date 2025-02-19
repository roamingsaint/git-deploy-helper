#!/bin/bash
source "$(dirname "$0")/common.sh"

PAGE_SIZE=10
OFFSET=0

deploy2prod() {
  while true; do
    echo "📂 Fetching latest .zip files from S3..."

    mapfile -t FILES < <(aws s3 ls s3://"$EB_BUCKET_NAME"/ | grep -E '[0-9]+-ms_v3_pkg\.zip$' | sort -r -k1,2)
    TOTAL_FILES=${#FILES[@]}

    if [[ $TOTAL_FILES -eq 0 ]]; then
      echo "❌ No .zip files found!"
      return 1
    fi

    END_INDEX=$((OFFSET + PAGE_SIZE))
    if [[ $END_INDEX -gt $TOTAL_FILES ]]; then
      END_INDEX=$TOTAL_FILES
    fi

    echo "📋 Showing files ${OFFSET} to $((END_INDEX - 1)) of $TOTAL_FILES:"
    for i in $(seq $OFFSET $((END_INDEX - 1))); do
      FILE_INFO="${FILES[$i]}"
      FILE_DATE=$(echo "$FILE_INFO" | awk '{print $1}')
      FILE_TIME=$(echo "$FILE_INFO" | awk '{print $2}')
      FILE_NAME=$(echo "$FILE_INFO" | awk '{print $4}')
      printf "[%d] %s %s  %s\n" "$((i + 1))" "$FILE_DATE" "$FILE_TIME" "$FILE_NAME"
    done

    echo "Options:"
    echo "  (n) Next 10"
    echo "  (p) Previous 10"
    echo "  (q) Quit"
    echo "  Enter the number of the file to deploy"

    read -p "Select an option: " CHOICE

    if [[ "$CHOICE" =~ ^[0-9]+$ ]]; then
      CHOICE_INDEX=$((CHOICE - 1))
      if [[ $CHOICE_INDEX -ge 0 && $CHOICE_INDEX -lt $TOTAL_FILES ]]; then
        ZIP_FILE=$(echo "${FILES[$CHOICE_INDEX]}" | awk '{print $4}')
        echo "✅ Selected: $ZIP_FILE"
        break
      else
        echo "⚠️ Invalid selection."
      fi
    elif [[ "$CHOICE" == "n" ]]; then
      OFFSET=$((OFFSET + PAGE_SIZE))
    elif [[ "$CHOICE" == "p" ]]; then
      OFFSET=$((OFFSET - PAGE_SIZE))
      if [[ $OFFSET -lt 0 ]]; then OFFSET=0; fi
    elif [[ "$CHOICE" == "q" ]]; then
      return 0
    else
      echo "⚠️ Invalid input."
    fi
  done

  echo "🚀 Deploying $ZIP_FILE to $EB_PROD_ENV_NAME..."
  recho aws elasticbeanstalk update-environment --environment-name "$EB_PROD_ENV_NAME" --version-label "$ZIP_FILE"

  echo "✅ Deployment complete!"
}

deploy2prod
