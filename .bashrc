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

# NodeJS & NPM
[[ -s $NVM_DIR/bash_completion ]] && \. "$NVM_DIR/bash_completion"
# force 0 exit-code, for the previous cmd
true
