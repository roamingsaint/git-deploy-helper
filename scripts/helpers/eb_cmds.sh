#!/bin/bash

# Start Elastic Beanstalk test environment
ebstart-test() {
  if [[ -z "$EB_TEST_ENV_NAME" ]]; then
    echo "❌ ERROR: 'EB_TEST_ENV_NAME' is not set in .env"
    return 1
  fi
  recho aws elasticbeanstalk update-environment --environment-name "$EB_TEST_ENV_NAME" --option-settings Namespace=aws:autoscaling:asg,OptionName=MinSize,Value=1
  echo "✅ Elastic Beanstalk test environment '$EB_TEST_ENV_NAME' started."
}

# Pause Elastic Beanstalk test environment
ebpause-test() {
  if [[ -z "$EB_TEST_ENV_NAME" ]]; then
    echo "❌ ERROR: 'EB_TEST_ENV_NAME' is not set in .env"
    return 1
  fi
  recho aws elasticbeanstalk update-environment --environment-name "$EB_TEST_ENV_NAME" --option-settings Namespace=aws:autoscaling:asg,OptionName=MinSize,Value=0
  echo "✅ Elastic Beanstalk test environment '$EB_TEST_ENV_NAME' paused."
}
