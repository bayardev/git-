#!/bin/bash
### command/help.sh ###
#@DESCRIPTION: Print HELP for a command
#@HELP:[%yellow%]Usage:
#@HELP:    help [<command name>]

if [[ -n "$1" ]]; then
    result=$(core.commandExists "$1")
    status=$?
    [ $status != 0 ] && core.exit "$result" $status
    helper.getCmdHelp "$result"
else
    # shellcheck disable=SC2154
    "${RootDir}/command/list.sh" "$*"
fi
