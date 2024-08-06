# Nix Configuration

Welcome to my personal Nix configuration repository! Here, you'll find a collection of modular settings tailored to my systems. Feel free to explore and customize to your liking.

<!-- vim-markdown-toc GFM -->

* [Features](#features)
* [Installation](#installation)
    * [1. Configure Settings](#1-configure-settings)
    * [2. Clone the Repository](#2-clone-the-repository)
    * [3. System Installation](#3-system-installation)
* [Toggling Modules](#toggling-modules)
    * [Home Manager Modules](#home-manager-modules)
        * [Examples](#examples)
    * [Non-Home Manager Modules](#non-home-manager-modules)
        * [Example](#example)
* [Project Structure](#project-structure)
    * [Naming Convention](#naming-convention)
    * [`shared/`](#shared)
    * [`custom/`](#custom)
    * [`devShells/`](#devshells)
    * [`hosts/`](#hosts)

<!-- vim-markdown-toc -->

## Features

- **📦 Modular:** Designed to be highly modulear, allowing users to easily toggle modules using a consistent naming convention
- **🔁 No code duplication:** Utilizes the `shared/flake/util.nix` to reduce code rerepetitiono automatically integrate newly create Nix files into the module system
- **🗂️Organization:** Structured in a clear and logical manner, making easy to navigate and understand the configuration
- **🔧Automatic module enablement:** By default, all modules are enabled providing a comprehensive out-of-the-box configuration.
- **🌐Multi-System Support:** Through its high modularity, it can support different systems with shared modules

## Installation

### 1. Configure Settings

Before installing, customize the configuration to match your preferences. You can adjust the username, hostname, and Git credentials in the respective files:

- `flake.nix`
- `shared/home-manager/all/git.nix`

### 2. Clone the Repository

```bash
git clone https://github.com/NewDawn0/nix-config
cd nix-config
```

### 3. System Installation

Choose the appropriate command based on your operating system:

- **For macOS (Darwin) Systems:**

```bash
darwin-rebuild switch --flake .
```

- **For NixOS Systems:**

```bash
# Currently, there is no NixOS system feature available.
nixos-rebuild switch --flake .
```

Enjoy your customized Nix setup! If you have any questions or suggestions, feel free to reach out.

## Toggling Modules

To toggle modules, you have two options: for Home Manager modules and for non-Home Manager modules.

### Home Manager Modules

To toggle Home Manager modules, modify the configuration in your `./hosts/<your host>/home.nix` file using the pattern `<moduleName>Cfg.enabled = true | false`. The `./shared/home-manager/` directory is the top-level namespace.

#### Examples

- **Disable a module in the top-level namespace:**

  To disable `./shared/home-manager/all/bash.nix`, set:

  ```nix
  bashCfg.enabled = false;
  ```

- **Disable a module with multiple namespaces:**

  To disable `./shared/home-manager/all/pkgs/misc.nix`, set:

  ```nix
  pkgs-miscCfg.enabled = false;
  ```

- **Disable a module in a non-top-level namespace:**

  For modules under specific namespaces like `darwin` or `linux`, prepend the namespace.

  To disable `shared/home-manager/darwin/pkgs/macLibs.nix`, set:

  ```nix
  darwin-pkgs-macLibsCfg.enabled = false;
  ```

### Non-Home Manager Modules

For non-Home Manager modules, set the configuration in your `./hosts/<your host>/default.nix` file. The same naming principles apply.

#### Example

To disable `shared/darwin/homebrew.nix`, set:

```nix
darwin-homebrewCfg.enabled = false;
```

## Project Structure

### Naming Convention

Throughout this repository, we follow a naming convention to organize configurations based on their applicability to different systems:

- **`all/`**: Configurations that apply universally to all systems.
- **`darwin/`**: Configurations specific to macOS systems.
- **`linux/`**: Configurations specific to Linux systems.

### `shared/`

This directory contains modules shared across systems. Here's a breakdown of its contents:

- **`flake/overlays/`**: Holds overlays added to the Flake, providing packages or customizations.
- **`flakes/`**: Contains items used directly in the Flake, such as utility functions or shared configurations.
- **`home-manager/`**: Configurations for home-manager, following the same naming convention.

### `custom/`

Houses custom packages or configurations tailored to specific needs, following the same naming convention.

### `devShells/`

Here, you'll find different Nix shells using `nix develop`. These shells provide isolated development environments for different projects.

### `hosts/`

Contains configurations specific to different systems, following the same naming convention.
