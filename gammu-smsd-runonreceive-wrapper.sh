#!/bin/bash
# put the script in /etc/gammu-smsdrc in runonreceive variable, merges long SMSes and send mail with SMS content
# requires: find, awk, msmtp,

GAMMU_DIR='/var/spool/gammu'
GAMMU_LMSOUT='/var/spool/gammu/wyslanedolms'
GAMMU_INBOX='/var/spool/gammu/inbox'
RTMAIL='bok@domain.pl';
MAILCONTENTTYPE="Content-type: text/plain; charset=utf-8"
ELEMENTSCOUNT=( $# )

SMSCONTENT=`cd ${GAMMU_INBOX} && find "$@" -type f -exec cat {} \; -exec rm {} \;`
NEWNAME=`echo $1 | tr ' ' '_'`
NUMBER=`echo "${NEWNAME}" | awk -F '/' '{print $NF}' | awk -F '_' '{print $4}'`
echo "${SMSCONTENT}" > "${GAMMU_LMSOUT}/${NEWNAME}"

echo -e "Subject:SMS:${NUMBER}\n${MAILCONTENTTYPE}\n${SMSCONTENT}\n" | msmtp -t ${RTMAIL}
