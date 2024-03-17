#!/bin/bash

echo "Please enter the password length:"
read length
password=$(openssl rand -base64 16 | tr -dc 'a-zA-Z0-9' | head -c "$length")
echo "Generated password: $password"
echo -e "Password length: " echo -n "$password" | wc -c
