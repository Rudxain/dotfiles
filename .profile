#!/bin/sh
# default umask set in /etc/profile
#umask 022

if [ -n "$BASH_VERSION" ]; then
	[ -f "$HOME/.bashrc" ] && \
	. "$HOME/.bashrc"
else
	# If I were to unconditionally source `.sh/profile`,
	# I would have to un-source it from `.bash_profile`,
	# and rename all Bash startup-files
	# to force Bash to source `.profile` instead.
	# The problem is, users (including myself)
	# would have to rm all Bash startup-files too.
	. "$HOME/.sh/profile"
	# A possible solution to the previous problem,
	# is to inline `.sh/profile` into `.profile` and
	# make `.bash_profile` source that instead.
	# This doesn't seem to have any cons, only pros,
	# such as making `.profile` fully POSIX-compliant
	# and (mostly) shell-agnostic
fi
