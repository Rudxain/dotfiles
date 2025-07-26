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

[[ -f /usr/share/bash-completion/bash_completion ]] && \
	\. /usr/share/bash-completion/bash_completion
