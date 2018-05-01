#!/usr/bin/osascript

on run theTaskId
    tell application "Things3"
        set theNotes to notes of first to dos where id is theTaskId
    end tell

    return theNotes
end run
