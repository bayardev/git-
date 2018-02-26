#!/bin/bash
### command/version.sh ###

[ ! -d "$(pwd)/.git" ] && output.fatalerror "This is not GIT repository !" && exit 52

# shellcheck disable=SC2154
if [[ -f VERSION ]]; then
    CurrentVersion=$(cat VERSION)
else
    CurrentVersion="0.0.0"
    output.warning "VERSION file not found. It will be created !"
fi
export CurrentVersion

## If called without argument print "Current Version" & exit
if [[ -z "$1" ]]; then
    output.green "$CurrentVersion"
    exit 0
fi

set -f
export SemVer=(${CurrentVersion//./ })

case "$1" in
    "major")
        SemVer[0]=$(( SemVer[0] + 1))
        NewVersion="${SemVer[0]}.0.0"
        ;;
    "minor")
        SemVer[1]=$(( SemVer[1] + 1))
        NewVersion="${SemVer[0]}.${SemVer[1]}.0"
        ;;
    "patch")
        SemVer[2]=$(( SemVer[2] + 1))
        NewVersion=$(IFS=. eval 'echo "${SemVer[*]}"')
        ;;
    *)
        if [[ \
            "$1" =~ ^[0-9]{1,2}\.[0-9]{1,2}\.[0-9]{1,2}$ || \
            "$1" =~ ^[0-9]{1,2}\.[0-9]{1,2}\.[0-9]{1,2}-[[:graph:]]+[[:alnum:]]$ \
            ]]
        then
            NewVersion="$1"
        else
            output.error "Only accept Semantic Version major.minor.patch[-pre_release]"
            output.suggest "See https://semver.org/"
            exit 40
        fi
        ;;
esac

### @DEBUG
Debug=true
if [[ $Debug = true ]]; then
    output.yellow "Old Version : $CurrentVersion"
    output.yellow "New Version : ${NewVersion}"
fi


## Set new version in VERSION file
echo "$NewVersion" > VERSION && output.success "New Version : ${NewVersion}"

## Commit New Version
CommitComment="New Version ${NewVersion}"
git add VERSION && \
git commit -m "$CommitComment" VERSION && \
## Set next git tag
git tag -a "v${NewVersion}" -m "$CommitComment" "$(git log --format="%H" -n 1)" || \
exit $?

## Exit GOOD :)
exit 0;

