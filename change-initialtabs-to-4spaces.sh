#!/bin/bash

#USAGE:
#find . -type f -name "*.php" -exec /root/change-initialtabs-to-4spaces.sh {} \;

FILENAME="$1"
TMPFILE="/tmp/4spaces-${RANDOM}"

expand -i -t 4 "${FILENAME}" > "${TMPFILE}" && mv "${TMPFILE}" "${FILENAME}"
