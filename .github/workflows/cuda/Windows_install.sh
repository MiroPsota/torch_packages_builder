#! /bin/bash

declare -A CUDA_LINKS=(
  ["cu118"]="https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda_11.8.0_522.06_windows.exe"

  ["cu121"]="https://developer.download.nvidia.com/compute/cuda/12.1.1/local_installers/cuda_12.1.1_531.14_windows.exe"
  ["cu124"]="https://developer.download.nvidia.com/compute/cuda/12.4.1/local_installers/cuda_12.4.1_551.78_windows.exe"
  ["cu126"]="https://developer.download.nvidia.com/compute/cuda/12.6.3/local_installers/cuda_12.6.3_561.17_windows.exe"
  ["cu128"]="https://developer.download.nvidia.com/compute/cuda/12.8.1/local_installers/cuda_12.8.1_572.61_windows.exe"
  ["cu129"]="https://developer.download.nvidia.com/compute/cuda/12.9.1/local_installers/cuda_12.9.1_576.57_windows.exe"
)
CUDA_LINK=${CUDA_LINKS[$CUDA_VERSION]}

CUDA_SHORT=${CUDA_VERSION:2:2}.${CUDA_VERSION:4:1}
curl -k -L $CUDA_LINK --output _cuda_installer.exe
PowerShell -Command "Start-Process -FilePath \"_cuda_installer.exe\" -ArgumentList \"-s nvcc_${CUDA_SHORT} cublas_dev_${CUDA_SHORT} cudart_${CUDA_SHORT} cufft_dev_${CUDA_SHORT} curand_dev_${CUDA_SHORT} cusolver_dev_${CUDA_SHORT} cusparse_dev_${CUDA_SHORT} thrust_${CUDA_SHORT} npp_dev_${CUDA_SHORT} nvrtc_dev_${CUDA_SHORT} nvml_dev_${CUDA_SHORT}\" -Wait -NoNewWindow"
rm _cuda_installer.exe
