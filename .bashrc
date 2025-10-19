\. ~/.sh/rc

# interactive
if [[ -n ${PS1:-} ]]; then
	shopt -s checkwinsize histappend autocd globstar nullglob

	alias ha='history -a'

	\. ~/.bash_prompt

	#shellcheck external-sources=false
	[[ -z ${BASH_COMPLETION_VERSINFO:-} && -f /usr/share/bash-completion/bash_completion ]] && \
		\. /usr/share/bash-completion/bash_completion
fi

# assert readable
[[ -s ~/.bash_ext ]] && \. ~/.bash_ext
:
