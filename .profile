#!/usr/bin/env bash
# the default umask is set in /etc/profile
#umask 022

if [ -n "$BASH_VERSION" ]; then
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi
# to-do: `source` all shell-agnostic files here
