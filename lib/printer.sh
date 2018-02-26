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
    printer.print "${colors_Green0}${*}"
}
export -f printer.green

function printer.red()
{
    printer.print "${colors_Red0}${*}"
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
    printer.print "${colors_Green}[SUCCESS]: ${*}"
}
export -f printer.success

function printer.fatalerror()
{
    printer.print "${colors_Red}[FATAL ERROR]: ${*}"
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

#########################
### Section: SPECIALS ###
#########################

function printer.listitem()
{
    local length1=${#1}
    #echo "$length1"
    local nspace=$((12 - length1))
    local sp
    for (( i = 0; i < nspace; i++ )); do
        sp="${sp} "
    done
    echo -e "  ${colors_Green0}${1}${sp}\t${colors_Eoc}${2}"
}
export -f printer.listitem
