# Image for the lab 5.3 "hosts": Ubuntu with SSH and Python so Ansible can
# connect and run modules. As with lab 5.2, password auth is enabled to keep
# the focus on the pipeline rather than on SSH key distribution. Do not use a
# pattern like this for anything real.
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq \
    && apt-get install -y -qq openssh-server python3 sudo \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/run/sshd \
    && useradd -m -s /bin/bash devops \
    && echo 'devops:devops' | chpasswd \
    && adduser devops sudo \
    && echo 'devops ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/devops \
    && sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
