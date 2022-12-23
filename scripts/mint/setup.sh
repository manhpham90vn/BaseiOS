#!/bin/sh

source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../common/version.sh

cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/../../

mkdir -p Mints/{lib,bin}

export MINT_PATH=Mints/lib 
export MINT_LINK_PATH=Mints/bin
export PATH=$PATH:$(pwd)/Mints/bin