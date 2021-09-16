#!/bin/bash

#USSAGE
#remove-trailing-spaces.sh filename.html

#MASS USAGE:
#find . -type f -name -exec /path/to/remove-trailing-spaces.sh {} \;

FILENAME="$1"

sed -i -E "s/[[:space:]]*$//" "${FILENAME}"
