#!/bin/bash
# lib/output.sh

function output.print()
{
    echo -e "${*}${colors_Eoc}"
}
export -f output.print

function output.fatalerror()
{
    output.print "${colors_Red}" "[FATAL ERROR]: " "$1"
}
export -f output.fatalerror

function output.success()
{
    output.print "${colors_Green}" "[SUCCESS]: " "$1"
}
export -f output.success

function output.error()
{
    output.print "${colors_Red}" "[ERROR]: " "$1"
}
export -f output.error

function output.warning()
{
    output.print "${colors_Yellow0}" "[WARNING]: " "$1"
}
export -f output.warning

function output.green()
{
    output.print "${colors_Green}${1}"
}
export -f output.green


