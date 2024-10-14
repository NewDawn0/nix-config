# Nix-Config

<!--toc:start-->

- [Nix-Config](#nix-config)
  - [Installation](#installation)
  - [Features & utilities](#features-utilities)
  - [Structure](#structure)
  - [Module management](#module-management) - [System & Home-manager](#system-home-manager)
  <!--toc:end-->

## Installation

- New Installation

  1. Install nix using `make install-nix` if it is not already installed
  2. Build the system configuration using `make build`
  3. (Optional) Cleanup build dependencies using `make clean`

---

- Update existing installation

  1. Rebuild the configuration using `make rebuild`

## Features & utilities

- Automatic imports & module creation: Removes code duplication and increases modularity

  - The importPath function in `lib/importPath.nix` recursively imports all `.nix` files in a given path. And generates a module for each imported nix file. Thanks to the module generation imports can easily be enabled and disabled per the Module management section described in this README. This allows for changing one hosts config whilst keeping the rest concise and modular.

- nix-dev : A dev-shell manager
  The nix-dev utility uses `nix develop` with some special arguments to make the dev-shell use the same tools as the system shell. It also makes running dev-shells much more concise.
  - NOTE: Upon rebuilding, restart your terminal session by opening up a new terminal, which is required to source `NIX_INSTALL_DIR` env var
  - EXAMPLE:
    `nix-dev run macEnv` # Runs the `shells/macEnv.nix` shell

## Structure

- `./shells/` for all devShells accessible by `nix-dev`
- `./hosts/` for all different hosts the system supports
  - To support a new system create a new directory with the hostname of the system and create a `default.nix` with the necessary modules
- `./lib` utility functions such as `importPath` and `mkShells` and overlays for the system used by this config
- `./shared/` For shared functionality across hosts and system

## Module management

Module options are always generated using `path-to-file + Cfg.enable`
meaning the file `./shared/system/all/fonts.nix` has the option `all-fontsCfg.enable = true;`
Note that the directory on which `importPath` is called is not in the path name hence the option does not have the suffix `shared-system-`

---

**System & Home-manager:**

- System:

  > System modules are always in `./shared/system/`
  > The option name is their path after `./shared/system` path, separated by dashes `-` + Cfg

  > Example: file `./shared/system/all/general.nix` produces the option `all-generalCfg.enable = true`

- Home-manager:

  > Home manager modules are always in `./shared/home-manager/`
  > The option name is their path after `./shared/home-manager/` path, separated by dashes `-`, prefixed with `hm-` and suffixed with `Cfg`

  > Example: file `./shared/home-manager/all/pkgs/rust.nix` produces the option `hm-all-pkgs-rustCfg.enable = true`
