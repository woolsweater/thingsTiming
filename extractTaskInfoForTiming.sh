#!/usr/bin/env bash

source './taskTimingCommon.sh'

# Fetch and extract task fields
taskInfo="$(./getSelectedTask.applescript)"
title="$(awk 'NR==1' <<< "${taskInfo}")"
id="$(awk 'NR==2' <<< "${taskInfo}")"
notes="$(awk 'NR>=3' <<< "${taskInfo}")"

# Drop elapsed time marker from notes, extracting minutes value
timePattern="$(buildElapsedTimeMarker '([[:digit:]]+)')"
notesBody="$(sed -E "/${timePattern}/ d" <<< "${notes}")"
# Note that elapsedTime will be empty if the task has not been previously timed
elapsedTime="$(sed -nE "s/${timePattern}/\1/p" <<< "${notes}")"

# Add in progress marker to notes
if [[ -n "${notesBody}" ]]; then
    notesBody="${notesBody}"$'\n'"${inProgressMarker}"
else
    notesBody="${inProgressMarker}"
fi

# Output task name, id, and elapsed time for display
echo "${title}"
echo "${id}"
echo "${elapsedTime}"

# Change task notes in Things
updateTask "${id}" "${notesBody}"
