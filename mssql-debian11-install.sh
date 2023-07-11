#!/bin/bash
# Install MSSQL Client on Debian 11

curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list
ACCEPT_EULA=Y

apt update && apt install -y msodbcsql18 mssql-tools18
