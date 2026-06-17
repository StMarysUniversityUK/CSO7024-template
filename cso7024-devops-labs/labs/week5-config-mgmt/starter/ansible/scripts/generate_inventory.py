#!/usr/bin/env python3
"""Build an Ansible inventory from Terraform outputs.

Lab 5.3 wires provisioning to configuration. Terraform creates three host
containers and writes their details to ``inventory/terraform_outputs.json``;
this script reads that file and writes ``inventory/inventory.ini`` so the
Ansible step configures exactly the hosts the Terraform step created.

Run it from the ``ansible/`` directory after ``terraform apply``:

    python scripts/generate_inventory.py

The expected shape of terraform_outputs.json is the standard
``terraform output -json`` format, with a ``hosts`` output that is a list of
objects, each with ``name``, ``ip`` and ``user`` keys. The Terraform
configuration in ``terraform/`` is already set up to produce this.
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

# Paths are relative to the ansible/ directory, which is where the brief tells
# you to run this script from.
OUTPUTS_FILE = Path("inventory/terraform_outputs.json")
INVENTORY_FILE = Path("inventory/inventory.ini")


def load_hosts(outputs_path: Path) -> list[dict[str, str]]:
    """Return the list of hosts from a terraform output -json file."""
    if not outputs_path.exists():
        sys.exit(
            f"Could not find {outputs_path}. Run 'terraform apply' first so that "
            "Terraform writes its outputs."
        )

    data = json.loads(outputs_path.read_text())

    # terraform output -json wraps each output as {"value": ..., "type": ...}.
    try:
        hosts = data["hosts"]["value"]
    except (KeyError, TypeError):
        sys.exit(
            "The outputs file does not contain a 'hosts' output. Check the "
            "Terraform configuration in terraform/."
        )

    if not hosts:
        sys.exit("The 'hosts' output is empty. Did 'terraform apply' succeed?")

    return hosts


def render_inventory(hosts: list[dict[str, str]]) -> str:
    """Render an INI inventory with a single web_servers group."""
    lines = ["[web_servers]"]
    for host in hosts:
        name = host.get("name", host["ip"])
        lines.append(
            f"{name} ansible_host={host['ip']} ansible_user={host['user']} "
            "ansible_ssh_common_args='-o StrictHostKeyChecking=no'"
        )
    lines.append("")  # trailing newline
    return "\n".join(lines)


def main() -> None:
    hosts = load_hosts(OUTPUTS_FILE)
    INVENTORY_FILE.parent.mkdir(parents=True, exist_ok=True)
    INVENTORY_FILE.write_text(render_inventory(hosts))
    print(f"Wrote {INVENTORY_FILE} with {len(hosts)} host(s):")
    for host in hosts:
        print(f"  - {host.get('name', host['ip'])} ({host['ip']})")


if __name__ == "__main__":
    main()
