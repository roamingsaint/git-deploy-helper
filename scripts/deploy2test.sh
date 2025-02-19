#!/bin/bash
source "$(dirname "$0")/common.sh"

deploy2test() {
  echo "🚀 Deploying 'test' branch to Elastic Beanstalk (mstest)..."

  recho git checkout test
  recho git pull

  TIMESTAMP=$(date +%s%3N)
  ZIP_FILE="${TIMESTAMP}-ms_v3_pkg.zip"

  recho aws s3 cp ms_v3_pkg.zip s3://"$EB_BUCKET_NAME"/"$ZIP_FILE"

  recho aws elasticbeanstalk create-application-version \
    --application-name "MovieSaints" \
    --version-label "$ZIP_FILE" \
    --source-bundle "S3Bucket=$EB_BUCKET_NAME,S3Key=$ZIP_FILE"

  recho aws elasticbeanstalk update-environment \
    --environment-name "$TEST_ENV_NAME" \
    --version-label "$ZIP_FILE"

  echo "✅ Deployment to test complete!"
}

deploy2test
