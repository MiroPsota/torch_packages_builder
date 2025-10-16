#! /bin/bash

export MAX_JOBS=${MAX_JOBS:-4}

if [[ $OS == "macOS" ]]; then
    export CC=clang
    export CXX=clang++
    export MACOSX_DEPLOYMENT_TARGET=14.0
    export ARCHFLAGS="-arch arm64"
fi
