# Tag der Informatik 2023

This repo contains some of the materials used in the "Introduction to Machine Learning" course tought on the "Tag der Informatik" hosted at Leuphana University in 2023.
More specifically, this repo contains: 
- the code to setup the jupyterhub environment on Azure cloud. 
- notebooks with example code and applications


To setup the TLJH instance, simply run 

```
terraform init
terraform plan -out "main.tfplan"
terraform apply "main.tfplan"
```

To enter the instance, enter the VMs IP on port 80 in the Browser. 

To install pip packages in all user environments, login as admin user to jupyterhub and install the packages via the terminal using sudo -E so they will be available to all users, e.g.:
```
sudo -E pip install numpy
```

The jupyterhub configuration uses the TLJH plugin [**tljh-repo2user-dir**](https://github.com/LTluttmann/tljh-repo2user-dir) which populates every users home directory with the materials of this repository.