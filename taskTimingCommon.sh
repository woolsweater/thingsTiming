#!/usr/bin/env bash

## Include per-installation data such as list IDs and auth token
source './localConstants.sh'

## Marker placed in task notes while it is being timed
inProgressMarker="--in progress--"

## Apply URL escapes to the passed string
function urlEncode() {
    python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "${1}"
}

## Format the passed value to be put into the task notes as the elapsed time
## Note: this is also used to construct a sed pattern to extract the minutes
function buildElapsedTimeMarker () {
    echo "--elapsed time:${1}--"
}

## Use the Things URL scheme to update the task of the given ID with the new
## notes; the notes will be URL encoded before the call is made
function updateTask () {
    id=${1}
    notes="$(urlEncode "${2}")"
    
    open "things:///update?auth-token=${thingsAuthToken}&id=${id}&notes=${notes}"
}
