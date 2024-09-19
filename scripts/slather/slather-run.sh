#!/bin/zsh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/slather-cmd.sh

if ! bundle exec $SLATHER_CMD version &> /dev/null
then
    sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh bundle install
fi

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "Run slather"

bundle exec $SLATHER_CMD

sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../logs/info.sh "Done run slather"