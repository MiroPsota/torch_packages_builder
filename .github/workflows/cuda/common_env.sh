#! /bin/bash

get_torch_cuda_arch_list() {
  python "$(dirname "${BASH_SOURCE[0]}")/get_torch_cuda_arch_list.py"
}

export TORCH_CUDA_ARCH_LIST="$(get_torch_cuda_arch_list)"
export FORCE_CUDA=1
