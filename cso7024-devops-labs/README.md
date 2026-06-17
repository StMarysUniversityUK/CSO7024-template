# CSO7024 DevOps: Lab Repository

This is the starter repository for the hands-on labs in **CSO7024 DevOps**. It contains every lab brief for Weeks 2 to 6, the shared Python application you extend across the module, and the starter scaffolding (Terraform, Ansible, Docker, Kubernetes and continuous integration workflows) each lab builds on.

The repository is published as a **GitHub template**. You make one private copy at the start of the module and use it for every lab.

## Who this is for

CSO7024 is an MSc Computer Science conversion programme. The labs assume no prior DevOps experience and only light prior programming. Each brief introduces tools from first principles and expands every acronym on first use. If a step is unclear, that is a signal to ask your Associate Lecturer in the discussion forum, not a sign you are behind.

## Get your own copy

1. Open this repository on GitHub.
2. Click **Use this template**, then **Create a new repository**.
3. Give your copy a name, set the visibility to **Private** and create it.
4. Do **not** use the **Fork** button. A fork of a public repository is itself public, and your coursework should stay private.
5. Clone your new repository to your machine:

   ```bash
   git clone <your-repository-url>
   cd <your-repository-name>
   ```

Before your first lab, work through [`SETUP.md`](SETUP.md) to install Git and the other tools.

## What is in here

| Path | Contents |
|---|---|
| `SETUP.md` | Setting up your computer for the labs (one read, before Week 2). |
| `app/` | The shared Python application. From Week 3 onward each week builds on the same app, so your work compounds. |
| `labs/week2-version-control/` | Lab briefs 2.1 to 2.3 (Git fundamentals). |
| `labs/week3-cicd/` | Lab briefs 3.2 and 3.3, plus a continuous integration starter workflow. |
| `labs/week4-iac/` | Lab briefs 4.2 and 4.3, plus the local state backend script. |
| `labs/week5-config-mgmt/` | Lab briefs 5.2 and 5.3, plus Ansible, Terraform and pipeline scaffolding. |
| `labs/week6-containers/` | Lab briefs 6.1 to 6.3, plus Compose and Kubernetes scaffolding. |
| `docs/lab-brief-index.md` | One table mapping every lab brief to its week, lesson, time and learning outcome. |

The full index of lab briefs is in [`docs/lab-brief-index.md`](docs/lab-brief-index.md).

## How the labs fit together

The labs are a single thread, not five unrelated tool tutorials. You initialise a repository in Week 2, give it a tested continuous integration pipeline in Week 3, provision its infrastructure with Terraform in Week 4, configure that infrastructure with Ansible in Week 5 and finally package and orchestrate it with Docker and Kubernetes in Week 6. By the final week the same application has travelled the whole path from a local commit to a running, self-healing service.

```
Week 2  Git            initialise, branch, merge, pull request
Week 3  CI/CD          lint, test and package the app on every push
Week 4  IaC            provision infrastructure with Terraform
Week 5  Config mgmt    configure it with Ansible, wire the pipeline together
Week 6  Containers     containerise with Docker, orchestrate with Kubernetes
```

## A note on the shared application

`app/` holds a small Python application with a tiny calculator module and a test suite. It is deliberately simple so that the DevOps practices, rather than the application logic, stay in focus. Each week you add to it: a continuous integration workflow, a Dockerfile, infrastructure definitions and so on. Keeping one artefact across the whole module means your skills compound rather than reset each week.

## Working conventions

- Each week's lab uses a working directory named `~/devops-weekN` (for example `~/devops-week4`). The briefs assume that layout.
- The shared application carries rising version numbers as it evolves. Week 3 packages it as a Python wheel at version `0.1.0`. Week 6 containerises it: the image is tagged `cso7024-app:0.2` (Lessons 1 and 2) and then `cso7024-app:0.3` for the rolling update in Lesson 3.
- Secrets never go into Git. Every directory that needs one ships a `.env.example`; you copy it to `.env`, which is already listed in `.gitignore`.
- Lab work is individual and not submitted for grading, with one exception: the Week 3 pipeline is the foundation of Assessment 2. Keep screenshots of completed labs in your ePortfolio on Canvas.

## Licence

The teaching materials and starter code in this repository are released under the [MIT Licence](LICENSE) for use within the module. Third-party tools referenced in the labs (Git, Terraform, Ansible, Docker, Kubernetes and others) carry their own licences.
