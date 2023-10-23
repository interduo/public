#!/bin/bash
GAMMU_DIR='/var/spool/gammu'
GAMMU_LMSOUT='/var/spool/gammu/archive'
GAMMU_INBOX='/var/spool/gammu/inbox'
RTMAIL='domain@company.pl';
MAILFROM='no-reply@company.pl'
MAILCONTENTTYPE="Content-type: text/plain; charset=utf-8"
ELEMENTSCOUNT=( $# )

if [ ${ELEMENTSCOUNT} -ne 1 ]
then
    SMSCONTENT=`cd ${GAMMU_INBOX}; find "$@" -type f -exec cat {} \; -exec rm {} \;`
fi

NEWNAME=`echo $1 | tr ' ' '_'`
NUMBER=`echo "${NEWNAME}" | awk -F '/' '{print $NF}' | awk -F '_' '{print $4}'`
echo "${SMSCONTENT}" > "${GAMMU_LMSOUT}/${NEWNAME}"

echo -e "Subject:SMS:${NUMBER}\n${MAILCONTENTTYPE}\n${SMSCONTENT}\n" | msmtp -t ${RTMAIL}
