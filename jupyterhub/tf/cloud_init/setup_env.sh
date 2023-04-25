#!/bin/bash

# need to install GitPython in the right environment, 
# thus explicitly name it here
sudo /opt/tljh/hub/bin/python -m pip install GitPython

# curl the python hook file for cloning repo in user spaces
sudo curl -L https://raw.githubusercontent.com/LTluttmann/tdi23/main/jupyterhub/hooks/clone_repo_hook.py > hook.py
sudo mv hook.py /opt/tljh/config/jupyterhub_config.d/

