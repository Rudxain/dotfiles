\. ~/.sh/rc

# interactive
if [[ -n ${PS1:-} ]]; then
	shopt -s checkwinsize histappend autocd globstar nullglob

	alias ha='history -a'

	\. ~/.bash_prompt

	bc=/usr/share/bash-completion

	[[ -z ${BASH_COMPLETION_VERSINFO:-} && -f $bc/bash_completion ]] && \
		\. $bc/bash_completion

	[[ $(type -t __git_complete) != function && -f $bc/completions/git ]] && \
		\. $bc/completions/git
	[[ $(type -t __git_complete) = function ]] && __git_complete g __git_main

	unset bc
fi

# assert readable
[[ -s ~/.bash_ext ]] && \. ~/.bash_ext
:
