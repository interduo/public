#Test FTP certificate
openssl s_client -connect interduo.pl:21 -starttls ftp

#Test POP3 certificate
openssl s_client -connect interduo.pl:995

#Test IMAP certificate
openssl s_client -connect interduo.pl:993

#Test SMTP SSL certificate
openssl s_client -connect interduo.pl:465

#Test SMTP TLS certificate
openssl s_client -connect interduo.pl:587 -starttls smtp

#Test HTTPS certificate
openssl s_client -connect interduo.pl:443
