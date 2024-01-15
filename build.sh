#!/bin/bash

read -ep "Enter username: " username;

read -ep "Enter domain: " domain;

password="";
password2="";

while true; do
    read -sep "Enter password: " password;

    read -sep "Confirm password: " password2;

    if [ "$password" = "$password2" ]; then
        break;
    else
        echo "Passwords do not match. Please try again.";
    fi;
done;

read proxy -ep "Enter proxy (address:port): " proxy;

echo "Username is $username";
echo "Domain is $domain";
echo "Password is $(echo "$password" | tr -c '\n' '*')";
echo "Proxy is $proxy";

echo "Building..."

docker compose \
    --build-args USERNAME="$username" \
    --build-args DOMAIN="$domain" \
    --build-args PASSWORD="$password" \
    --build-args PROXY="$proxy" \
    build;

if [ "$?" -ne 0 ]; then
    echo "Error building image";
    exit 1;
fi;

exit 0;
