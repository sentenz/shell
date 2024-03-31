#!/bin/bash
#
# SPDX-License-Identifier: Apache-2.0
#
# Setup the software analysis using linters.

# -x: print a trace (debug)
# -u: treat unset variables
# -o pipefail: return value of a pipeline
set -uo pipefail

# Include Scripts

source ./../internal/pkg.sh

# Constant Variables

readonly -A APT_PACKAGES=(
  ["shellcheck"]="0.8.0-2"
)

readonly -A PIP_PACKAGES=(
  ["codespell"]="2.2.6"
  ["proselint"]="0.13.0"
  ["yamllint"]="1.35.1"
)

readonly -A NPM_PACKAGES=(
  ["alex"]="11.0.0"
  ["prettier"]="3.2.5"
  ["jsonlint"]="1.6.3"
  ["gitlint"]="0.19.1"
  ["@commitlint/cli"]="19.2.1"
  ["@commitlint/config-conventional"]="19.1.0"
  ["@commitlint/format"]="19.0.3"
  ["markdownlint-cli2"]="0.12.1"
  ["markdown-link-check"]="3.12.1"
)

readonly -A GO_PACKAGES=(
  ["mvdan.cc/sh/v3/cmd/shfmt"]="3.8.0"
)

# Control Flow Logic

function setup_linter() {
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

setup_linter
exit "${?}"
