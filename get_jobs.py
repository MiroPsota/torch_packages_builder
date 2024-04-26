import json
import os
from dataclasses import dataclass
from itertools import product


@dataclass
class TorchRelease:
    python_versions: tuple
    compute_platforms: tuple


LINUX_X64 = "ubuntu-20.04"
WINDOWS_X64 = "windows-2019"
MACOS_X64 = "macos-12"
MACOS_ARM64 = "macos-14"

TORCH_RELEASES = {
    "1.11.0": TorchRelease(("3.7", "3.8", "3.9", "3.10"), ("cpu", "cu102", "cu113", "rocm4.5.2")),
    "1.12.0": TorchRelease(("3.7", "3.8", "3.9", "3.10"), ("cpu", "cu102", "cu113", "cu116", "rocm5.1.1")),
    "1.12.1": TorchRelease(("3.7", "3.8", "3.9", "3.10"), ("cpu", "cu102", "cu113", "cu116", "rocm5.1.1")),
    "1.13.0": TorchRelease(("3.7", "3.8", "3.9", "3.10", "3.11"), ("cpu", "cu116", "cu117", "rocm5.2")),
    "1.13.1": TorchRelease(("3.7", "3.8", "3.9", "3.10", "3.11"), ("cpu", "cu116", "cu117", "rocm5.2")),
    "2.0.0": TorchRelease(("3.8", "3.9", "3.10", "3.11"), ("cpu", "cu117", "cu118", "rocm5.4.2")),
    "2.0.1": TorchRelease(("3.8", "3.9", "3.10", "3.11"), ("cpu", "cu117", "cu118", "rocm5.4.2")),
    "2.1.0": TorchRelease(("3.8", "3.9", "3.10", "3.11"), ("cpu", "cu118", "cu121", "rocm5.6")),
    "2.1.1": TorchRelease(("3.8", "3.9", "3.10", "3.11"), ("cpu", "cu118", "cu121", "rocm5.6")),
    "2.1.2": TorchRelease(("3.8", "3.9", "3.10", "3.11"), ("cpu", "cu118", "cu121", "rocm5.6")),
    "2.2.0": TorchRelease(("3.8", "3.9", "3.10", "3.11", "3.12"), ("cpu", "cu118", "cu121", "rocm5.7")),
    "2.2.1": TorchRelease(("3.8", "3.9", "3.10", "3.11", "3.12"), ("cpu", "cu118", "cu121", "rocm5.7")),
    "2.2.2": TorchRelease(("3.8", "3.9", "3.10", "3.11", "3.12"), ("cpu", "cu118", "cu121", "rocm5.7")),
    "2.3.0": TorchRelease(("3.8", "3.9", "3.10", "3.11", "3.12"), ("cpu", "cu118", "cu121", "rocm6.0")),
}


def add_os(oses_list: list, os_name: str, os_env_var: str):
    if os.environ[os_env_var] == "true":
        oses_list.append(os_name)


def main():
    torch_versions = os.environ["TORCH_VERSION"].split(",")
    limit_python = os.environ.get("LIMIT_PYTHON")
    if limit_python:
        limit_python = limit_python.split(",")
    limit_compute_platform = os.environ.get("LIMIT_COMPUTE_PLATFORM")
    if limit_compute_platform:
        limit_compute_platform = limit_compute_platform.split(",")

    oses_names = []
    add_os(oses_names, LINUX_X64, "LINUX_WHEELS")
    add_os(oses_names, WINDOWS_X64, "WINDOWS_WHEELS")
    add_os(oses_names, MACOS_X64, "MACOS_WHEELS")
    add_os(oses_names, MACOS_ARM64, "MACOS_WHEELS")
    if not oses_names:
        raise RuntimeError("Select at least one OS")

    jobs = []
    for torch_version in torch_versions:
        for os_name, python_version, compute_platform in product(
            oses_names, TORCH_RELEASES[torch_version].python_versions, TORCH_RELEASES[torch_version].compute_platforms
        ):
            if os_name in (MACOS_X64, MACOS_ARM64) and compute_platform != "cpu":
                continue
            if compute_platform.startswith("rocm"):
                continue

            if limit_python and python_version not in limit_python:
                continue
            if limit_compute_platform and compute_platform not in limit_compute_platform:
                continue

            if torch_version in ("1.13.0", "1.13.1") and os_name != LINUX_X64:
                continue

            # Requires VS 2017 not presented in Windows GH runner
            if compute_platform == "cu102" and os_name == WINDOWS_X64:
                continue

            tv = [int(x) for x in torch_version.split(".")]
            pv = [int(x) for x in python_version.split(".")]
            if os_name == MACOS_X64 and tv[0] == 2 and tv[1] >= 3:
                continue

            # actions/setup-python does not have Python 3.9 or less
            if os_name == MACOS_ARM64 and pv[1] <= 9:
                continue

            jobs.append({
                "os": os_name,
                "torch-version": torch_version,
                "python-version": python_version,
                "compute-platform": compute_platform,
            })

    if not jobs:
        raise RuntimeError("No jobs to do")

    strategy_matrix = {"include": jobs}
    print(json.dumps(strategy_matrix))


if __name__ == "__main__":
    main()
