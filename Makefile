.PHONY: rebuild install 

build:
	@echo "Building the system configuration..."
	nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake .

install-nix:
	@echo "Installing Nix..."
	sh <(curl -L https://nixos.org/nix/install) --daemon

install: install-nix
	@echo "Installing config from scratch..."
