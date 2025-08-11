#! /bin/bash

set -eu -o pipefail

SCRIPT_DIR=${BASH_SOURCE%/*}

if [[ $REPO == "facebookresearch/pytorch3d" ]] && [[ $OS == "Windows" ]]; then
  if [[ $COMPUTE_PLATFORM == "cu118" ]]; then
    CUB_VERSION="1.17.2"
    mkdir cub
    curl -L https://github.com/NVIDIA/cub/archive/${CUB_VERSION}.tar.gz | tar -xzf - --strip-components=1 --directory cub
    echo "CUB_HOME=$PWD/cub" >> "$GITHUB_ENV"
  fi
  if { [[ $COMPUTE_PLATFORM == "cu126" ]] || [[ $COMPUTE_PLATFORM == "cu128" ]] || [[ $COMPUTE_PLATFORM == "cu129" ]]; } \
    && [[ $(git describe --tags --exact-match) == "V0.7.8" ]]; then
    patch -p0 < "$SCRIPT_DIR"/package_specific/pytorch_win_cuda.patch
  fi
fi

if [[ $REPO == "facebookresearch/fairseq" ]]; then
  pip install cython
  patch -p0 < "$SCRIPT_DIR"/package_specific/fairseq_cub.patch
fi

if [[ $REPO == "NVlabs/tiny-cuda-nn" ]]; then
  source "$SCRIPT_DIR"/.github/workflows/cuda/${OS}_env.sh
  echo "LIBRARY_PATH=/usr/local/cuda/lib64/stubs" >> "$GITHUB_ENV"
  echo "TCNN_CUDA_ARCHITECTURES=${TORCH_CUDA_ARCH_LIST}" | sed "s/\(\.\|\+PTX\)//g" >> "$GITHUB_ENV"
  patch -p0 < "$SCRIPT_DIR"/package_specific/tiny_cuda_nn.patch
fi
