#!/bin/bash
# Sysadmin Fun Boost
# Fun guaranteed!

function random_line(){
    sort -R | head -n 1
}

function random_executable(){
    find $(echo "$PATH" | sed 's/:/ /g') -executable -a -type f | random_line
}

# Delete random line from a *.conf file in /etc
FILE_NAME=$(find /etc -name '*.conf' | random_line)
LINES=$(cat "$FILE_NAME" | wc -l)
LINE_TO_DELETE=$(expr $RANDOM % $LINES + 1)
sed -n "$LINE_TO_DELETE!p" $FILE_NAME > "$TEMP_FILE"
mv "$TEMP_FILE" "$FILE_NAME"

# Take two random executables and swap them
TEMP_FILE=$(mktemp)
EXECUTABLE1=$(random_executable)
EXECUTABLE2=$(random_executable)
mv "$EXECUTABLE1" "$TEMP_FILE"
mv "$EXECUTABLE2" "$EXECUTABLE1"
mv "$TEMP_FILE" "$EXECUTABLE2"

echo "Have fun!"
