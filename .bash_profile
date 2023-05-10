#!/usr/bin/env bash
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc) for examples

# If not running interactively, don't do anything
case $- in
	*i*) ;;
		*) return;;
esac

shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# load the shell dotfiles, and then some:
# - ~/.path can be used to extend `$PATH`.
# - ~/.extra can be used for other settings you don't want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,bash_functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# autocorrect typos in path names when using `cd`.
# ?
for option in cdspell failglob; do
	shopt -s "$option"
done

# enable some Bash4 features when possible:
# - `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# - recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh
