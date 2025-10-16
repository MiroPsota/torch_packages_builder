#! /bin/bash
# https://github.com/pytorch/builder/blob/main/windows/cuda*.bat
# https://github.com/pytorch/pytorch/blob/main/.ci/pytorch/windows/cuda*.bat
declare -A CUDA_ARCHS=(
  ["cu118"]="3.7+PTX;5.0;6.0;6.1;7.0;7.5;8.0;8.6;9.0"

  ["cu121"]="5.0;6.0;6.1;7.0;7.5;8.0;8.6;9.0"
  ["cu124"]="5.0;6.0;6.1;7.0;7.5;8.0;8.6;9.0"
  ["cu126"]="5.0;6.0;6.1;7.0;7.5;8.0;8.6;9.0"
  ["cu128"]="5.0;6.0;6.1;7.0;7.5;8.0;8.6;9.0;10.0;12.0"
  ["cu129"]="7.0;7.5;8.0;8.6;9.0;10.0;12.0"

  ["cu130"]="7.5;8.0;8.6;9.0;10.0;12.0"
)
if [[ ${TORCH_VERSION:0:3} == "2.8" ]]; then
  CUDA_ARCHS["cu126"]="6.1;7.0;7.5;8.0;8.6;9.0"
  CUDA_ARCHS["cu128"]="6.1;7.0;7.5;8.0;8.6;9.0;10.0;12.0"
fi
if [[ ${TORCH_VERSION:0:3} == "2.9" ]]; then
  CUDA_ARCHS["cu128"]="7.0;7.5;8.0;8.6;9.0;10.0;12.0"
fi
export TORCH_CUDA_ARCH_LIST=${CUDA_ARCHS[$CUDA_VERSION]}
export FORCE_CUDA=1

CUDA_SHORT=${CUDA_VERSION:2:2}.${CUDA_VERSION:4:1}
export CUDA_HOME="/c/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v$CUDA_SHORT"
export PATH=$CUDA_HOME/bin:$PATH

for item in "cu118" "cu121"; do
  if [ "$CUDA_VERSION" == "$item" ]; then
    export NVCC_APPEND_FLAGS='--allow-unsupported-compiler -D_ALLOW_COMPILER_AND_STL_VERSION_MISMATCH'
  fi
done
