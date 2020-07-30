#!/bin/sh
# DESC: view certificate details by hostname and tcp port
# usage: openssl_cert_check.sh remote.host.name [port]


REMHOST=$1
REMPORT=${2:-443}

echo '############## openssl x509 -noout -subject -dates #####################################'
echo |\
openssl s_client -connect ${REMHOST}:${REMPORT} 2>/dev/null |\
sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' |\
openssl x509 -noout -subject -serial -dates

echo '############## openssl s_client -connect ${REMHOST}:${REMPORT} ##########################'
echo |\
openssl s_client -connect ${REMHOST}:${REMPORT} 2>&1 |\
sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'

echo '############## openssl x509 -noout #######################################################'
echo |\
openssl s_client -connect ${REMHOST}:${REMPORT} 2>/dev/null |\
sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' |\
openssl x509 -noout -text
