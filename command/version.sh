#!/bin/bash
### command/version.sh ###

# shellcheck disable=SC2154
current_version=$(cat "${RootDir}/VERSION")
output.green "$current_version"