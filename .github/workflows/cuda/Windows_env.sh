#! /bin/bash
source "$(dirname "${BASH_SOURCE[0]}")/common_env.sh"

CUDA_SHORT=${CUDA_VERSION:2:2}.${CUDA_VERSION:4:1}
export CUDA_HOME="/c/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v$CUDA_SHORT"
export PATH=$CUDA_HOME/bin:$PATH

for item in "cu118" "cu121"; do
  if [ "$CUDA_VERSION" == "$item" ]; then
    export NVCC_APPEND_FLAGS='--allow-unsupported-compiler -D_ALLOW_COMPILER_AND_STL_VERSION_MISMATCH'
  fi
done
