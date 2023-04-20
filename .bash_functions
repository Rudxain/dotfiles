#!/usr/bin/env bash

# create directory and enter it
function mkcd() {
	mkdir -p "$@" && cd "$_"
}

# enter dir and list contents
function cdls() {
	cd "$@" && ls
}

function update() {
	apt-get upgrade
	pkg upgrade
}

function adbpc() {
	local main_port="$1"
	local pair_port="$2"
	local key="$3" # pairing code
	adb devices # verbose debug
	adb pair "localhost:$pair_port" "$key" && \
	adb connect "localhost:$main_port"
	adb devices # verbose debug
}

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
function targz() {
	local tmpFile="${@%/}.tar";
	tar -cvf "${tmpFile}" "${@}" || return 1;

	size=$(stat -c"%s" "${tmpFile}" 2> /dev/null);

	local cmd="";
	if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
		# the .tar file is smaller than 50 MB and Zopfli is available; use it
		cmd="zopfli";
	else
		if hash pigz 2> /dev/null; then
			cmd="pigz";
		else
			cmd="gzip";
		fi;
	fi;

	echo "Compressing .tar ($((size / 1000)) kB) using \`${cmd}\`…";
	"${cmd}" -v "${tmpFile}" || return 1;
	[ -f "${tmpFile}" ] && rm "${tmpFile}";

	zippedSize=$(stat -c"%s" "${tmpFile}.gz" 2> /dev/null);

	echo "${tmpFile}.gz ($((zippedSize / 1000)) kB) created successfully.";
}

# Determine size of a file or total size of a directory
function fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* ./*;
	fi;
}

function dataurl() {
	local mimeType=$(file -b --mime-type "$1");
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8";
	fi
	echo "data:${mimeType};base64,$(base64 "$1" | tr -d '\n')";
}

# Run `dig` and display the most useful info
function digga() {
	dig +nocmd "$1" any +multiline +noall +answer;
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
	tree -aC -I '.cache|tmp|.git|target|__pycache__|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

function b16_rng() {
	local len="$1"
	# neither hexdump nor toybox xxd are appropiate for this.
	# funny enough, toybox xxd ignores "-c" when "-p" is used,
	# despite explicitly printing "-p" in its help-text
	# (unlike GNU xxd, which has the "-p" as a hidden feature, despite working perfectly)
	head "-c$len" /dev/urandom | basenc --base16 -w0
}

function b64_rng() {
	local len="$1"
	head "-c$len" /dev/urandom | base64
}

function keygen() {
	local len="$1"
	if [[ "$len" == wpa ]]
	then
		b16_rng 32 # max PSK size is 256b
		return
	fi
	if [[ "$len" == wpa_guest ]]
	then
		b16_rng 16 # guests need fast-to-type passwords
		return
	fi
	if [[ -z "$len" ]]
	then
		len=12 # good enough entropy for most cases
	fi
	b64_rng "$len"
}
