#!/usr/bin/env bash

mkcd() {
	mkdir -p "$@" && cd "$_"
}
cdls() {
	cd "$@" && ls
}

if [[ -x "$PREFIX/bin/pkg" ]]
then # Termux
	# https://github.com/termux/termux-packages/discussions/8292#discussioncomment-5102555
	# TLDR: hack to get some `adb shell` privileges
	cmd() {
		printf '%s' "$(command cmd "$@" 2>&1 < /dev/null)"
	}
	pm() {
		printf '%s' "$(command pm "$@" 2>&1 < /dev/null)"
	}
	update() {
		pkg upgrade && apt autoclean \
		&& npm update -g # for LSPs
	}
else
	update() {
		# for security reasons, I'm not a sudoer
		# future: https://github.com/pypa/pip/issues/4551
		rustup upgrade
		local -r crates="$(cargo install --list | grep -E '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ')"
		if [[ -n "$crates" ]]; then
			cargo install $crates
		fi
	}
fi

sizeof() {
	stat -Lc'%s' -- "$1"
}

# Determine size of a file or total size of a directory
fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local -r arg=-sbh
	else
		local -r arg=-sh
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@"
	else
		du $arg .[^.]* ./*
	fi
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
tre() {
	tree -aC -I '.cache|tmp|.git|target|__pycache__|node_modules' --dirsfirst "$@" | less -FRNX
}

b16_rng() {
	# Neither `hexdump` nor `toybox xxd` are appropiate for this.
	# Funnily enough, `toybox xxd` ignores "-c" when "-p" is used,
	# despite explicitly printing "-p" in its help-text,
	# unlike GNU-`xxd` which has the "-p" as a hidden feature, despite working perfectly
	head "-c$1" /dev/urandom | basenc --base16 -w0
}

b64_rng() {
	head "-c$1" /dev/urandom | base64
}

# password generator. usually meant for wifi A.P.s
keygen() {
	if [[ "$1" = wpa_main ]]
	then
		b16_rng 32 # max PSK size is 256b
		return
	fi
	if [[ "$1" = wpa_guest ]]
	then
		b16_rng 16 # guests need fast-to-type passwords
		return
	fi

	local len="$1"
	if [ -z "$len" ]
	then
		len=12 # good-enough entropy for most cases
	fi
	b64_rng "$len"
}
