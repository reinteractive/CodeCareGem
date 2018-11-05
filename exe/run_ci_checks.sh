#!/usr/bin/env bash

# Install needed dependencies
gem install brakeman
gem install bundler-audit

# Run checks
brakeman -A
brakeman_res=$?
bundle audit check --update
bundler_res=$?

# ignore warnings on PR/branch-triggered runs
if [ "$TRAVIS_EVENT_TYPE" = "cron" ]; then
  exit $(( $brakeman_res || $bundler_res ))
fi
