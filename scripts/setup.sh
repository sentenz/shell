#!/bin/bash
#
# Install and configure all dependencies essential for development.

# -x: print a trace (debug)
# -u: treat unset variables
# -o pipefail: return value of a pipeline
set -uo pipefail

# Include Scripts

source ./../scripts/shell/pkg.sh

# Constant Variables

readonly -A APT_PACKAGES=(
  ["shellcheck"]=""
)

readonly -A PIP_PACKAGES=(
  ["ansible-core"]="2.18.4"
  ["ansible-lint"]="25.2.1"
  ["codespell"]="2.2.6"
  ["proselint"]="0.13.0"
  ["yamllint"]="1.35.1"
)

readonly -A NPM_PACKAGES=(
  ["bats"]="1.11.0"
  ["prettier"]="3.5.3"
  ["alex"]="11.0.0"
  ["prettier"]="3.2.5"
  ["jsonlint"]="1.6.3"
  ["gitlint"]="0.19.1"
  ["@commitlint/cli"]="19.2.1"
  ["@commitlint/config-conventional"]="19.1.0"
  ["@commitlint/format"]="19.0.3"
  ["markdownlint-cli2"]="0.12.1"
  ["markdown-link-check"]="3.12.1"
  ["semantic-release"]="23.0.2"
  ["@semantic-release/git"]="10.0.1"
  ["@semantic-release/changelog"]="6.0.3"
  ["@semantic-release/error"]="4.0.0"
  ["@semantic-release/exec"]="6.0.3"
  ["@semantic-release/commit-analyzer"]="11.1.0"
  ["@semantic-release/release-notes-generator"]="12.1.0"
  ["conventional-changelog-conventionalcommits"]="7.0.2"
  ["@semantic-release/github"]="10.0.2"
)

readonly -A GO_PACKAGES=(
  ["mvdan.cc/sh/v3/cmd/shfmt"]="3.8.0"
)

# Control Flow Logic

function setup() {
  local -i retval=0

  pkg_apt_install_list APT_PACKAGES
  ((retval |= $?))

  pkg_apt_clean
  ((retval |= $?))

  pkg_pip_install_list PIP_PACKAGES
  ((retval |= $?))

  pkg_pip_clean
  ((retval |= $?))

  pkg_npm_install_list NPM_PACKAGES
  ((retval |= $?))

  pkg_npm_clean
  ((retval |= $?))

  pkg_go_install_list GO_PACKAGES
  ((retval |= $?))

  return "${retval}"
}

setup
exit "${?}"
