#!/bin/bash
### usr/lib/install.sh ###

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