#!/bin/bash

# Root CA
openssl genpkey -algorithm RSA -out rootCA.key -aes256 -pass pass:rootCAPassword
openssl req -x509 -new -key rootCA.key -sha256 -days 3650 -out rootCA.crt -subj "/C=US/ST=State/L=City/O=Organization/OU=OrgUnit/CN=RootCA" -passin pass:rootCAPassword

# Intermediate CA
openssl genpkey -algorithm RSA -out intermediateCA.key -aes256 -pass pass:intermediateCAPassword
openssl req -new -key intermediateCA.key -out intermediateCA.csr -subj "/C=US/ST=State/L=City/O=Organization/OU=OrgUnit/CN=IntermediateCA" -passin pass:intermediateCAPassword

# Sign the Intermediate CA Certificate with the Root CA
openssl x509 -req -in intermediateCA.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out intermediateCA.crt -days 1825 -sha256 -passin pass:rootCAPassword \
-extfile <(printf "basicConstraints=CA:TRUE\nkeyUsage=critical,digitalSignature,cRLSign,keyCertSign\nsubjectKeyIdentifier=hash\nauthorityKeyIdentifier=keyid:always,issuer")

# End-User Certificate
openssl genpkey -algorithm RSA -out enduser.key -aes256 -pass pass:endUserPassword
openssl req -new -key enduser.key -out enduser.csr -subj "/C=US/ST=State/L=City/O=Organization/OU=OrgUnit/CN=EndUser" -passin pass:endUserPassword
openssl x509 -req -in enduser.csr -CA intermediateCA.crt -CAkey intermediateCA.key -CAcreateserial -out enduser.crt -days 365 -sha256 -passin pass:intermediateCAPassword

# Concatenate Intermediate CA and End-User Certificate for the Server
cat enduser.crt intermediateCA.crt > fullchain.crt

# Verify the certificate chain
openssl verify -CAfile rootCA.crt -untrusted intermediateCA.crt enduser.crt
