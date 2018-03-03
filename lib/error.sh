#!/bin/bash
### lib/error.sh ###

function error.missingArg()
{
    printer.error "Missing argument ${1} in function: ${FUNCNAME[1]}"
    error.callStack
}
export -f error.missingArg

function error.callStack()
{
    printer.verbose "[CALL-STACK]"
    for i in "${!FUNCNAME[@]}"; do
        printer.verbose "Function: ${FUNCNAME[$i]}; Called from: ${BASH_SOURCE[$i+1]} at line ${BASH_LINENO[$i]}"
    done

}
export -f error.callStack