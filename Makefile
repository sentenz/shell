# SPDX-License-Identifier: Apache-2.0

ifneq (,$(wildcard .env))
	include .env
	export
endif

# Define Variables

SHELL := /bin/bash
SHELL_COMMAND = source
SHELL_FILE_CLI = $(@D)/internal/cli.sh

# Define Targets

default: help

help:
	@awk 'BEGIN {printf "Task\n\tA collection of tasks used in current project.\n\n"}'
	@awk 'BEGIN {printf "Usage\n\tmake $(shell tput -Txterm setaf 6)[target]$(shell tput -Txterm sgr0)\n\n"}' $(MAKEFILE_LIST)
	@awk '/^##/{c=substr($$0,3);next}c&&/^[[:alpha:]][[:alnum:]_-]+:/{print "$(shell tput -Txterm setaf 6)\t" substr($$1,1,index($$1,":")) "$(shell tput -Txterm sgr0)",c}1{c=0}' $(MAKEFILE_LIST) | column -s: -t
.PHONY: help

# Prompt for credentials and cache them for the current session
permission:
	@sudo -v
.PHONY: permission

## Initialize a software development workspace with requisites
bootstrap:
	@$(MAKE) -s permission
	cd $(@D)/scripts && chmod +x bootstrap.sh && ./bootstrap.sh
.PHONY: bootstrap

## Install and configure all dependencies essential for development
setup:
	@$(MAKE) -s permission
	cd $(@D)/scripts && chmod +x setup.sh && ./setup.sh
.PHONY: setup

## Remove development artifacts and restore the host to its pre-setup state
teardown:
	@$(MAKE) -s permission
	cd $(@D)/scripts && chmod +x teardown.sh && ./teardown.sh
.PHONY: teardown

## Setup the release environment
setup-release:
	cd $(@D)/scripts && chmod +x setup_release.sh && ./setup_release.sh
.PHONY: setup-release

## Perform the release analysis
release:
	$(SHELL_COMMAND) $(SHELL_FILE_CLI) && cli_semantic_release
.PHONY: release

## Workflow of the release process
workflow-release:
	$(MAKE) setup-release
	$(MAKE) release
.PHONY: pipeline-release
