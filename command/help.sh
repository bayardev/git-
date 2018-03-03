#!/bin/bash
### command/help.sh ###
#@DESCRIPTION: Print HELP (temporarly execute 'list' command)

function help.command_help()
{
    local filename="$1"
    local output
    output=$(sed -nr '/^#@HELP:/ s/.*#@HELP:([^"]+).*/\1/p' "$filename")
    if [[ -z "$output" ]]; then
        output=$(printer.warning "No help found for command '$(basename "$filename" .sh)'")
    else
        output=${output//\[%green%\]/'\e[0;32m'}
        output=${output//\[%yellow%\]/'\e[0;33m'}
        output=${output//$'\n'/'\e[0m'$'\n'}
    fi

    echo -e "$output"
}

if [[ -n "$1" ]]; then
    result=$(core.command_exists "$1")
    status=$?
    [ $status != 0 ] && core.exit "$result" $status
    help.command_help "$result"
else
    # shellcheck disable=SC2154
    "${RootDir}/command/list.sh" "$*"
fi
