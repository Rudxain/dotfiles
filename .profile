#!/bin/sh
if [ -n "${BASH_VERSION:-}" ]; then
	\. "$HOME/.bashrc"
else
	\. "$HOME/.sh/rc"
fi
