#!/bin/bash

set -ex

VERSION="$(git --git-dir=./.git describe --abbrev=8)"
PLATFORM="win-i386"
BINEXT=".exe"

## Run tests

#stack clean
#./tests/run-tests.sh # TODO !!!


## Build binaries

stack build

function build-flavor() {
    FLAVOR="$1"
    BUILD="elm-format-short-${FLAVOR}-${VERSION}-${PLATFORM}"
    mkdir -p dist/package-scripts
    ELM_FORMAT="$(stack path --local-install-root)/bin/elm-format-short-${FLAVOR}${BINEXT}"
    cp "$ELM_FORMAT" "dist/package-scripts/elm-format-short${BINEXT}"
    tar zcvf "$BUILD".tgz -C dist/package-scripts "elm-format-short${BINEXT}"
}

build-flavor 0.18
build-flavor 0.17
