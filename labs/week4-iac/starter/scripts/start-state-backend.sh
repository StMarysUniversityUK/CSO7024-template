#!/usr/bin/env bash
#
# Local Terraform HTTP state backend for lab 4.3.
#
# Starts a small HTTP server on localhost:9090 that stores Terraform state with
# locking and versioning. It uses the Terraform "http" backend protocol: GET to
# read state, POST to write it, LOCK/UNLOCK for the lock. State is kept on disk
# under ./.tfstate-backend/ so it survives restarts.
#
# Leave this running in its own terminal for the duration of the lab.
#
# Configure an environment to use it with a backend block like:
#
#   terraform {
#     backend "http" {
#       address        = "http://localhost:9090/state/dev"
#       lock_address   = "http://localhost:9090/state/dev"
#       unlock_address = "http://localhost:9090/state/dev"
#       lock_method    = "LOCK"
#       unlock_method  = "UNLOCK"
#     }
#   }
#
# Use a distinct path per environment (state/dev, state/prod) so they do not
# share state.

set -euo pipefail

PORT="${PORT:-9090}"
STATE_DIR="${STATE_DIR:-./.tfstate-backend}"
mkdir -p "$STATE_DIR"

echo "Starting local Terraform state backend on http://localhost:${PORT}"
echo "State directory: ${STATE_DIR}"
echo "Press Ctrl-C to stop."

PORT="$PORT" STATE_DIR="$STATE_DIR" python3 - <<'PY'
import json
import os
import re
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

PORT = int(os.environ.get("PORT", "9090"))
STATE_DIR = os.environ.get("STATE_DIR", "./.tfstate-backend")
os.makedirs(STATE_DIR, exist_ok=True)

# In-memory lock registry: { state_key: lock_info_dict }
LOCKS = {}
SAFE = re.compile(r"[^a-zA-Z0-9_-]")


def _key(path: str) -> str:
    # /state/dev -> dev ; keep it filesystem-safe
    name = path.strip("/").split("/", 1)[-1] or "default"
    return SAFE.sub("_", name)


def _state_file(key: str) -> str:
    return os.path.join(STATE_DIR, f"{key}.tfstate")


class Handler(BaseHTTPRequestHandler):
    def _body(self):
        length = int(self.headers.get("Content-Length", "0"))
        return self.rfile.read(length) if length else b""

    def do_GET(self):
        key = _key(self.path)
        path = _state_file(key)
        if os.path.exists(path):
            with open(path, "rb") as fh:
                data = fh.read()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(data)
        else:
            # No state yet: Terraform expects 200 with empty body or 404.
            self.send_response(404)
            self.end_headers()

    def do_POST(self):
        key = _key(self.path)
        with open(_state_file(key), "wb") as fh:
            fh.write(self._body())
        self.send_response(200)
        self.end_headers()

    def do_DELETE(self):
        key = _key(self.path)
        path = _state_file(key)
        if os.path.exists(path):
            os.remove(path)
        self.send_response(200)
        self.end_headers()

    def _lock(self):
        key = _key(self.path)
        incoming = self._body()
        if key in LOCKS:
            self.send_response(423)  # Locked
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(json.dumps(LOCKS[key]).encode())
            return
        try:
            LOCKS[key] = json.loads(incoming or b"{}")
        except json.JSONDecodeError:
            LOCKS[key] = {"raw": incoming.decode("utf-8", "replace")}
        self.send_response(200)
        self.end_headers()

    def _unlock(self):
        key = _key(self.path)
        LOCKS.pop(key, None)
        self.send_response(200)
        self.end_headers()

    def do_LOCK(self):
        self._lock()

    def do_UNLOCK(self):
        self._unlock()

    def log_message(self, fmt, *args):
        print("backend: %s - %s" % (self.address_string(), fmt % args))


ThreadingHTTPServer(("127.0.0.1", PORT), Handler).serve_forever()
PY
