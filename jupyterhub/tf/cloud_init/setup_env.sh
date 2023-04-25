#!/bin/bash

# install jupyterhub
curl -L https://tljh.jupyter.org/bootstrap.py \
  | sudo python3 - \
    --admin tdi2023

# need to install GitPython in the right environment, 
# thus explicitly name it here
sudo /opt/tljh/hub/bin/python -m pip install GitPython

# curl the python hook file for cloning repo in user spaces
sudo curl -L https://raw.githubusercontent.com/LTluttmann/tdi23/main/jupyterhub/hooks/clone_repo_hook.py > hook.py
sudo mv hook.py /opt/tljh/config/jupyterhub_config.d/

# add users
getLastName() {
    echo $1 | rev | cut -d " "  -f 1 | rev
}

toLower() {
        echo $1 | tr '[:upper:]' '[:lower:]'
}

names_array=(
        "Marie Stoltenberg" 
        "Tom Peters" 
        "Heiko Westermann"
)

for name in "${names_array[@]}"
do
        lname=$(getLastName "${name}")
        firstChar="${name:0:1}"
        username="${firstChar}${lname}"
        username=$(toLower $username)
        sudo tljh-config add-item users.allowed $username
done

sudo tljh-config reload