#!/bin/sh

# Android
if [ -d /system/bin ]; then
	PATH="$PATH:/system/bin"
fi

if [ -d "${PREFIX=/usr}/local/bin" ]; then
	PATH="$PATH:${PREFIX=/usr}/local/bin"
fi

export PATH
