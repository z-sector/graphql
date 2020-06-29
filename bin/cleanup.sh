#!/bin/bash

echo ">>> $(basename ${BASH_SOURCE[0]})"

set -o errexit
set -o pipefail
set -o nounset



# INIT WORKING DIR
# ======================================================================================================
cd "$(dirname "${BASH_SOURCE[0]}")" && cd ../
CWD="$(pwd)"



# INSTALL PACKAGES
# ===================================================

pipenv clean


# INSTALL GIT-HOOKS
# ===================================================

# pre-commit
cd "${CWD}"
cp -f "${CWD}/bin/git.hook.pre-commit.sh" "${CWD}/.git/hooks/pre-commit"
chmod +x "${CWD}/.git/hooks/pre-commit"

# pre-push
cd "${CWD}"
cp -f "${CWD}/bin/git.hook.pre-push.sh" "${CWD}/.git/hooks/pre-push"
chmod +x "${CWD}/.git/hooks/pre-push"


echo ">>> $(basename ${BASH_SOURCE[0]}) DONE"
