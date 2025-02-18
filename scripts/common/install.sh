#!/bin/zsh

# install cocoapods
if ! brew list cocoapods &> /dev/null
then
    sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../brew/brew-install-package.sh cocoapods
fi

# install xcodegen
if ! brew list xcodegen &> /dev/null
then
    sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../brew/brew-install-package.sh xcodegen
fi

# SwiftGen
if ! brew list swiftgen &> /dev/null
then
    sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../brew/brew-install-package.sh swiftgen
fi

# swiftlint
if ! brew list swiftlint &> /dev/null
then
    sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../brew/brew-install-package.sh swiftlint
fi

# mockolo
if ! brew list mockolo &> /dev/null
then
    sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../brew/brew-install-package.sh mockolo
fi

# ruby
if ! brew list ruby@3.1 &> /dev/null
then
    sh $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../brew/brew-install-package.sh ruby@3.1
fi

brew link --force --overwrite ruby@3.1
export PATH="/usr/local/opt/ruby@3.1/bin:$PATH"