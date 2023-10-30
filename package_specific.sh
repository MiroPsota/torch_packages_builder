#! /bin/bash

SCRIPT_DIR=${BASH_SOURCE%/*}

if [[ $REPO == "facebookresearch/Mask2Former" ]] \
  && [[ $COMPUTE_PLATFORM == "cpu" ]]; then
  patch -p0 < "$SCRIPT_DIR"/package_specific/Mask2Former_cpu.patch
fi
