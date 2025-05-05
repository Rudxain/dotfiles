#!/usr/bin/env bash
# if not interactive, do nothing
case $- in
	*i*) ;;
		*) return;;
esac

# `checkwinsize` is default on Bash 5
# https://lists.gnu.org/archive/html/bug-bash/2019-01/msg00063.html
for o in histappend cdspell autocd globstar #nocaseglob
do
	shopt -s "$o"
done
unset o

. ~/.sh/profile
for f in ~/.bash_{aliases,prompt,extra}
do
	[ -r "$f" ] && [ -f "$f" ] && . "$f"
done
unset f

# I'm unsure if this whole block is correct
if [ -r "${TERMUX__PREFIX:-}/etc/profile.d/bash_completion.sh" ]; then
	export BASH_COMPLETION_COMPAT_DIR="${TERMUX__PREFIX:-}/etc/bash_completion.d"
	. "${TERMUX__PREFIX:-}/etc/profile.d/bash_completion.sh"
elif ! shopt -oq posix; then
	if [ -f "${TERMUX__PREFIX:-/usr}/share/bash-completion/bash_completion" ]; then
		. "${TERMUX__PREFIX:-/usr}/share/bash-completion/bash_completion"
	elif [ -f "${TERMUX__PREFIX:-}/etc/bash_completion" ]; then
		. "${TERMUX__PREFIX:-}/etc/bash_completion"
	fi
fi

# NodeJS & NPM
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
# force 0 exit-code, for the previous cmd
true
