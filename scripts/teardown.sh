#!/bin/bash
#
# Remove development artifacts and restore the host to its pre-setup state.

# -x: print a trace (debug)
# -u: treat unset variables
# -o pipefail: return value of a pipeline
set -uo pipefail

# Include Scripts

source ./../scripts/shell/pkg.sh

# Constant Variables

readonly -A NPM_PACKAGES=(
  ["bats"]=""
  ["prettier"]=""
  ["alex"]=""
  ["prettier"]=""
  ["jsonlint"]=""
  ["gitlint"]=""
  ["@commitlint/cli"]=""
  ["@commitlint/config-conventional"]=""
  ["@commitlint/format"]=""
  ["markdownlint-cli2"]=""
  ["markdown-link-check"]=""
  ["semantic-release"]=""
  ["@semantic-release/git"]=""
  ["@semantic-release/changelog"]=""
  ["@semantic-release/error"]=""
  ["@semantic-release/exec"]=""
  ["@semantic-release/commit-analyzer"]=""
  ["@semantic-release/release-notes-generator"]=""
  ["conventional-changelog-conventionalcommits"]=""
  ["@semantic-release/github"]=""
)

readonly -A PIP_PACKAGES=(
  ["ansible-core"]=""
  ["ansible-lint"]=""
  ["codespell"]=""
  ["proselint"]=""
  ["yamllint"]=""
)

readonly -A APT_PACKAGES=(
  ["shellcheck"]=""
  ["make"]=""
  ["git"]=""
  ["jq"]=""
  ["bash"]=""
  ["ca-certificates"]=""
  ["snapd"]=""
  ["python3-pip"]=""
  ["npm"]=""
)

# Control Flow Logic

function teardown() {
  # NOTE Use reversed order of `bootstrap.sh` and `setup.sh` scripts for tearing down the environment

  local -i retval=0

  pkg_npm_uninstall_list NPM_PACKAGES
  ((retval |= $?))

  pkg_npm_clean
  ((retval |= $?))

  pkg_pip_uninstall_list PIP_PACKAGES
  ((retval |= $?))

  pkg_pip_clean
  ((retval |= $?))

  pkg_apt_uninstall_list APT_PACKAGES
  ((retval |= $?))

  pkg_apt_clean
  ((retval |= $?))

  return "${retval}"
}

teardown
exit "${?}"
