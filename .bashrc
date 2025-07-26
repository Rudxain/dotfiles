\. ~/.sh/rc

# interactive
if [[ -n ${PS1:-} ]]; then
	for o in checkwinsize histappend autocd globstar nullglob
	do
		shopt -s "$o"
	done
	unset o

	# assert readable file
	[[ -s ~/.bash_aliases ]] && \. ~/.bash_aliases

	#shellcheck external-sources=false
	[[ -z ${BASH_COMPLETION_VERSINFO:-} && -f /usr/share/bash-completion/bash_completion ]] && \
		\. /usr/share/bash-completion/bash_completion
fi

# assert readable file
[[ -s ~/.bash_ext ]] && \. ~/.bash_ext
:
