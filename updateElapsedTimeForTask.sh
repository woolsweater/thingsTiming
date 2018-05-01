#!/usr/bin/env bash

source './taskTimingCommon.sh'

id="${1:?'Must supply a task id'}"
time="${2:?'Must supply an updated time value'}"

notes="$(./getNotesByTaskId.applescript ${id})"

# Replace "in progress" marker with time (no change is made if the marker is not
# found)
elapsedTime="$(buildElapsedTimeMarker ${time})"
notesBody="$(sed -e "s/${inProgressMarker}/${elapsedTime}/" <<< "${notes}")"

updateTask "${id}" "${notesBody}"
