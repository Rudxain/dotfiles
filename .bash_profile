#!/usr/bin/env bash
# if not interactive, do nothing
case $- in
	*i*) ;;
		*) return;;
esac

# `checkwinsize` is default on Bash 5
# https://lists.gnu.org/archive/html/bug-bash/2019-01/msg00063.html
for o in histappend cdspell autocd failglob globstar #nocaseglob
do
	shopt -s "$o"
done
unset o

. ~/.sh/profile
for f in ~/.bash_{aliases,fns,prompt,extra}
do
	[ -r "$f" ] && [ -f "$f" ] && . "$f"
done
unset f

# to-do: use `PREFIX`
if [ -r "/etc/profile.d/bash_completion.sh" ]; then
	export BASH_COMPLETION_COMPAT_DIR="/etc/bash_completion.d"
	source "/etc/profile.d/bash_completion.sh"
fi
# just-in-case
if ! shopt -oq posix; then
	if [ -f $PREFIX/share/bash-completion/bash_completion ]; then
		. $PREFIX/share/bash-completion/bash_completion
	# to-do: use `PREFIX`
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi
