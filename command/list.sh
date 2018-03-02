#!/bin/bash
### command/list.sh ###
#@DESCRIPTION: List all availables commands

function list.command_description()
{
    local filename="$1"
    local description
    description=$(sed -nr '/^#@DESCRIPTION: / s/.*#@DESCRIPTION: ([^"]+).*/\1/p' "$filename")
    echo "$description"
}

printer.yellow "Available commands:"
# shellcheck disable=SC2154
for command in ${RootDir}/command/*.sh ${RootDir}/usr/command/*.sh; do
    [ -e "$command" ] || break
    # shellcheck disable=SC1090
    printer.listitem "$(basename "$command" .sh)" "$(list.command_description "$command")"
done