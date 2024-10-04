#!/bin/sh
echo -ne '\033c\033]0;Shattered\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/ShatteredDemo.x86_64" "$@"
