#!/bin/bash
### command/help.sh ###
#@DESCRIPTION: Clone git repository with addiionnals options
#@HELP:[%yellow%]Usage:
#@HELP:    install  [-h] [[-c] <repository> [<path>]
#@HELP:[%yellow%]Possibles Arguments:
#@HELP:    [%green%]<repository> [<path>]
#@HELP:          Clone <repository> in <path> (default in current path)
#@HELP:    [%green%]-c <repository> <path>
#@HELP:         Install composer package after clone repository if "composer.json" exists
#@HELP:    [%green%]-h
#@HELP:         Display this help message and exit

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

echo $0

while getopts ":hc" opt; do
    case "$opt" in
        h) # Exec help command
            # shellcheck disable=SC2154
            "${RootDir}/command/help.sh" "$(basename "$0" .sh)" && exit 0; 
            ;;
        c) # Set Verbose
            Composer="composer"
            ;;
        :) # If Option require an argument and none given Exit with Error
            core.exit "$(printer.fatalerror "Option '-$OPTARG' require a value")" 40
            ;;
        ? | *) # If not valid Option : print Warning
            printer.warning "Option '-$OPTARG' not Valid !"
            ;;
    esac
done
shift "$((OPTIND-1))"
[ -z "$1" ] && core.exit "$(printer.error "Missing [command] argument")" 40

gitProject="`expr "$1" : '.*\(/.*\.git\)'`"
gitProject=${gitProject%\.*}
gitProject=${gitProject#/}
if [ -d $gitProject ]; then
	echo "$gitProject directory already exists"
else
	echo "$gitProject will be cloning"
	git clone $1
	echo "$gitProject is cloning"
	cd $gitProject
	if [ $Composer = "composer" ]; then
		install.composer
	fi
fi