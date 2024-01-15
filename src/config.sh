#!/bin/sh

set -e

cntlm_res=$(cntlm -H -u $USERNAME -d $DOMAIN)

hash_ntlmv2=$(echo "$cntlm_res" | awk '/PassNTLMv2/ {print $2}')

noproxy="localhost, 127.0.0.*, 10.*, 192.168.*, *.$2"
if [ -n "$NOPROXY" ]; then
	noproxy="$noproxy, $NOPROXY"
fi

cat << EOF > /etc/cntlm/cntlm.conf
UserName $USERNAME
Domain $DOMAIN
PassNTLMv2 $hash_ntlmv2
Proxy $PROXY
NoProxy $noproxy
Gateway yes
Listen 3128
EOF
