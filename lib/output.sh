#!/bin/bash
# shellcheck disable=SC2154
### lib/output.sh ###

function output.print()
{
    echo -e "${*}${colors_Eoc}"
}
export -f output.print

#######################
### Section: COLORS ###
#######################

function output.green()
{
    output.print "${colors_Green}${*}"
}
export -f output.green

function output.red()
{
    output.print "${colors_Red}${*}"
}
export -f output.red

function output.yellow()
{
    output.print "${colors_Yellow0}${*}"
}
export -f output.yellow

function output.cyan()
{
    output.print "${colors_Cyan0}${*}"
}
export -f output.cyan

#######################
### Section: LABELS ###
#######################

function output.success()
{
    output.green "[SUCCESS]: ${*}"
}
export -f output.success

function output.fatalerror()
{
    output.red "[FATAL ERROR]: ${*}"
}
export -f output.fatalerror

function output.error()
{
    output.red "[ERROR]: ${*}"
}
export -f output.error

function output.warning()
{
    output.yellow "[WARNING]: ${*}"
}
export -f output.warning

function output.suggest()
{
    output.cyan "[SUGGESTION]: ${*}"
}
export -f output.suggest


