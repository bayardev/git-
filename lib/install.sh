#!/bin/bash
### usr/lib/install.sh ###

function install.help()
{
    echo ""
    echo "  -c 		Intall composer package"
    echo "  -h     	Display this help message and exit"
    echo ""
}
export -f install.help

function install.composer()
{
	if [ -f "composer.json" ]; then
		echo "compser install : start"
		composer install
		echo "composer install : end"
	else
		echo "compser.json not found"
	fi
}
export -f install.composer