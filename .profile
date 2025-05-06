#!/bin/sh
# default umask set in /etc/profile
#umask 022

if [ -n "${BASH_VERSION:-}" ]; then
	[ -f "$HOME/.bashrc" ] && \
	. "$HOME/.bashrc"
else
	. "$HOME/.sh/profile"
fi
