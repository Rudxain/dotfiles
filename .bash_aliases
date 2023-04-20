#!/usr/bin/env bash
# see /usr/share/doc/bash-doc/examples in the bash-doc package

# reload the shell that's currently running on the terminal
alias reload='exec ${SHELL} -l'
# for some reason, this dupes `/system/bin` in $PATH

alias adbsh='adb shell'

# the only thing Windows did right /j
alias cls=clear

# prints raw text strings, unlike `echo`
alias log="printf '%s\n'"

alias ...='cd ../..'
alias ~='cd ~'
alias -- -='cd -'

# shortcuts
alias dl='cd ~/downloads'
alias dexdl='cd /storage/emulated/0/Download'
# I hate Samsung, but dex is a good short name
alias dex='cd /storage/emulated/0'

# assume GNU flavor
# Android uses BSD, but perhaps Termux is more GNU?
colorflag='--color=auto'
export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls="ls $colorflag"
	alias dir="dir $colorflag"
	alias vdir="vdir $colorflag"

	# `GREP_OPTIONS="--color=auto"` is deprecated, hence these
	alias grep="grep $colorflag"
	alias fgrep="fgrep $colorflag"
	alias egrep="egrep $colorflag"
fi

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# v = verbose
alias lalfv='ls -alF'
alias lalf='ls -AlF'
alias la='ls -A'
alias lcf='ls -CF'
alias llf='ls -lF'
# list only directories
alias lsd="ls -lF | grep --color=never '^d'"

# add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# IP addresses
alias dip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip='ipconfig getifaddr en0'
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd='hexdump -C'

alias md5=md5sum
alias sha=sha1sum
alias sha8=sha256sum # 8bit = 256 states

# hide/show desktop files (useful when presenting).
# to-do: this should be implemented by moving all files to a tmp desktop,
# for portability

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# intuitive map function.
# for example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map='xargs -n1'

# one of @janmoesen's ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
	alias "${method}"="lwp-request -m '${method}'"
done

# print each PATH entry on a separate line
alias paths='echo -e ${PATH//:/\\n}'

# is `fs` fn better?
alias sizeof="stat -Lc'%s'"

# safer
alias rm='rm -Iv'