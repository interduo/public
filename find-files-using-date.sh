#!/bin/bash
STARTDATE = 202507110000;
ENDDATE = $STARTDATE+10000;

touch -t $STARTDATE /tmp/start
touch -t $ENDDATE /tmp/end

find ../lms-storage/documents/ -type f -newer /tmp/start ! -newer /tmp/end
