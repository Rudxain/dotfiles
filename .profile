#!/bin/sh
if [ -n "${BASH_VERSION:-}" ]; then
	\. "$HOME/.bashrc"
else
	\. "$HOME/.config/sh/rc"
fi
