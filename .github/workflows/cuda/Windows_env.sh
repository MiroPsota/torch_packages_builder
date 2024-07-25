#! /bin/bash

CUDA_SHORT=${CUDA_VERSION:2:2}.${CUDA_VERSION:4:1}
export CUDA_HOME="/c/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v$CUDA_SHORT"
export PATH=$CUDA_HOME/bin:$PATH

# https://github.com/pytorch/builder/blob/main/windows/cuda*.bat
declare -A CUDA_ARCHS=(
  ["cu102"]="3.7+PTX;5.0;6.0;6.1;7.0;7.5"

  ["cu113"]="3.7+PTX;5.0;6.0;6.1;7.0;7.5;8.0;8.6"
  ["cu115"]="3.7+PTX;5.0;6.0;6.1;7.0;7.5;8.0;8.6"
  ["cu116"]="3.7+PTX;5.0;6.0;6.1;7.0;7.5;8.0;8.6"
  ["cu117"]="3.7+PTX;5.0;6.0;6.1;7.0;7.5;8.0;8.6"
  ["cu118"]="3.7+PTX;5.0;6.0;6.1;7.0;7.5;8.0;8.6;9.0"

  ["cu121"]="5.0;6.0;6.1;7.0;7.5;8.0;8.6;9.0"
  ["cu124"]="5.0;6.0;6.1;7.0;7.5;8.0;8.6;9.0"
)
export TORCH_CUDA_ARCH_LIST=${CUDA_ARCHS[$CUDA_VERSION]}
export FORCE_CUDA=1
