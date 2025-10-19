\. ~/.config/sh/rc

# interactive
if [[ -n ${PS1:-} ]]; then
	# `-H` obsoleted by `inputrc`,
	# and `"\!"` being "\!" instead of "!" is annoying
	set +H
	shopt -s checkwinsize histappend autocd globstar nullglob

	alias ha='history -a'

	\. ~/.bash_prompt

	#shellcheck external-sources=false
	[[ -z ${BASH_COMPLETION_VERSINFO:-} && -f /usr/share/bash-completion/bash_completion ]] && \
		\. /usr/share/bash-completion/bash_completion
fi

# assert readable
if [[ -s ~/.bash_ext ]]; then
	\. ~/.bash_ext
fi
