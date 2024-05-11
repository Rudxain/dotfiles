#!/usr/bin/env bash
# if not interactive, do nothing
case $- in
	*i*) ;;
		*) return;;
esac

for o in histappend checkwinsize cdspell failglob autocd globstar
do
	shopt -s "$o" #2>/dev/null
done

# just-in-case
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

. ~/.sh/profile
for f in ~/.bash_{fns,prompt,extra}
do
	[ -r "$f" ] && [ -f "$f" ] && . "$f"
done
