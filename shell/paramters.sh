#!/bin/bash
set -eu
printf "The shell\`s pid is %s\n" "$$"
printf "The shell\`s last run process pid is %s\n" "$!"
printf "The shell\`s result code is %s\n" "$?"
printf "The shell\`s set cmd flag is %s\n" "$-"
printf "The shell\`s all params is %s\n" "$*"
printf "The shell\`s all params in multi line %s\n" "$@"
printf "The shell\`s params count num is %s\n" "$#"
printf "The shell file name is %s\n" "$0"
printf "Use $'n' to get the param, for the first one is $'1' %s\n" "$1"
