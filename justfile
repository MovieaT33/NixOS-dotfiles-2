# aliases
alias s := sync

# sync local repository with remote
sync:
	sudo git fetch --depth 1
	sudo git reset --hard origin/main
