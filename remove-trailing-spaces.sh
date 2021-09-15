#!/bin/bash

#MASS USAGE:
#find . -type f -name -exec /root/remove-trailing-spaces.sh {} \;

FILENAME="$1"

sed -i -E "s/[[:space:]]*$//" "${FILENAME}"
