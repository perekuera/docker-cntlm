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

read -a proxy_list -p "Enter proxies (space-separated): ";

echo "Username is $username";
echo "Domain is $domain";
echo "Password is $(echo "$password" | tr -c '\n' '*')";
echo "Proxy list is ${proxy_list[@]}";

echo "Building..."

docker compose \
    --build-arg USERNAME="$username" \
    --build-arg DOMAIN="$domain" \
    --build-arg PASSWORD="$password" \
    --build-arg PROXIES="${proxy_list[@]}" \
    build;

if [ "$?" -ne 0 ]; then
    echo "Error building image";
    exit 1;
fi;

exit 0;
