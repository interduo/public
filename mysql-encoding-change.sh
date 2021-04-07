#!/bin/bash
# Change MySQL encoding on whole DB,TABLES,COLUMNS...

DBNAME='mysqldbname'

mysql ${DBNAME} -e "ALTER DATABASE ${DBNAME} CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci"

TABLES=`mysql ${DBNAME} -Ne "SHOW FULL TABLES WHERE Table_Type='BASE TABLE'" | awk '{ print $1 }'`

for i in ${TABLES}
do
        echo "ALTER TABLE \`$i\` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;" | mysql ${DBNAME}
	SQL="SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE DATA_TYPE=\"varchar\" AND table_name = \"$i\" AND table_schema = \"${DBNAME}\" "
        COLS=`mysql -Ne "${SQL}" ${DBNAME}`;

        for y in ${COLS}
        do
		if [ -n $y ]
		then
	                echo "ALTER TABLE \`$i\` MODIFY \`$y\` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci" | mysql ${DBNAME}
		fi
        done
done
