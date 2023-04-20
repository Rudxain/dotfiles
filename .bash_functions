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

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
function getcertnames() {
	if [ -z "${1}" ]; then
		echo "ERROR: No domain specified.";
		return 1;
	fi;

	local domain="${1}";
	echo "Testing ${domain}…";
	echo ""; # newline

	local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
		| openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1);

	if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
		local certText=$(echo "${tmp}" \
			| openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
			no_serial, no_sigdump, no_signame, no_validity, no_version");
		echo "Common Name:";
		echo ""; # newline
		echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//" | sed -e "s/\/emailAddress=.*//";
		echo ""; # newline
		echo "Subject Alternative Name(s):";
		echo ""; # newline
		echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
			| sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2;
		return 0;
	else
		echo 'ERROR: Certificate not found.';
		return 1;
	fi;
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
	head "-c$len" /dev/urandom | xxd -p -c256 # I wish there was a c0 (unlimited) option
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