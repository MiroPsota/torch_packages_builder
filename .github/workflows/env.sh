#! /bin/bash

export MAX_JOBS=${MAX_JOBS:-4}

if [[ $OS == "macOS" ]]; then
    export CC=clang
    export CXX=clang++
    export MACOSX_DEPLOYMENT_TARGET=11.0
    if [[ $(arch) == "macos-14" ]]; then
      export ARCHFLAGS="-arch arm64"
    fi
fi
