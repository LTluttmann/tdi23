#!/bin/bash

getLastName() {
    echo $1 | rev | cut -d " "  -f 1 | rev
}

toLower() {
        echo $1 | tr '[:upper:]' '[:lower:]'
}


# names=("Marie Stoltenberg" "Tom Peters" "Heiko Westermann")
names_string = ${names_file}

for name in "${names[@]}"
do
        lname=$(getLastName "${name}")
        firstChar="${name:0:1}"
        username="${firstChar}${lname}"
        username=$(toLower $username)
        sudo tljh-config add-item users.allowed $username
done

sudo tljh-config reload