#! /bin/bash

if [[ $CUDA_VERSION == "cu102" ]]; then
  CUDA_SHORT=${CUDA_VERSION:2:2}.${CUDA_VERSION:4:1}
  export CUDA_HOME=/usr/local/cuda-$CUDA_SHORT
  export CC=/usr/bin/gcc-7
  export CXX=/usr/bin/g++-7
fi

# https://github.com/pytorch/builder/blob/main/manywheel/build_cuda.sh
# https://github.com/pytorch/pytorch/blob/main/.ci/manywheel/build_cuda.sh
declare -A CUDA_ARCHS=(
  ["cu102"]="3.7;5.0;6.0;7.0"

  ["cu113"]="3.7;5.0;6.0;7.0;7.5;8.0;8.6"
  ["cu115"]="3.7;5.0;6.0;7.0;7.5;8.0;8.6"
  ["cu116"]="3.7;5.0;6.0;7.0;7.5;8.0;8.6"
  ["cu117"]="3.7;5.0;6.0;7.0;7.5;8.0;8.6"
  ["cu118"]="3.7;5.0;6.0;7.0;7.5;8.0;8.6;9.0"

  ["cu121"]="5.0;6.0;7.0;7.5;8.0;8.6;9.0"
  ["cu124"]="5.0;6.0;7.0;7.5;8.0;8.6;9.0"
  ["cu126"]="5.0;6.0;7.0;7.5;8.0;8.6;9.0+PTX"
)
export TORCH_CUDA_ARCH_LIST=${CUDA_ARCHS[$CUDA_VERSION]}
export FORCE_CUDA=1
