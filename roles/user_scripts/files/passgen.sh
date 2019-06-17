#! /bin/bash
COUNT=${1:-10}
#openssl rand -base64 256    |tr -dc _A-Z-a-z-0-9|head -c "$COUNT";echo
cat /dev/urandom |head|base64|tr -dc _A-Z-a-z-0-9|head -c "$COUNT";echo
