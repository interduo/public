DBSTORAGE='/sql-backups'
DBNAMES='SQLDB1 SQLDB2 SQLDB3 SQLDB4 SQLDB5 SQLDB6'
TODAY=`date +%Y%m%d`
MAILTO=$1
MAILFROM='backups@domain.pl'
COMPANY="COMPANY1"
MAILSUBJ="[${COMPANY}] SQL backups raport"
MAILHEADERS="Content-type: text/html; charset=utf-8"

BDB=$(
echo '<html><head><title>' ${COMPANY} 'Backups</title><meta http-equiv="Content-Type" content="text/html;charset=utf-8"></head><body><h1>' ${MAILSUBJ} ${COMPANY} ' date: ' "${TODAY}" '</h1>'
for DB in ${DBNAMES}
do
  BACKUPCOUNT=`find ${DBSTORAGE} -cmin -60 -type f -name "${DB}*.BAK" | wc -l`
  if [ "${BACKUPCOUNT}" -ge 1 ]
  then
    echo -e "<span style='color: green'>SQL DB Backup ${DB} is OK</span><br>"
  else
    echo -e "<span style='color: red'>ERROR! SQL DB Backup ${DB} NOT EXITS!</span><br>"
  fi
done
echo '</body></html>'
)

if [ ! "${MAILTO}" ]
then
  echo "${BDB}"
else
  echo "${BDB}" | mail "${MAILTO}" -r "${MAILFROM}" -s "${MAILSUBJ}" -a "${MAILHEADERS}"
fi
