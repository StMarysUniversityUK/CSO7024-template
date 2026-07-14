# Week 5 starter: Configuration Management

This starter supports two labs.

## Lab 5.2 — Your First Ansible Playbook

- `scripts/start-lab-container.sh` launches a single Ubuntu target container with SSH
  enabled and prints the address and user to put in your inventory.
- `ansible/roles/web/` is a role stub you only need for the stretch goal.

Work in `~/devops-week5`. You write your own `inventory.ini`, `site.yml` and
`index.html` as described in the brief.

## Lab 5.3 — An Integrated Provision-then-Configure Pipeline

The wiring for the integrated pipeline is pre-stubbed. Your job is to connect the parts
and fill in the `TODO` markers, not to write everything from scratch.

- `terraform/` is a Docker-provider configuration that creates three host containers and
  writes its outputs to `../ansible/inventory/terraform_outputs.json`.
- `ansible/site.yml` and the `web` role install nginx on each host.
- `ansible/scripts/generate_inventory.py` turns the Terraform outputs into
  `ansible/inventory/inventory.ini`.
- `tests/smoke_test.py` checks that every host responds.
- `.github/workflows/deploy.yml` orchestrates the whole sequence and contains the
  `TODO` markers you complete. GitHub Actions only runs it when it sits at
  `.github/workflows/deploy.yml` at the **root** of the repository, so
  if its not already there, move it when you assemble your working copy.

Everything runs locally through Docker: no cloud account is required.

## Tooling

You need Docker, Terraform and Ansible available on your machine. The module's setup
guide covers installing them. Confirm each is on your `PATH` before you start:

```bash
docker --version
terraform --version
ansible --version
```
