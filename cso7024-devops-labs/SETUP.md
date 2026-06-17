# Setting Up Your Computer for the Labs

Work through this guide once, before the Week 2 labs. It installs the tools you need for the whole module. You do not need to install everything at once: each section says which week first needs it, so you can install just-in-time if you prefer.

The labs are written for macOS, Linux and Windows. On Windows we strongly recommend the **Windows Subsystem for Linux (WSL2)** with Ubuntu, because every command in the briefs is written for a Unix-style shell.

## At a glance

| Tool | First needed | Check it is installed |
|---|---|---|
| Git | Week 2 | `git --version` |
| A GitHub account | Week 2, Lesson 3 | sign in at github.com |
| Python 3.12+ | Week 3 | `python3 --version` |
| Docker | Week 5 and Week 6 | `docker --version` |
| Terraform | Week 4 | `terraform version` |
| Ansible 2.16+ | Week 5 | `ansible --version` |
| kubectl and a local cluster (k3s or minikube) | Week 6 | `kubectl version` |

## 1. A terminal

Every lab runs in a terminal.

- **macOS:** use the built-in **Terminal** app, or [iTerm2](https://iterm2.com/).
- **Linux:** use your distribution's terminal.
- **Windows:** install **WSL2** with Ubuntu by opening PowerShell as Administrator and running `wsl --install`, then restart. Open **Ubuntu** from the Start menu and run all lab commands there.

## 2. Git (Week 2)

- **macOS:** `brew install git` (install [Homebrew](https://brew.sh/) first if needed), or install the Xcode Command Line Tools with `xcode-select --install`.
- **Linux or WSL2:** `sudo apt update && sudo apt install -y git`.
- **Windows (without WSL2):** download [Git for Windows](https://git-scm.com/download/win) and use Git Bash.

Confirm: `git --version` should print a version number.

Set your identity once, so commits are attributed correctly:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## 3. A GitHub account (Week 2, Lesson 3)

Create a free account at [github.com](https://github.com/) if you do not have one. You first need it in Week 2, Lesson 3, when you push a branch and open a pull request.

Set up authentication so you can push from the command line without typing a password each time. The simplest route is the [GitHub CLI](https://cli.github.com/): install it, then run `gh auth login` and follow the prompts. Alternatively, add an [SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh).

## 4. Python 3.12 or later (Week 3)

- **macOS:** `brew install python@3.12`.
- **Linux or WSL2:** `sudo apt install -y python3 python3-venv python3-pip`.
- **Windows (without WSL2):** download from [python.org](https://www.python.org/downloads/) and tick **Add Python to PATH** during installation.

Confirm: `python3 --version` should report 3.12 or later.

You create a fresh virtual environment per project in the briefs, so there is nothing global to install now.

## 5. Docker (Weeks 5 and 6)

Install **Docker Desktop** (macOS and Windows) or **Docker Engine** (Linux):

- **macOS and Windows:** [Docker Desktop](https://www.docker.com/products/docker-desktop/). On Windows, enable the WSL2 integration in Docker Desktop settings so `docker` works inside Ubuntu.
- **Linux:** follow the [Docker Engine install guide](https://docs.docker.com/engine/install/) for your distribution, then add yourself to the `docker` group so you do not need `sudo`.

Confirm: `docker --version` and `docker run hello-world`.

## 6. Terraform (Week 4)

Install Terraform from HashiCorp:

- **macOS:** `brew tap hashicorp/tap && brew install hashicorp/tap/terraform`.
- **Linux or WSL2:** follow the [official apt instructions](https://developer.hashicorp.com/terraform/install).
- **Windows (without WSL2):** download the binary and add it to your PATH.

Confirm: `terraform version`. The Week 4 labs use only the `local` and `random` providers, which run entirely on your machine, so you do not need a cloud account.

## 7. Ansible 2.16 or later (Week 5)

Ansible runs on the control machine only (it is agentless), so you install it on your own computer.

- **macOS:** `brew install ansible`.
- **Linux or WSL2:** `python3 -m pip install --user "ansible>=10"` (the Ansible community package that bundles ansible-core 2.16+).

Confirm: `ansible --version` should report ansible-core 2.16 or later. The Week 5 labs target a container on your own machine, so no remote servers are required.

## 8. Kubernetes: kubectl plus a local cluster (Week 6)

You need the `kubectl` client and a single-node cluster. Either of the following works:

- **k3s** (Linux and WSL2): a lightweight Kubernetes distribution. Follow the [k3s quick-start](https://docs.k3s.io/quick-start).
- **minikube** (macOS, Windows and Linux): runs a cluster in a virtual machine or container. Follow the [minikube install guide](https://minikube.sigs.k8s.io/docs/start/).

Install `kubectl` from the [Kubernetes documentation](https://kubernetes.io/docs/tasks/tools/). Confirm with `kubectl version` (it should report a client version) and `kubectl get nodes` once your cluster is running (it should show a single `Ready` node).

## Troubleshooting

- **`command not found` after installing:** close and reopen your terminal so it picks up the updated PATH.
- **`permission denied` from Docker on Linux:** add yourself to the `docker` group with `sudo usermod -aG docker $USER`, then log out and back in.
- **A tool reports an old version:** you may have an older copy earlier in your PATH. Run `which <tool>` to see which one is being used.
- **Still stuck:** post in the module discussion forum with the exact command you ran and the full error message. Quoting the precise error is the single most useful thing you can do, and it is a transferable diagnostic habit you will use throughout the module.
