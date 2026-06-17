#!/usr/bin/env bash
#
# copy-app-into-lab.sh — copy the shared application into a Week 6 working
# directory so you can build and run it without editing the repository copy.
#
# The shared application lives at the repository root in app/ and is the same
# code you have extended since Week 2. Labs 6.1, 6.2 and 6.3 all build on it.
#
# Usage, from the repository root or anywhere inside the repo:
#   labs/week6-containers/starter/scripts/copy-app-into-lab.sh [target-subdir]
#
# Examples:
#   ... copy-app-into-lab.sh docker-lab     # for lab 6.1 (default)
#   ... copy-app-into-lab.sh compose-lab    # if you want a local copy for 6.2
#
set -euo pipefail

# Resolve the repository root from this script's location so it works wherever
# it is called from.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../../../.." && pwd)"
APP_SRC="${REPO_ROOT}/app"

TARGET_SUBDIR="${1:-docker-lab}"
WORK_ROOT="${HOME}/devops-week6"
TARGET="${WORK_ROOT}/${TARGET_SUBDIR}"

if [[ ! -d "${APP_SRC}" ]]; then
  echo "Could not find the shared app at ${APP_SRC}." >&2
  exit 1
fi

mkdir -p "${TARGET}"

# Copy the application sources but not caches or virtual environments.
cp "${APP_SRC}/app.py" "${APP_SRC}/calculator.py" "${APP_SRC}/requirements.txt" "${TARGET}/"
cp "${APP_SRC}/Dockerfile" "${TARGET}/Dockerfile.reference"

cat <<INFO
Copied the shared application into:
  ${TARGET}

Files:
  app.py, calculator.py, requirements.txt
  Dockerfile.reference   (the reference Dockerfile; write your own as Dockerfile first)

Next:
  cd ${TARGET}
  # then follow lab 6.1 from Step 1
INFO
