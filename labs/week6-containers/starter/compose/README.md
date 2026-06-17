# Compose lab (6.2) layout

Assemble this lab under `~/devops-week6/compose-lab` by copying in two things: the
contents of this `starter/compose/` directory, and the shared application.

```bash
mkdir -p ~/devops-week6/compose-lab
cp -r <repo>/labs/week6-containers/starter/compose/. ~/devops-week6/compose-lab/
cp -r <repo>/app ~/devops-week6/compose-lab/app
```

The result:

```
compose-lab/
  docker-compose.yml   three services with TODO markers
  app/                 the shared application (copied in; the app service builds from here)
  db/
    init.sql           runs once to create a small schema
  proxy/
    nginx.conf         reverse proxy that forwards to the app service
  .env.example         template for the .env you create (DB_PASSWORD)
```

The `app` service builds from the local `app/` directory, so the lab is
self-contained and you can rebuild it in place when you change the code in Step 8.

## Steps

Follow the brief. In short: fill in the `app`, `db` and `proxy` services, copy
`.env.example` to `.env` and set `DB_PASSWORD`, then `docker compose up -d` and
confirm all three services are healthy.

## Two things worth knowing

The application image is built from `python:3.12-slim`, which does **not** include
`curl`. The app health check therefore uses Python, not `curl`, to call
`/health`. The starter already sets this up correctly.

The shared application uses only the Python standard library and does not itself
open a database connection. That keeps the image small and the focus on DevOps
rather than on a database driver. The compose file still wires up `DATABASE_URL`
and runs a real Postgres service with a persistent volume, so you can see service
discovery, health-gated start-up and volume persistence working. `DATABASE_URL`
and `LOG_LEVEL` are set on the app service for realism but the minimal app reads
only `PORT` and `GREETING`, so changing them has no visible effect yet. Making the
application actually read from and write to Postgres is the natural next step,
and the producer-consumer stretch goal in the brief builds directly on this
wiring.
