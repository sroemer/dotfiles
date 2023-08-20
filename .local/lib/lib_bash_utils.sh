#!/bin/bash

###
# Logging to stdout via log() and stderr via error_log()
#
# Arguments:
#   error message
###
function log() {
    echo "INFO : $*"
}
function error_log() {
    echo -e "\e[1;31mERROR: $*\e[0m" >&2
}
function warn_log() {
    echo -e "\e[1;33mWARN : $*\e[0m"
}

###
# Request latest release version of Github repository
#
# Arguments:
#   repository owner, repository name
###
function get_github_latest_release_version() {

    # check if curl and jq are available
    if ! [[ -x $(command -v curl) ]]; then
        return 1
    fi
    if ! [[ -x $(command -v jq) ]]; then
        return 1
    fi

    # check arguments (owner and repo)
    local owner="$1"
    local repo="$2"
    if [[ -z "$owner" ]]; then
        return 1
    fi
    if [[ -z "$repo" ]]; then
        return 1
    fi

    # perform the request of the latest release version
    if ! version=$(curl -sL https://api.github.com/repos/"$owner"/"$repo"/releases/latest | jq -reM ".tag_name"); then
        return 1
    fi

    # return version on success
    echo "$version"
    return 0
}
