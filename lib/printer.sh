#!/bin/bash
# shellcheck disable=SC2154
### lib/printer.sh ###

function printer.print()
{
    echo -e "${*}${colors_Eoc}"
}
export -f printer.print

#######################
### Section: COLORS ###
#######################

function printer.green()
{
    printer.print "${colors_Green}${*}"
}
export -f printer.green

function printer.red()
{
    printer.print "${colors_Red}${*}"
}
export -f printer.red

function printer.yellow()
{
    printer.print "${colors_Yellow0}${*}"
}
export -f printer.yellow

function printer.cyan()
{
    printer.print "${colors_Cyan0}${*}"
}
export -f printer.cyan

#######################
### Section: LABELS ###
#######################

function printer.success()
{
    printer.green "[SUCCESS]: ${*}"
}
export -f printer.success

function printer.fatalerror()
{
    printer.red "[FATAL ERROR]: ${*}"
}
export -f printer.fatalerror

function printer.error()
{
    printer.red "[ERROR]: ${*}"
}
export -f printer.error

function printer.warning()
{
    printer.yellow "[WARNING]: ${*}"
}
export -f printer.warning

function printer.suggest()
{
    printer.cyan "[SUGGESTION]: ${*}"
}
export -f printer.suggest


