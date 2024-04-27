#!/bin/bash

# Specify how long your password should be
echo "Please enter the password length:"

# reads the user input for the password length and stores it in the variable 'length'. The -r option prevents backslashes from being interpreted.
read -r length

# generates a random password of the specified length. It uses openssl to generate a random base64 string, tr to remove non-alphanumeric characters, and head to take the first 'length' characters. The generated password is stored in the variable 'password'.
password=$(openssl rand -base64 16 | tr -dc 'a-zA-Z0-9' | head -c "$length")

# prints the generated password
echo "Generated password: $password"

# prints the length of the password. The echo -e command prints the string "Password length: " followed by a newline. The echo -n command prints the password without a newline, and wc -c counts the number of characters in the password.
echo -e "Password length: " && echo -n "$password" | wc -c
