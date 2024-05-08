#!/usr/bin/env bash
set -u
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc) for examples

# if not interactive, do nothing
case $- in
	*i*) ;;
		*) return;;
esac

shopt -s histappend

# this may update `$LINES` and `$COLUMNS`
shopt -s checkwinsize

# more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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

for file in ~/.{path,exports,bash_fns,aliases,bash_prompt,extra}
do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

for o in cdspell failglob; do
	shopt -s "$o"
done

for o in autocd globstar; do
	shopt -s "$o" 2> /dev/null
done
