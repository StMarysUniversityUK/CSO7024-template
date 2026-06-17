# Starter Terraform configuration for lab 4.2.
# This is the "before" state you build on. Follow the brief to plan, apply,
# change and destroy. You will refactor this into a module in lab 4.3.

terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

variable "length" {
  description = "Number of words in the generated pet name."
  type        = number
  default     = 2
}

resource "random_pet" "name" {
  length = var.length
}

resource "local_file" "hello" {
  filename = "${path.module}/hello.txt"
  content  = "Hello from ${random_pet.name.id}\n"
}

output "pet_name" {
  description = "The generated pet name."
  value       = random_pet.name.id
}
