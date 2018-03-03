#!/bin/bash
### lib/core.sh ###

# shellcheck disable=SC2154
function core.commandExists()
{
    [ -z "$1" ] && printer.error "Missing [command] argument" && return 40

    local cmd="$1"

    if [[ -f "${RootDir}/command/${cmd}.sh" ]]; then
        cmd="${RootDir}/command/${cmd}.sh"
    elif [[ -f "${RootDir}/usr/command/${cmd}.sh" ]]; then
        cmd="${RootDir}/usr/command/${cmd}.sh"
    else
        printer.error "Command Not Found: ${cmd}" && return 44
    fi

    if [[ ! -x "$cmd" ]]; then
        printer.fatalerror "script ${cmd} is not executable" && return 50
    fi

    echo "$cmd"
    return 0
}
export -f core.commandExists

function core.functionExists()
{
    type -t "$1"
    return $?

}
export -f core.functionExists

function core.exit()
{
    echo -e "$1"
    printer.verbose "(status code: $2)"
    exit "$2"
}
export -f core.exit