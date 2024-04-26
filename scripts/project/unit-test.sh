#!/bin/sh

if ! bundle exec fastlane version &> /dev/null
then
    sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh bundle install
fi

bundle exec fastlane unittest --env debug