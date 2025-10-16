#! /bin/bash
# https://github.com/pytorch/builder/blob/main/manywheel/build_cuda.sh
# https://github.com/pytorch/pytorch/blob/main/.ci/manywheel/build_cuda.sh
declare -A CUDA_ARCHS=(
  ["cu118"]="3.7;5.0;6.0;7.0;7.5;8.0;8.6;9.0"

  ["cu121"]="5.0;6.0;7.0;7.5;8.0;8.6;9.0"
  ["cu124"]="5.0;6.0;7.0;7.5;8.0;8.6;9.0"
  ["cu126"]="5.0;6.0;7.0;7.5;8.0;8.6;9.0"
  ["cu128"]="7.0;7.5;8.0;8.6;9.0;10.0;12.0"
  ["cu129"]="7.0;7.5;8.0;8.6;9.0;10.0;12.0+PTX"

  ["cu130"]="7.5;8.0;8.6;9.0;10.0;12.0+PTX"
)
if [[ ${TORCH_VERSION:0:3} == "2.7" ]]; then
  CUDA_ARCHS["cu128"]="7.5;8.0;8.6;9.0;10.0;12.0+PTX"
fi
export TORCH_CUDA_ARCH_LIST=${CUDA_ARCHS[$CUDA_VERSION]}
export FORCE_CUDA=1
