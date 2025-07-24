#! /bin/bash
# https://github.com/pytorch/builder/blob/main/manywheel/build_cuda.sh
# https://github.com/pytorch/pytorch/blob/main/.ci/manywheel/build_cuda.sh
declare -A CUDA_ARCHS=(
  ["cu117"]="3.7;5.0;6.0;7.0;7.5;8.0;8.6"
  ["cu118"]="3.7;5.0;6.0;7.0;7.5;8.0;8.6;9.0"

  ["cu121"]="5.0;6.0;7.0;7.5;8.0;8.6;9.0"
  ["cu124"]="5.0;6.0;7.0;7.5;8.0;8.6;9.0"
  ["cu126"]="5.0;6.0;7.0;7.5;8.0;8.6;9.0+PTX"
  ["cu128"]="7.5;8.0;8.6;9.0;10.0;12.0+PTX"
)
export TORCH_CUDA_ARCH_LIST=${CUDA_ARCHS[$CUDA_VERSION]}
export FORCE_CUDA=1
