#!/bin/bash

set -e

# Check if mandatory args were passed
# if [[ -z $CNTLM_USERNAME || -z $CNTLM_DOMAIN || -z $CNTLM_PROXY_URL ]]
# then
#     echo "CNTLM_USERNAME, CNTLM_DOMAIN and CNTLM_PROXY_URL are mandatory!" >> /dev/stderr
#     exit 1
# fi

# Check if any of the password args was passed
# CNTLM_PASSWORDS=($CNTLM_PASSLM $CNTLM_PASSNT $CNTLM_PASSNTLMv2)
# if [ ${#CNTLM_PASSWORDS[@]} -eq 0 ]
# then
#     echo "Either CNTLM_PASSLM or CNTLM_PASSNT or CNTLM_PASSNTLMv2 must be passed!" >> /dev/stderr
#     exit 1
# fi

# Default listen port
# if [[ -z $CNTLM_LISTEN_PORT ]]
# then
#     CNTLM_LISTEN_PORT=3128
# fi

# Inject user-defined data into /etc/cntlm.conf
# if [ -f /etc/cntlm.conf ]
# then
#     sed -i 's/<CNTLM_USERNAME>/'${CNTLM_USERNAME}/g /etc/cntlm.conf
#     sed -i 's/<CNTLM_DOMAIN>/'${CNTLM_DOMAIN}/g /etc/cntlm.conf
#     sed -i 's/<CNTLM_PASSLM>/'${CNTLM_PASSLM}/g /etc/cntlm.conf 
#     sed -i 's/<CNTLM_PASSNT>/'${CNTLM_PASSNT}/g /etc/cntlm.conf
#     sed -i 's/<CNTLM_PASSNTLMv2>/'${CNTLM_PASSNTLMv2}/g /etc/cntlm.conf
#     sed -i 's/<CNTLM_PROXY_URL>/'${CNTLM_PROXY_URL}/g /etc/cntlm.conf
#     sed -i 's/<CNTLM_PROXY_PORT>/'${CNTLM_PROXY_PORT}/g /etc/cntlm.conf
#     sed -i 's/<CNTLM_LISTEN_PORT>/'${CNTLM_LISTEN_PORT}/g /etc/cntlm.conf
# fi

# AG_GCC_INSTALLED=$(which gcc)
# FLAG_MAKE_INSTALLED=$(which make)
# if [[ -z FLAG_GCC_INSTALLED || -z FLAG_MAKE_INSTALLED ]]
# then
#     echo "Cannot find both make and gcc installed."
#     exit 1
# fi

# if [ -d /usr/local/src/cntlm-0.92.3/ ]
# then
#     cd /usr/local/src/cntlm-0.92.3/
#     ./configure
#     make
#     make install
# fi

# Start cNTLM in foreground
#cntlm -f -g -c /etc/cntlm.conf

### URL https://github.com/robertdebock/docker-cntlm
### URL https://github.com/jaschac/docker-cntlm

read -p 'User: ' userval
read -p 'Domain: ' domainval
read -sp 'Password: ' passwdval
echo ""
read -p 'Proxy url: ' urlval
read -p 'Proxy port: ' portval
read -p 'No proxy (default localhost, 127.0.0.*, 10.*, 192.168.*): ' noproxyval

# Start cntlm after all configuration has been written.
#/usr/sbin/cntlm -c /etc/cntlm.conf -f ${OPTIONS}

# Start cNTLM in foreground (debian)
#cntlm -f -g -c /etc/cntlm.conf