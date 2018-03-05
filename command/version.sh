#!/bin/bash
### command/version.sh ###
#@DESCRIPTION: Manage Semantic Version (with git tags)

#@HELP:[%yellow%]Usage:
#@HELP:    version [major|minor|patch|<semver version number>]
#@HELP:[%yellow%]Without Arguments:
#@HELP:    print current version
#@HELP:[%yellow%]Possibles Arguments:
#@HELP:    [%green%]major
#@HELP:        upgrade to next major (ex. 0.2.1 -> 1.0.0)
#@HELP:    [%green%]minor
#@HELP:        upgrade to next minor (ex. 0.2.1 -> 0.3.0)
#@HELP:    [%green%]patch
#@HELP:        upgrade to next patch (ex. 0.2.1 -> 0.2.2)
#@HELP:    [%green%]<semver version number>
#@HELP:        upgrade version as the argument given
#@HELP:        Only accept Semantic Version major.minor.patch[-pre_release]

[ ! -d "$(pwd)/.git" ] && printer.fatalerror "This is not GIT repository !" && exit 52

if [[ -f VERSION ]]; then
    CurrentVersion=$(cat VERSION)
else
    CurrentVersion="0.0.0"
    printer.warning "VERSION file not found. It will be created !"
fi
export CurrentVersion

## If called without argument print "Current Version" & exit
if [[ -z "$1" ]]; then
    printer.green "$CurrentVersion"
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
            printer.error "Only accept Semantic Version major.minor.patch[-pre_release]"
            printer.suggest "See https://semver.org/"
            exit 40
        fi
        ;;
esac


## verbose versions infos
printer.verbose "Old Version : $CurrentVersion"
printer.verbose "New Version : ${NewVersion}"

## Set new version in VERSION file
echo "$NewVersion" > VERSION && printer.success "New Version : ${NewVersion}"

## Commit New Version
CommitComment="New Version ${NewVersion}"
git add VERSION && \
git commit -m "$CommitComment" VERSION && \
## Set next git tag
git tag -a "v${NewVersion}" -m "$CommitComment" "$(git log --format="%H" -n 1)" || \
exit $?

## Exit GOOD :)
exit 0;

