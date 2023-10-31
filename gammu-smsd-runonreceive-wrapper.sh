#!/bin/bash
# author: Jarosław Kłopotek <jkl@interduo.pl> github:interduo
# put the script in /etc/gammu-smsdrc in runonreceive variable, merges long SMSes and send mail with SMS content
# requires: find, msmtp,

GAMMU_LMSOUT='/var/spool/gammu/wyslanedolms'
GAMMU_INBOX='/var/spool/gammu/inbox'
RTMAIL='domain@your-company.pl';
MAILCONTENTTYPE="Content-type: text/plain; charset=utf-8"

echo -e "Subject:SMS:${SMS_1_NUMBER}\n${MAILCONTENTTYPE}\n${DECODED_1_TEXT}\n" | msmtp -t ${RTMAIL}
find ${GAMMU_INBOX} -type f -exec mv {} ${GAMMU_LMSOUT} \;
