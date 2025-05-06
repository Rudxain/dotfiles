#!/usr/bin/env bash
#!/usr/bin/env osh
#!/bin/sh
set -eufo pipefail
shopt -s failglob #nullglob
IFS='
'
export LC_ALL=C.UTF-8

printf %s'\n' 'hello world'
