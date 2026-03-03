\. ~/.config/sh/rc

# interactive
if [[ -n ${PS1:-} ]]; then
	# `-H` obsoleted by `inputrc`,
	# and `"\!"` being "\!" instead of "!" is annoying
	set +H
	shopt -s checkwinsize histappend autocd globstar nullglob

	alias ha='history -a'

	\. ~/.bash_prompt

	bc="${TERMUX__PREFIX:-/usr}/share/bash-completion"

	[[ -z ${BASH_COMPLETION_VERSINFO:-} && -f $bc/bash_completion ]] && \
		\. "$bc/bash_completion"

	[[ $(type -t _comp_cmd_cd) != function && -f $bc/completions/git ]] && \
		\. "$bc/completions/cd"
	[[ $(type -t _comp_cmd_cd) = function ]] && \
		complete -F _comp_cmd_cd -o nospace cdl cdla

	[[ $(type -t __git_complete) != function && -f $bc/completions/git ]] && \
		\. "$bc/completions/git"
	[[ $(type -t __git_complete) = function ]] && __git_complete g __git_main

	unset bc
fi

# assert readable
if [[ -s ~/.bash_ext ]]; then
	\. ~/.bash_ext
fi
