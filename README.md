# Nix Configuration
Welcome to my personal Nix configuration repository! Here, you'll find a collection of modular settings tailored to my systems. Feel free to explore and customize to your liking.

<!-- vim-markdown-toc GFM -->

* [Installation](#installation)
    * [1. Configure Settings](#1-configure-settings)
    * [2. Clone the Repository](#2-clone-the-repository)
    * [3. System Installation](#3-system-installation)
* [Project Structure](#project-structure)
    * [Naming Convention](#naming-convention)
    * [`shared/`](#shared)
    * [`custom/`](#custom)
    * [`devShells/`](#devshells)
    * [`hosts/`](#hosts)

<!-- vim-markdown-toc -->

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

## Project Structure

### Naming Convention
Throughout this repository, we follow a naming convention to organize configurations based on their applicability to different systems:

- **`all/`**: Configurations that apply universally to all systems.
- **`darwin/`**: Configurations specific to macOS systems.
- **`linux/`**: Configurations specific to Linux systems.

### `shared/`
This directory contains modules shared across systems. Here's a breakdown of its contents:

- **`flake/overlays/`**: Holds overlays added to the Flake, providing additional packages or customizations.
- **`flakes/`**: Contains items used directly in the Flake, such as utility functions or shared configurations.
- **`home-manager/`**: Configurations for home-manager, following the same naming convention.

### `custom/`
Houses custom packages or configurations tailored to specific needs, following the same naming convention.

### `devShells/`
Here, you'll find different Nix shells using `nix develop`. These shells provide isolated development environments for various projects.

### `hosts/`
Contains configurations specific to different systems, following the same naming convention.
