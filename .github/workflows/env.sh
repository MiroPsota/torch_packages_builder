#! /bin/bash

case $OS in
  "Linux")
    export MAX_JOBS=$(nproc)
    ;;
  "macOS")
    export CC=clang
    export CXX=clang++
    export MACOSX_DEPLOYMENT_TARGET=11.0
    export MAX_JOBS=$(sysctl -n hw.ncpu)
    if [[ $(arch) == "macos-14" ]]; then
      export ARCHFLAGS="-arch arm64"
    fi
    ;;
  "Windows")
    export MAX_JOBS=$(echo %NUMBER_OF_PROCESSORS%)
    ;;
  *)
    echo "OS not known"
    exit 1
    ;;
esac
