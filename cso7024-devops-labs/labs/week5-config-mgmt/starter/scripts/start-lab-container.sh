#!/usr/bin/env bash
#
# start-lab-container.sh — launch a single Ubuntu target for lab 5.2.
#
# This brings up one container with an SSH server running, creates a lab user
# with password login enabled and prints the address and user to put in your
# Ansible inventory. It is deliberately simple: a real target would use key-based
# auth and no password login, but for a first playbook this keeps the focus on
# Ansible rather than on SSH hardening.
#
# Usage:
#   ./start-lab-container.sh          # start (or restart) the container
#   ./start-lab-container.sh stop     # stop and remove it
#
set -euo pipefail

CONTAINER_NAME="cso7024-ansible-target"
IMAGE="ubuntu:22.04"
LAB_USER="devops"
LAB_PASSWORD="devops"          # demo only; never do this on a real host
SSH_PORT_ON_HOST="2222"

stop_container() {
  if docker ps -a --format '{{.Names}}' | grep -qx "${CONTAINER_NAME}"; then
    docker rm -f "${CONTAINER_NAME}" >/dev/null
    echo "Removed ${CONTAINER_NAME}."
  else
    echo "No container named ${CONTAINER_NAME} to remove."
  fi
}

if [[ "${1:-}" == "stop" ]]; then
  stop_container
  exit 0
fi

# Start clean so re-running the script is always safe.
stop_container

echo "Starting ${CONTAINER_NAME} from ${IMAGE}..."
docker run -d \
  --name "${CONTAINER_NAME}" \
  -p "${SSH_PORT_ON_HOST}:22" \
  "${IMAGE}" \
  sleep infinity >/dev/null

# Install and configure SSH inside the container.
docker exec "${CONTAINER_NAME}" bash -c "
  set -e
  export DEBIAN_FRONTEND=noninteractive
  apt-get update -qq
  apt-get install -y -qq openssh-server python3 sudo >/dev/null
  mkdir -p /var/run/sshd
  useradd -m -s /bin/bash ${LAB_USER}
  echo '${LAB_USER}:${LAB_PASSWORD}' | chpasswd
  adduser ${LAB_USER} sudo >/dev/null
  echo '${LAB_USER} ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/${LAB_USER}
  sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
  service ssh restart
" >/dev/null

CONTAINER_IP="$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "${CONTAINER_NAME}")"

cat <<INFO

Lab target is up.

  Container : ${CONTAINER_NAME}
  IP address: ${CONTAINER_IP}
  SSH user  : ${LAB_USER}
  Password  : ${LAB_PASSWORD}

Put the IP and user in your inventory.ini, for example:

  [web_servers]
  ${CONTAINER_IP} ansible_user=${LAB_USER} ansible_password=${LAB_PASSWORD} ansible_ssh_common_args='-o StrictHostKeyChecking=no'

Then check connectivity:

  ansible -i inventory.ini web_servers -m ping

When you are finished:

  ./start-lab-container.sh stop

INFO
