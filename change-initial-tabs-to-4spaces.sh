#!/bin/bash
#USAGE
#/path/to/change-initialtabs-to-4spaces.sh filename.php

#MASS USAGE:
#find . -type f -name "*.php" -exec /path/to/change-initialtabs-to-4spaces.sh {} \;

FILENAME="$1"
TMPFILE="/tmp/4spaces-${RANDOM}"

expand -i -t 4 "${FILENAME}" > "${TMPFILE}" && mv "${TMPFILE}" "${FILENAME}"
