"""A minimal HTTP application built on the standard library only.

It exposes two endpoints:
    GET /          a greeting (used to confirm the app is reachable)
    GET /health    a health check returning HTTP 200 (used by Docker,
                   Compose health checks and Kubernetes probes in Week 6)

Using only the standard library keeps the container image small and avoids
pinning a web framework that students would have to learn alongside DevOps.
The port is read from the PORT environment variable so the same image can be
configured differently in Compose and in Kubernetes.
"""

import os
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

from calculator import add

GREETING = os.environ.get("GREETING", "Hello, DevOps")
PORT = int(os.environ.get("PORT", "8000"))


class Handler(BaseHTTPRequestHandler):
    def _send(self, status: int, body: str) -> None:
        payload = body.encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Content-Length", str(len(payload)))
        self.end_headers()
        self.wfile.write(payload)

    def do_GET(self) -> None:
        if self.path == "/health":
            self._send(200, "ok")
        elif self.path == "/":
            # A trivial use of the calculator module so it is exercised at runtime.
            self._send(200, f"{GREETING} (1 + 1 = {add(1, 1)})\n")
        else:
            self._send(404, "not found\n")

    def log_message(self, fmt: str, *args) -> None:
        # Keep the default access log but route it through stdout so container
        # log collectors pick it up.
        print("%s - %s" % (self.address_string(), fmt % args))


def main() -> None:
    server = ThreadingHTTPServer(("0.0.0.0", PORT), Handler)
    print(f"Listening on 0.0.0.0:{PORT}")
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        server.shutdown()


if __name__ == "__main__":
    main()
