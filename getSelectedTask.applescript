#!/usr/bin/osascript

on run
    tell application "Things3"
    	set theTodo to first selected to do
    	set theTitle to name of theTodo
        set theId to id of theTodo
    	set theNotes to notes of theTodo
    end tell

    return theTitle & "\n" & theId & "\n" & theNotes
end run
