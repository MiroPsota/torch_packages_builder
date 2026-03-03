#!/usr/bin/env python3
import re
import sys

import torch

archs = []
if hasattr(torch.cuda, "get_arch_list"):
    try:
        archs = torch.cuda.get_arch_list() or []
    except Exception:
        archs = []

if not archs and hasattr(torch, "_C") and hasattr(torch._C, "_cuda_getArchFlags"):
    try:
        flags = torch._C._cuda_getArchFlags() or ""
    except Exception:
        flags = ""
    archs = re.findall(r"(?:sm|compute)_\d+", flags)

if not archs:
    print("Could not detect CUDA arch list from installed torch.", file=sys.stderr)
    sys.exit(2)

arch_order = []
arch_has_ptx = {}
for arch in archs:
    match = re.fullmatch(r"(sm|compute)_(\d+)", arch)
    if not match:
        continue
    arch_type, digits = match.groups()
    base = f"{digits[:-1]}.{digits[-1]}"
    if base not in arch_has_ptx:
        arch_order.append(base)
        arch_has_ptx[base] = False
    if arch_type == "compute":
        arch_has_ptx[base] = True

parsed_archs = [
    f"{base}+PTX" if arch_has_ptx[base] else base
    for base in arch_order
]

if not parsed_archs:
    print("Detected CUDA arch data is empty after parsing.", file=sys.stderr)
    sys.exit(3)

print(";".join(parsed_archs))
