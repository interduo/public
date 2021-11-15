#!/bin/bash

PCTID=$1
CONTAINERDRIVE="/rpool/data/subvol-${PCTID}-disk-0"

# stop container
pct stop ${PCTID};

# mount drive
mount ${CONTAINERDRIVE};

# change dir/files owner
find ${CONTAINERDRIVE} -type f | while read S; do U="$(ls -ln "${S}" | awk '{print$3}')"; G="$(ls -ln "${S}" | awk '{print$4}')"; F=100000; chown "${F:0: -${#U}}${U}:${F:0: -${#G}}${G}" "${S}"; done

find ${CONTAINERDRIVE} -type d | while read S; do U="$(ls -lnd "${S}" | awk '{print$3}')"; G="$(ls -lnd "${S}" | awk '{print$4}')"; F=100000; chown "${F:0: -${#U}}${U}:${F:0: -${#G}}${G}" "${S}"; done

#remove devrandom, devurandom from postfix
[ -e ${CONTAINERDRIVE}/var/spool/postfix/dev/-random ] && rm -ri ${CONTAINERDRIVE}/var/spool/postfix/dev/random
[ -e ${CONTAINERDRIVE}/var/spool/postfix/dev/-urandom ] && rm -ri ${CONTAINERDRIVE}/var/spool/postfix/dev/urandom

#change lxc container privileged popperty
echo -e "\nunprivileged: 1" >> /etc/pve/lxc/${PCTID}.conf
