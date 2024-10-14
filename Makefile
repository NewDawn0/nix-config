.PHONY: build rebuild install-nix patch unpatch

NIX_INSTALL_DIR := $(shell pwd)

build: patch
	@echo "Building the system configuration..."
	nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake .
	make unpatch

rebuild: patch
	@echo "Rebuilding the system configuration..."
	darwin-rebuild switch --flake .
	make unpatch

install-nix:
	@echo "Installing Nix..."
	sh <(curl -L https://nixos.org/nix/install) --daemon

patch:
	@echo "Patching some variables"
	sed -i "s|<- NIX_INSTALL_DIR ->|$(NIX_INSTALL_DIR)|g" ./shared/home-manager/all/general.nix

unpatch:
	@echo "Resetting some vars"
	sed -i "s|$(NIX_INSTALL_DIR)|<- NIX_INSTALL_DIR ->|g" ./shared/home-manager/all/general.nix
