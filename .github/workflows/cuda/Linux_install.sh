#! /bin/bash

distro=ubuntu2204
arch=x86_64
wget https://developer.download.nvidia.com/compute/cuda/repos/$distro/$arch/cuda-keyring_1.1-1_all.deb -O cuda-keyring.deb
sudo dpkg -i cuda-keyring.deb

CUDA_SHORT=${CUDA_VERSION:2:2}-${CUDA_VERSION:4:1}
sudo apt update
sudo apt install --no-install-recommends cuda-nvcc-$CUDA_SHORT cuda-libraries-dev-$CUDA_SHORT
