#!/usr/bin/env python3
"""Smoke test for the lab 5.3 integrated pipeline.

After Terraform has provisioned the hosts and Ansible has configured nginx on
them, this checks that every host serves a page over HTTP. It reads the same
``terraform_outputs.json`` that the inventory generator uses, so it always
tests exactly the hosts that were created.

Run it from the ``ansible/`` directory (where the outputs file lives), or pass
the path explicitly:

    python ../tests/smoke_test.py
    python ../tests/smoke_test.py --outputs inventory/terraform_outputs.json

Exit code 0 means every host responded; non-zero means at least one failed,
which is what makes it useful as a CI gate.
"""
from __future__ import annotations

import argparse
import json
import sys
import urllib.request
from pathlib import Path

DEFAULT_OUTPUTS = Path("inventory/terraform_outputs.json")
TIMEOUT_SECONDS = 5


def load_hosts(outputs_path: Path) -> list[dict[str, str]]:
    if not outputs_path.exists():
        sys.exit(f"Could not find {outputs_path}. Run 'terraform apply' first.")
    data = json.loads(outputs_path.read_text())
    try:
        return data["hosts"]["value"]
    except (KeyError, TypeError):
        sys.exit("No 'hosts' output found in the Terraform outputs file.")


def check_host(host: dict[str, str]) -> bool:
    name = host.get("name", host["ip"])
    url = f"http://{host['ip']}/"
    try:
        with urllib.request.urlopen(url, timeout=TIMEOUT_SECONDS) as response:
            status = response.status
    except Exception as exc:  # noqa: BLE001 - any failure is a failed smoke test
        print(f"  FAIL {name} ({url}): {exc}")
        return False

    if status == 200:
        print(f"  OK   {name} ({url}): HTTP {status}")
        return True

    print(f"  FAIL {name} ({url}): HTTP {status}")
    return False


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--outputs",
        type=Path,
        default=DEFAULT_OUTPUTS,
        help=f"Path to terraform_outputs.json (default: {DEFAULT_OUTPUTS})",
    )
    args = parser.parse_args()

    hosts = load_hosts(args.outputs)
    print(f"Smoke testing {len(hosts)} host(s):")
    results = [check_host(host) for host in hosts]

    if all(results):
        print("All hosts responded.")
        sys.exit(0)

    failed = results.count(False)
    print(f"{failed} of {len(results)} host(s) failed.")
    sys.exit(1)


if __name__ == "__main__":
    main()
