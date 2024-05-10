#!/usr/bin/env bash
# /usr/share/doc/bash/examples/startup-files

# if not interactive, do nothing
case $- in
	*i*) ;;
		*) return;;
esac

shopt -s histappend

# this may update `$LINES` and `$COLUMNS`
shopt -s checkwinsize

# no need to enable,
# if it's already enabled in /etc/bash.bashrc
# and /etc/profile sources /etc/bash.bashrc
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
	[ -r "$f" ] && [ -f "$f" ] && source "$f"
done

for o in cdspell failglob; do
	shopt -s "$o"
done

for o in autocd globstar; do
	shopt -s "$o" 2> /dev/null
done
