#!/bin/bash
echo 'SAMBA: add account - params: 1-username, 2-group, 3-pass'

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ];
then
    echo 'ERROR: no required params'
    exit 1
fi

USER=$1
GROUP=$2
PASS=$3

useradd -m -g ${GROUP} ${USER}
echo ${USER}:${PASS} | chpasswd
(echo "${PASS}"; echo "${PASS}") | smbpasswd -s -a ${USER}
