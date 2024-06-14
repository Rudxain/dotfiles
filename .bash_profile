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

# I'm unsure if this whole block is correct
if [ -r "${PREFIX:-}/etc/profile.d/bash_completion.sh" ]; then
	export BASH_COMPLETION_COMPAT_DIR="${PREFIX:-}/etc/bash_completion.d"
	. "${PREFIX:-}/etc/profile.d/bash_completion.sh"
elif ! shopt -oq posix; then
	if [ -f "${PREFIX:-/usr}/share/bash-completion/bash_completion" ]; then
		. "${PREFIX:-/usr}/share/bash-completion/bash_completion"
	elif [ -f "${PREFIX:-}/etc/bash_completion" ]; then
		. "${PREFIX:-}/etc/bash_completion"
	fi
fi
