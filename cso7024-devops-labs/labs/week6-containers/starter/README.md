# Week 6 starter: Containers

This starter supports all three Week 6 labs. Everything builds on the shared
application at the repository root (`app/`), the same code you have built on
since the Week 3 pipeline.

Work in `~/devops-week6`. Each lab uses its own sub-directory.

## Lab 6.1 — Your First Dockerfile

- `scripts/copy-app-into-lab.sh` copies the shared application into
  `~/devops-week6/docker-lab` so you can write your own Dockerfile alongside it.
- The reference Dockerfile is `app/Dockerfile` at the repository root. Write your
  own first, then compare.

## Lab 6.2 — A Multi-Container Deployment with Docker Compose

- `compose/` contains a `docker-compose.yml` with `TODO` markers, a Postgres
  init script in `db/`, an nginx reverse-proxy configuration in `proxy/` and a
  `.env.example`. Copy this directory to `~/devops-week6/compose-lab`.
- See `compose/README.md` for the layout and one deliberate simplification.

## Lab 6.3 — Deploy to Kubernetes

- `k8s/manifests/` contains stub `deployment.yaml`, `service.yaml` and
  `configmap.yaml`, each with `TODO` comments. Copy `k8s/` to
  `~/devops-week6/k8s-lab`.
- You need `kubectl` and a single-node cluster (k3s or minikube). See `SETUP.md`,
  section 8.

## Image tags used this week

| Tag | Where it comes from |
| --- | --- |
| `cso7024-app:0.2` | built in lab 6.1, pushed to the local registry as `localhost:5000/cso7024-app:0.2` |
| `cso7024-app:0.3` | a second build you make in lab 6.3 to demonstrate a rolling update |

(`0.1` was the wheel built by the Week 3 pipeline; the container work starts at
`0.2`.)
