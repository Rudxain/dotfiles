#!/bin/sh
if [ -n "${BASH_VERSION:-}" ]; then
	\. "$HOME/.bashrc"
else
	# if not interactive, do nothing
	[ -n "$PS1" ] && \. "$HOME/.sh/profile"
fi
