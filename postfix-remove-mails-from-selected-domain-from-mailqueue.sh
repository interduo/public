mailq | grep domain.com -B1 | grep -oE "^[A-Z0-9]{10,11}" | sudo postsuper -d -
