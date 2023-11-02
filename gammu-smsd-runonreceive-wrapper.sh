#!/bin/bash
# author: Jarosław Kłopotek <jkl@interduo.pl> github:interduo
# put the script in /etc/gammu-smsdrc in runonreceive variable, merges long SMSes and send mail with SMS content
# requires: find, msmtp,

GAMMU_LMSOUT='/var/spool/gammu/wyslanedolms'
GAMMU_INBOX='/var/spool/gammu/inbox'
RTMAIL='rt@interduo.pl';
MAILCONTENTTYPE="Content-type: text/plain; charset=utf-8"

if [ -n "${DECODED_1_TEXT}" ]
then
        SMSCONTENT="${DECODED_1_TEXT}"
else
        SMSCONTENT="${SMS_1_TEXT}"
fi

echo "${MAILCONTENTTYPE}\nSubject:SMS:${SMS_1_NUMBER}\n${SMSCONTENT}" | msmtp -t ${RTMAIL}
find ${GAMMU_INBOX} -type f -exec mv {} ${GAMMU_LMSOUT} \;
