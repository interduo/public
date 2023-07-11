#!/bin/bash
# Install MSSQL Client on Debian 11

curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list
ACCEPT_EULA=Y

apt update && apt install -y msodbcsql18 mssql-tools18

wget https://github.com/microsoft/msphpsql/releases/download/v5.10.1/Debian11-7.4.tar -O /tmp/d11.tar
tar -xvf /tmp/d11.tar
cp /tmp/Debian7.4/php_pdo_sqlsrv_74_nts.so /usr/lib/php/20210902/pdo_sqlsrv.so
cp /tmp/Debian7.4/php_sqlsrv_74_nts.so /usr/lib/php/20210902/sqlsrv.so
rm /tmp/d11.tar

printf "; priority=20\nextension=sqlsrv.so\n" > /etc/php/7.4/mods-available/sqlsrv.ini
printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php/7.4/mods-available/pdo_sqlsrv.ini

phpenmod sql_srv pdo_sqlsrvx
