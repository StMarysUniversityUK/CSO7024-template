# Week 3 starter: Continuous Integration

This directory contains the starter workflow for labs 3.2 and 3.3.

- `.github/workflows/ci.yml` is a template with `TODO` markers.

## How to use it

The workflow runs against the shared application at the repository root
(`app/`). When you work in your own copy of the module template, copy or move
`ci.yml` to `.github/workflows/ci.yml` at the **root** of your repository so
GitHub Actions discovers it. A workflow only runs from the repository root, not
from a subdirectory.

Complete the `TODO` markers as directed by the briefs:

- **Lab 3.2** builds the lint, test and cache stages.
- **Lab 3.3** adds the packaging stage and branch protection.
