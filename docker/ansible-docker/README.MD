## Ansible Image

```
FROM ubuntu:latest

# Update the package list and install dependencies
RUN apt-get update \
    && apt-get install -y \
        software-properties-common \
        python3 \
        python3-pip \
        sudo

# Install Ansible
RUN pip3 install ansible

# Clean up to reduce image size
RUN apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create user 'ansible' and set password to 'ansible'
RUN useradd -m -s /bin/bash ansible \
    && echo "ansible:ansible" | chpasswd

# Make 'ansible' user a root user
RUN usermod -aG sudo ansible

# Set the working directory
WORKDIR /home/ansible

# Switch to the 'ansible' user by default
USER ansible

# Run a shell by default
CMD ["/bin/bash"]
```

docker network create -d bridge ansible_network

docker run -it --network=ansible_network ansible-docker

docker run -it --network=ansible_network ubuntu

apt install -y iproute2
apt install -y openssh-server

apt-get install -y iputils-ping
service ssh start
