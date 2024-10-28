# Torch Packages Compiler Repository

This repository serves as a comprehensive toolset for building and indexing PyTorch-based packages with custom ops. It includes two primary GitHub workflows:

1. **PyTorch Packages Builder Workflow:**
   - Automates the building of PyTorch-based packages with custom ops on common architectures.
   - Publishes the built packages on GitHub releases.

2. **PEP 503 Compliant Package Index Builder Workflow:**
   - Creates a PEP 503 compliant package index.
   - Publishes the index using GitHub Pages for seamless integration with pip.

## Usage with Pip

### Using the Entire Package Index

To utilize the complete package index from this repository, add the following to your `pip install` command:

```bash
pip install --extra-index-url https://miropsota.github.io/torch_packages_builder <your package list>
```

### Using Specific Package Links

If you only need links for specific packages, add the following to your `pip install` command:

```bash
pip install --find-links https://miropsota.github.io/torch_packages_builder/<pep 503 normalized name> <your package list>
```

For example:

```bash
pip install --find-links https://miropsota.github.io/torch_packages_builder/detectron2/ <your package list>
```

### Local Installation

You can also download a package and install it locally:

```bash
pip install <abs or rel path>
pip install --find-links <abs or rel dir path> <rel path of the package with respect to the directory>
```

Make sure to include the full version, including the local version identifier (part after `+`). The repository follows this version template:

```bash
<package_name>-<version>+<OPTIONAL_commit_hash>pt<PyTorch_version><compute_platform>
```

Where `<compute_platform>` is, as in PyTorch, one of `cpu`, `cu<CUDA_version>`, `rocm<ROCM_version>`.

### Example Package Install Lines

```bash
detectron2==0.6+864913fpt1.11.0cpu
pytorch3d==0.7.6+pt2.2.1cu121
```

## Supported combinations

Tested with PyTorch `1.11.0` - `2.5.0` and their respective compute platforms and supported OSes, with an exception for `cu102` on Windows (no VS 2017 on the GH `windows-2019` runner), and the `rocm` platform.

## Pitfalls

- **No Support for Pip Cache:**
  `pip` relies on http cache, and GitHub generates on-the-fly redirections for release links, so they are probably not playing nicely together.

## Credits

A huge thanks to <https://github.com/rusty1s/pytorch_cluster>
