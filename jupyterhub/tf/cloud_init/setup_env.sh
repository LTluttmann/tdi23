#!/bin/bash

NUM_ACCOUNTS=20

GIT_REPO="https://github.com/LTluttmann/tdi23.git"


# install jupyterhub
curl -L https://tljh.jupyter.org/bootstrap.py \
  | sudo python3 - \
    --admin tdi2023 --plugin git+https://github.com/LTluttmann/tljh-repo2user-dir.git


# add users
for ((n=0;n<$NUM_ACCOUNTS;n++))
do
 username="kims$n"
 sudo tljh-config add-item users.allowed $username
done


sudo tljh-config reload

# in this blog we the the environment variable for the repo to be cloned
# this is a bit messy. But actually the only way to change the environment variables
# of the root user
sudo mkdir /etc/systemd/system/jupyterhub.service.d 
sudo touch /etc/systemd/system/jupyterhub.service.d/override.conf
sudo tee -a /etc/systemd/system/jupyterhub.service.d/override.conf > /dev/null <<EOT
[Service]
Environment=REPO_URL="${GIT_REPO}"
EOT

sudo systemctl daemon-reload
sudo systemctl restart jupyterhub

