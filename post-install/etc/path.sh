# Android
[ -d /system/bin ] && PATH="$PATH:/system/bin"

[ -d "${TERMUX__PREFIX:-/usr}/local/bin" ] && \
	PATH="$PATH:${TERMUX__PREFIX:-/usr}/local/bin"
[ -n "${TERMUX__PREFIX:-}" ] && [ -d "$TERMUX__PREFIX/local/sbin" ] && \
	PATH="$PATH:$TERMUX__PREFIX/local/sbin"

export PATH
