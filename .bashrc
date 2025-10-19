\. ~/.sh/rc

# interactive
if [[ -n ${PS1:-} ]]; then
	for o in checkwinsize histappend autocd globstar nullglob
	do
		shopt -s "$o"
	done
	unset o

	\. ~/.bash_prompt

	bc=/usr/share/bash-completion

	[[ -z ${BASH_COMPLETION_VERSINFO:-} && -f $bc/bash_completion ]] && \
		\. $bc/bash_completion

	[[ $(type -t __git_complete) != function && -f $bc/completions/git ]] && \
		\. $bc/completions/git
	[[ $(type -t __git_complete) = function ]] && __git_complete g __git_main

	unset bc
fi

# assert readable file
[[ -s ~/.bash_ext ]] && \. ~/.bash_ext
:
