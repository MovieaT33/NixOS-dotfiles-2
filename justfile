# aliases
alias s := sync

default: upgrade

# sync local repository with remote
sync:
	sudo git fetch --depth 1
	sudo git reset --hard origin/main

# update flake.lock to the latest version
update:
	sudo nix flake update

# deploy configuration with current profile
deploy:
	sudo nixos-rebuild switch --flake .

upgrade: sync update deploy
