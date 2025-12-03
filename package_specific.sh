#! /bin/bash

set -eu -o pipefail

SCRIPT_DIR=${BASH_SOURCE%/*}

if [[ $REPO == "facebookresearch/pytorch3d" ]]; then
  if [[ $COMPUTE_PLATFORM == "cu118" ]] && [[ $OS == "Windows" ]]; then
    CUB_VERSION="1.17.2"
    mkdir cub
    curl -L https://github.com/NVIDIA/cub/archive/${CUB_VERSION}.tar.gz | tar -xzf - --strip-components=1 --directory cub
    echo "CUB_HOME=$PWD/cub" >> "$GITHUB_ENV"
  fi
  if [[ $OS == "Linux" ]] && [[ $COMPUTE_PLATFORM == "cu130" ]]; then
    echo "NVCC_FLAGS=-static-global-template-stub=false" >> "$GITHUB_ENV"
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

if [[ $REPO == "Dao-AILab/flash-attention" ]]; then
  pip install psutil

  echo FLASH_ATTENTION_FORCE_BUILD=TRUE >> "$GITHUB_ENV"
  source "$SCRIPT_DIR"/.github/workflows/cuda/${OS}_env.sh
  echo "FLASH_ATTN_CUDA_ARCHS=${TORCH_CUDA_ARCH_LIST}" | sed "s/\(\.\|\+PTX\)//g" >> "$GITHUB_ENV"

  echo NVCC_THREADS=1 >> "$GITHUB_ENV"
  if [[ $OS == "Linux" ]]; then
    echo MAX_JOBS=2 >> "$GITHUB_ENV"
  elif [[ $OS == "Windows" ]]; then
    echo MAX_JOBS=3 >> "$GITHUB_ENV"
  fi

  patch -p0 < "$SCRIPT_DIR"/package_specific/flash_attention.patch
fi
