#!/bin/bash

#retrieve information from the file
#will use counter as ID

counter=0

while [$counter -lt 50]; do
    let counter=counter+1

    name=$(nl users.txt | grep -w $counter | awk '{print $2}' | awk -F ',' '{print $1}')
    lastname=$(nl users.txt | grep -w $counter | awk '{print $2}' | awk -F ',' '{print $2}')
    age=$(shuf -i 18-99 -n 1)

#insert data to DB

    mysql -u root -p 1234 users -e "insert into user values ($counter, '$name', '$lastname', $age)"
    echo "$counter, $name $lastname, $age was correctly imported"
done