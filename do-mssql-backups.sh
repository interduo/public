#!/bin/bash
SQL_LOGIN='uzytkownik'
SQL_PASS='pasło'
SQL_HOST='192.168.1.1'
SQL_QUERY='./backupjob.txt'
STORAGE='/sql-backups'
DATENOW=`date +%Y%m%d_%H%M`
MAILTO='adres@domena.pl'
KEEPBACKUPDAYS='10'

#make backups
/opt/mssql-tools/bin/sqlcmd -U "${SQL_LOGIN}" -P "${SQL_PASS}" -S "${SQL_HOST}" -i "${SQL_QUERY}" 

#move backups to specified folders
mkdir ${STORAGE}/${DATENOW}
mv ${STORAGE}/*.BAK ${STORAGE}/${DATENOW}
chgrp -R backup ${STORAGE}/${DATENOW}

#purge old files
find ${STORAGE} -type f -name "*BAK" -ctime +"${KEEPBACKUPDAYS}" -delete
find ${STORAGE} -type d -empty -delete

#send raport to admin
/skrypty/raportuj-stan-kopii-db.sh "${MAILTO}"
