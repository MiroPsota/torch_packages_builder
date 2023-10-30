#! /bin/bash

SCRIPT_DIR=${BASH_SOURCE%/*}

if [[ $REPO == "facebookresearch/Mask2Former" ]] \
  && [[ $COMPUTE_PLATFORM == "cpu" ]]; then
  patch -p0 < "$SCRIPT_DIR"/package_specific/Mask2Former_cpu.patch
fi

if [[ $REPO == "rusty1s/pytorch_cluster" ]] \
  && [[ $OS == "Windows" ]] \
  && [[ ${TORCH_VERSION:0:4} == "1.12" ]] \
  && [[ $COMPUTE_PLATFORM == "cu116" ]]; then
  # Fixes https://github.com/facebookresearch/pytorch3d/issues/1024
  TORCH_PYBIND_DIR="$Python_ROOT_DIR/lib/site-packages/torch/include/pybind11"
  patch -d "$TORCH_PYBIND_DIR" < "$SCRIPT_DIR"/package_specific/torch_pybind_cast_h.patch
fi
