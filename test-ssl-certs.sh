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
openssl s_client -connect interduo.pl:25 -starttls smtp

#Test HTTPS certificate
openssl s_client -connect interduo.pl:443

#Weryfikacja żądania pliku CSR:
openssl req -in csr.txt -noout -text

#Odczytanie numeru seryjnego certyfikatu:
openssl x509 -in certyfikat.crt -serial -noout

#Odczytanie daty ważności certyfikatu:
openssl x509 -in certyfikat.crt --enddate -noout
