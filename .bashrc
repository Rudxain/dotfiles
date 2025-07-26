# if not interactive, do nothing
case $- in
	*i*) ;;
	*) return;;
esac

for o in checkwinsize histappend autocd globstar nullglob
do
	shopt -s "$o"
done
unset o

\. ~/.sh/profile
for f in ~/.bash_{aliases,ext}
do
	[[ -f $f ]] && \. "$f"
done
unset f

bc="${TERMUX__PREFIX:-/usr}/share/bash-completion"

[[ -f $bc/bash_completion ]] && \
	\. "$bc/bash_completion"

if [[ -f $bc/completions/git ]]; then
	\. "$bc/completions/git"
	__git_complete g __git_main
fi

unset bc

FNM_PATH=~/.local/share/fnm
if [[ -d $FNM_PATH ]]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env)"
fi
