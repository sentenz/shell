#!/bin/bash
#
# SPDX-License-Identifier: Apache-2.0
#
# Setup the testing environment.

# -x: print a trace (debug)
# -u: treat unset variables
# -o pipefail: return value of a pipeline
set -uo pipefail

# Include Scripts

source ./../internal/pkg.sh

# Constant Variables

readonly -A NPM_PACKAGES=(
  ["bats"]="1.11.0"
)

# Control Flow Logic

function setup_testing() {
  local -i retval=0

  pkg_npm_install_list NPM_PACKAGES
  ((retval |= $?))

  pkg_npm_clean
  ((retval |= $?))

  return "${retval}"
}

setup_testing
exit "${?}"
