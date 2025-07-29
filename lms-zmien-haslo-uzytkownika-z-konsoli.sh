#!/bin/bash

USER="demo"
DATABASE="devlms"
NOWEHASLO="demo123456"

HASH=$(php -r "echo password_hash('$NOWEHASLO', PASSWORD_BCRYPT);")

su - postgres -c "psql $DATABASE" <<EOF
UPDATE users SET passwd = '$HASH' WHERE login = '$USER';
EOF
