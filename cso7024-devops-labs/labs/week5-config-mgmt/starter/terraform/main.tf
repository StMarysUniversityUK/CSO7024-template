# Terraform configuration for lab 5.3.
#
# This creates three containerised "hosts" using the Docker provider, each
# running an SSH server, and writes their details to
# ../ansible/inventory/terraform_outputs.json so that generate_inventory.py
# can turn them into an Ansible inventory.
#
# This file is complete enough to apply as-is. Read it before you run it: the
# point of the lab is to understand how provisioning hands over to configuration.

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

provider "docker" {}

variable "host_count" {
  description = "Number of host containers to create."
  type        = number
  default     = 3
}

variable "ssh_user" {
  description = "User Ansible will connect as."
  type        = string
  default     = "devops"
}

# A minimal Ubuntu image with SSH and Python installed, built once and reused
# for every host container.
resource "docker_image" "target" {
  name = "cso7024-target:latest"
  build {
    context    = "${path.module}/docker"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "host" {
  count = var.host_count
  name  = "cso7024-host-${count.index + 1}"
  image = docker_image.target.image_id

  # Keep the container alive; SSH is started by the image's entrypoint.
  must_run = true

  # Publish each host's SSH port on a distinct host port for convenience.
  ports {
    internal = 22
    external = 2222 + count.index
  }
}

# Build the list of hosts that Ansible will configure.
locals {
  hosts = [
    for c in docker_container.host : {
      name = c.name
      ip   = c.network_data[0].ip_address
      user = var.ssh_user
    }
  ]
}

output "hosts" {
  description = "The provisioned hosts, consumed by generate_inventory.py."
  value       = local.hosts
}

# Write the outputs to where the inventory generator expects them. Running
# 'terraform apply' refreshes this file automatically.
resource "local_file" "outputs" {
  filename = "${path.module}/../ansible/inventory/terraform_outputs.json"
  content = jsonencode({
    hosts = {
      value = local.hosts
    }
  })
}
