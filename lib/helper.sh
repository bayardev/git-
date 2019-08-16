#!/bin/bash
### lib/helper.sh ###

function helper.getCmdHelp()
{
    local filename=${1?"$(error.missingArg 1)"}

    helper.funcHelp "$filename" && return 0;

    helper.innerHelp "$filename" && return 0;

    printer.warning "No help found for command '$(basename "$filename" .sh)'"
    return 44;
}
export -f helper.getCmdHelp

function helper.innerHelp()
{
    local filename=${1?"$(error.missingArg 1)"}
    local output
    output=$(sed -nr '/^#@HELP:/ s/.*#@HELP:([^"]+).*/\1/p' "$filename")
    if [[ -z "$output" ]]; then
        return 44;
        #output=$(printer.warning "No help found for command '$(basename "$filename" .sh)'")
    else
        output=${output//\[%green%\]/'\e[0;32m'}
        output=${output//\[%yellow%\]/'\e[0;33m'}
        output=${output//$'\n'/'\e[0m'$'\n'}
    fi

    echo -e "$output"
    return 0
}
export -f helper.innerHelp

function helper.funcHelp()
{
    local filename=${1?"$(error.missingArg 1)"}
    local cmdname; cmdname="$(basename "$filename" .sh)"

    if core.functionExists "${cmdname}.help"; then
        "${cmdname}.help"
        return 0;
    fi

    if core.functionExists "help.${cmdname}"; then
        "help.${cmdname}"
        return 0;
    fi

    return 44;

}
export -f helper.funcHelp