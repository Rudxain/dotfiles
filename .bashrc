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

# is all of this correct?
if [[ -r /etc/profile.d/bash_completion.sh ]]; then
	export BASH_COMPLETION_COMPAT_DIR=/etc/bash_completion.d
	\. /etc/profile.d/bash_completion.sh
elif ! shopt -oq posix; then
	if [[ -f /usr/share/bash-completion/bash_completion ]]; then
		\. /usr/share/bash-completion/bash_completion
	elif [[ -f /etc/bash_completion ]]; then
		\. /etc/bash_completion
	fi
fi
