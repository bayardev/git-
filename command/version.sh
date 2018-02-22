#!/bin/bash
# command/version.sh

current_version=$(cat "${RootDir}/VERSION")
output.green "$current_version"