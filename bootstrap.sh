#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")"

git pull origin main

do_it() {
	rsync \
		--exclude '.git/' \
		--exclude '.gitattributes' \
		--exclude 'bootstrap.sh' \
		--exclude 'README.md' \
		--exclude 'LICENSE' \
		-avh --no-perms . ~
	. ~/.bash_profile
}

if [ "$1" = '--force' ] || [ "$1" = '-f' ]; then
	do_it
else
	read -p 'This may overwrite existing files in your `$HOME` directory. Are you sure? (y/n) ' -n 1
	echo
	[[ "$REPLY" =~ ^[Yy]$ ]] && do_it
fi
unset do_it
