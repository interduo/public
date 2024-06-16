openssl genpkey -algorithm X25519 -outform der -out priv.der
openssl pkey -inform der -in priv.der -pubout -outform der -out pub.der

cat pub.der | tail -c 32 | base64 > wireguard_pub.txt
cat priv.der | tail -c 32 | base64 > wireguard_prv.txt
