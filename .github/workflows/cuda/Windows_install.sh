#! /bin/bash

declare -A CUDA_LINKS=(
  ["cu102"]="https://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_441.22_win10.exe"

  ["cu110"]="https://developer.download.nvidia.com/compute/cuda/11.0.3/local_installers/cuda_11.0.3_451.82_win10.exe"
  ["cu111"]="https://developer.download.nvidia.com/compute/cuda/11.1.1/local_installers/cuda_11.1.1_456.81_win10.exe"
  ["cu112"]="https://developer.download.nvidia.com/compute/cuda/11.2.2/local_installers/cuda_11.2.2_461.33_win10.exe"
  ["cu113"]="https://developer.download.nvidia.com/compute/cuda/11.3.1/local_installers/cuda_11.3.1_465.89_win10.exe"
  ["cu114"]="https://developer.download.nvidia.com/compute/cuda/11.4.4/local_installers/cuda_11.4.4_472.50_windows.exe"
  ["cu115"]="https://developer.download.nvidia.com/compute/cuda/11.5.2/local_installers/cuda_11.5.2_496.13_windows.exe"
  ["cu116"]="https://developer.download.nvidia.com/compute/cuda/11.6.2/local_installers/cuda_11.6.2_511.65_windows.exe"
  ["cu117"]="https://developer.download.nvidia.com/compute/cuda/11.7.1/local_installers/cuda_11.7.1_516.94_windows.exe"
  ["cu118"]="https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda_11.8.0_522.06_windows.exe"

  ["cu120"]="https://developer.download.nvidia.com/compute/cuda/12.0.1/local_installers/cuda_12.0.1_528.33_windows.exe"
  ["cu121"]="https://developer.download.nvidia.com/compute/cuda/12.1.1/local_installers/cuda_12.1.1_531.14_windows.exe"
  ["cu122"]="https://developer.download.nvidia.com/compute/cuda/12.2.2/local_installers/cuda_12.2.2_537.13_windows.exe"
  ["cu123"]="https://developer.download.nvidia.com/compute/cuda/12.3.2/local_installers/cuda_12.3.2_546.12_windows.exe"
  ["cu124"]="https://developer.download.nvidia.com/compute/cuda/12.4.1/local_installers/cuda_12.4.1_551.78_windows.exe"
  ["cu125"]="https://developer.download.nvidia.com/compute/cuda/12.5.1/local_installers/cuda_12.5.1_555.85_windows.exe"
  ["cu126"]="https://developer.download.nvidia.com/compute/cuda/12.6.0/local_installers/cuda_12.6.0_560.76_windows.exe"
)
CUDA_LINK=${CUDA_LINKS[$CUDA_VERSION]}

CUDA_SHORT=${CUDA_VERSION:2:2}.${CUDA_VERSION:4:1}
curl -k -L $CUDA_LINK --output _cuda_installer.exe
PowerShell -Command "Start-Process -FilePath \"_cuda_installer.exe\" -ArgumentList \"-s nvcc_${CUDA_SHORT} cublas_dev_${CUDA_SHORT} cudart_${CUDA_SHORT} cufft_dev_${CUDA_SHORT} curand_dev_${CUDA_SHORT} cusolver_dev_${CUDA_SHORT} cusparse_dev_${CUDA_SHORT} thrust_${CUDA_SHORT} npp_dev_${CUDA_SHORT} nvrtc_dev_${CUDA_SHORT} nvml_dev_${CUDA_SHORT}\" -Wait -NoNewWindow"
rm _cuda_installer.exe
