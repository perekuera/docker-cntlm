#!/bin/sh

#set -e

cat /etc/cntlm.conf

read -p 'User: ' userval
read -p 'Domain: ' domainval
read -sp 'Password: ' passwdval
echo ""
echo "go go go !!!"
#read -p 'Proxy url: ' urlval
#read -p 'Proxy port: ' portval
#read -p 'No proxy (default localhost, 127.0.0.*, 10.*, 192.168.*): ' noproxyval

#cntlmpassval=echo $passwdval | cntlm -f -H -u $userval@$domainval

#echo "Passwords:"
#echo $passwdval

echo "Password ${passwdval}" > /etc/cntlm.conf
echo "Password ${passwdval}" > /etc/cntlm2.conf

echo "##################" > out
cat /etc/cntlm.conf > out
echo "##################" > out
cat /etc/cntlm2.conf > out
echo "##################" > out

/usr/sbin/cntlm -H -u $userval -d $domainval > out
