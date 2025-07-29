#!/bin/bash
USER="demo"
DATABASE="devlms"
NOWEHASLO="demo123"

HASH=$(php -r "echo password_hash('${NOWEHASLO}', PASSWORD_BCRYPT);")
CMD="UPDATE users SET passwd = '${HASH}' WHERE login = '${USER}';"

sudo su - postgres -c "psql ${DATABASE} -c \"${CMD}\""
