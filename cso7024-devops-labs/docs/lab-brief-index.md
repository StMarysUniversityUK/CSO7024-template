# Lab Brief Index

Every hands-on lab in CSO7024 DevOps, in order. Each brief is a standalone document; the table below maps it to its week, lesson, indicative time and the Weekly Learning Outcome (WLO) it supports. The "Source reference" column records where the brief is cited in the weekly module content.

## Weeks 2 to 6

| Brief | Title | Week | Lesson | Time | WLO | Source reference in week content |
|---|---|---|---|---|---|---|
| 2.1 | Your First Repository | 2 | 1 | 30 min | WLO1 | Inlined in Week 2 content (Do (Lab): Your First Repository) |
| 2.2 | Branching, Merging and a Three-Way Conflict | 2 | 2 | 40 min | WLO2, WLO3 | Inlined in Week 2 content |
| 2.3 | Rebase, Cherry-Pick and a Pull Request | 2 | 3 | 40 min | WLO2, WLO4 | Inlined in Week 2 content |
| 3.2 | Design and Write Your First CI Pipeline | 3 | 2 | 45 min | WLO2 | "the lab brief contains a starter template" (Week 3, Lesson 2) |
| 3.3 | Configure, Break and Fix a Real Pipeline | 3 | 3 | 45 min | WLO3 | Inlined in Week 3 content (Do (Lab): Configure, Break and Fix) |
| 4.2 | Your First Terraform Configuration | 4 | 2 | 45 min | WLO2 | `lab brief: 4.2 Lab: Your First Terraform Configuration.md` |
| 4.3 | Remote State, Environments and Drift | 4 | 3 | 45 min | WLO3 | `Lab brief: 4.3 Lab: Remote State, Workspaces and Drift.md` |
| 5.2 | Your First Ansible Playbook | 5 | 2 | 45 min | WLO2 | `lab brief: 5.2 Lab: Your First Ansible Playbook.md` |
| 5.3 | An Integrated Provision-then-Configure Pipeline | 5 | 3 | 45 min | WLO3 | `lab brief: 5.3 Lab: An Integrated Provision-then-Configure Pipeline.md` |
| 6.1 | Your First Dockerfile | 6 | 1 | 45 min | WLO2 | `lab brief: 6.1 Lab: Your First Dockerfile.md` |
| 6.2 | A Multi-Container Deployment with Docker Compose | 6 | 2 | 45 min | WLO2 | `lab brief: 6.2 Lab: A Multi-Container Deployment with Docker Compose.md` |
| 6.3 | Deploy to Kubernetes | 6 | 3 | 45 min | WLO3 | `lab brief: 6.3 Lab: Deploy to Kubernetes.md` |

## Notes

- **Week 1 has no lab.** It is the conceptual introduction to DevOps and is delivered through reading, video and reflection only.
- **Week 3, Lesson 1 has no lab.** Lesson 1 is conceptual; the hands-on work begins in Lesson 2.
- **Numbering follows the lesson it belongs to.** Brief `4.2` is the Week 4, Lesson 2 lab. This matches the micro-lecture numbering used in the week content (for example `4.2 Terraform Fundamentals`).
- **Title reconciliation for 4.3.** The Week 4 study plan and activity heading call this lab "Remote State, Environments and Drift", while the resource line cites the filename "Remote State, Workspaces and Drift". This repository uses **Environments** in the title, because the lab separates environments by directory rather than by Terraform workspaces. The discrepancy is flagged here so the module team can align the source content.
- **Supporting assets** (scripts, starter manifests and continuous integration workflows) live alongside the briefs in each week's `starter/` directory and are listed in each brief's "Before you start" section.

## Supporting starter assets

| Asset | Used by | Path |
|---|---|---|
| Shared Python application | Weeks 2 to 6 | `app/` |
| Continuous integration starter workflow | 3.2, 3.3 | `labs/week3-cicd/starter/.github/workflows/ci.yml` |
| Local state backend script | 4.3 | `labs/week4-iac/starter/scripts/start-state-backend.sh` |
| Terraform starter (local and random providers) | 4.2 | `labs/week4-iac/starter/` |
| Lab container start script | 5.2 | `labs/week5-config-mgmt/starter/scripts/start-lab-container.sh` |
| Inventory generator | 5.3 | `labs/week5-config-mgmt/starter/ansible/scripts/generate_inventory.py` |
| Integrated pipeline workflow | 5.3 | `labs/week5-config-mgmt/starter/.github/workflows/deploy.yml` |
| Smoke test | 5.3 | `labs/week5-config-mgmt/starter/tests/smoke_test.py` |
| Compose starter (app, database, proxy) | 6.2 | `labs/week6-containers/starter/compose/` |
| Kubernetes manifest stubs | 6.3 | `labs/week6-containers/starter/k8s/manifests/` |
| Copy-app helper | 6.1 | `labs/week6-containers/starter/scripts/copy-app-into-lab.sh` |
