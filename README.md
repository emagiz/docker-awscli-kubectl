# docker-awscli-kubectl
Used for deploying to kubernetes running on aws using aws authentication.
Create with googling howto install various packages on our base jdk image based on ubuntu (currently focal)
The following links have been used:
- Base image is 
- https://docs.docker.com/engine/install/ubuntu/
- https://linuxize.com/post/how-to-install-pip-on-ubuntu-20.04/
- https://docs.aws.amazon.com/cli/v1/userguide/install-windows.html
- https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

# Files
- *Dockerfile* - the build process for the docker file
- *docker-build.bat* - trigger the build process and deploy to github **(as argument needs the version)**

# Destination
The images end up in docker hub in the eMagiz account: https://hub.docker.com/repository/docker/emagiz/docker-awscli-kubectl/
