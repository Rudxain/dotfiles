#!/usr/bin/env bash

mkcd() {
	mkdir -p "$@" && cd "$_"
}

cdls() {
	cd "$@" && ls
}

# https://github.com/termux/termux-packages/discussions/8292#discussioncomment-5102555
# TLDR: hack to get some `adb shell` privileges
pm() {
	printf '%s' "$(command pm "$@" 2>&1 < /dev/null)"
}

if [[ -x "$PREFIX/bin/pkg" ]]
then # Termux
	update() {
		pkg upgrade
	}
else #
	update() {
		# for security reasons, I'm not a sudoer, so can't use `apt upgrade`
		# future: https://github.com/pypa/pip/issues/4551
		rustup upgrade
		local crates="$(cargo install --list | grep -E '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ')"
		if [[ -n "$crates" ]]; then
			cargo install $crates
		fi
	}
fi

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
targz() {
	local tmpFile="${@%/}.tar"
	tar -cvf "${tmpFile}" "${@}" || return 1

	size=$(stat -c"%s" "${tmpFile}" 2> /dev/null)

	local cmd=""
	if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
		# the .tar file is smaller than 50 MB and Zopfli is available; use it
		cmd="zopfli"
	else
		if hash pigz 2> /dev/null; then
			cmd="pigz"
		else
			cmd="gzip"
		fi
	fi

	echo "Compressing .tar ($((size / 1000)) kB) using \`${cmd}\`…"
	"${cmd}" -v "${tmpFile}" || return 1
	[ -f "${tmpFile}" ] && rm "${tmpFile}"

	zippedSize=$(stat -c"%s" "${tmpFile}.gz" 2> /dev/null)

	echo "${tmpFile}.gz ($((zippedSize / 1000)) kB) created successfully."
}

# Determine size of a file or total size of a directory
fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh
	else
		local arg=-sh
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
