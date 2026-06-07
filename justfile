
check:
	nix flake check

update:
	nix flake update

upgrade:
	doas nixos-rebuild switch --flake .#gentuwu

upgrade-laptop:
	doas nixos-rebuild switch --flake .#gentuwu-laptop

gc:
	doas nix-collect-garbage --delete-older-than 30d

build: upgrade

lint:
	nix flake check

clean:
	doas nix-collect-garbage -d
	nix-collect-garbage -d

sysupd:
	nix flake update && doas nixos-rebuild switch --flake .#gentuwu

sysupd-laptop:
	nix flake update && doas nixos-rebuild switch --flake .#gentuwu-laptop

devenv-shell:
	devenv shell

devenv-test:
	devenv test

devenv-update:
	devenv update

devenv-gc:
	devenv gc

search query:
	nix search nixpkgs {{query}}

search-options query:
	nix-instantiate --eval -E "(import <nixpkgs/nixos> {}).options" | grep -i {{query}}
