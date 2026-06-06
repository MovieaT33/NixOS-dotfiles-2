# aliases
alias v := repo-version
alias V := nixos-version
alias s := sync
alias u := update
alias d := deploy
alias g := upgrade

default: upgrade

# shows the latest repository commit
repo-version:
	sudo git log -1 --oneline

# shows nixos version
nixos-version:
	nixos-version

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
