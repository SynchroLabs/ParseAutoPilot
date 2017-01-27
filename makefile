MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail
.DEFAULT_GOAL := build

TAG?=latest

# Build the Docker containers
build: build-parse build-dashboard build-mongodb

build-parse:
	docker build -t synchro/parse_ap parse

build-dashboard:
	docker build -t synchro/parse_dashboard_ap parse-dashboard

build-mongodb:
	docker build -t synchro/mongodb_ap mongodb

# Start the composition on the local host
runlocal:
	docker-compose -f local-compose.yml up

tag:
	docker tag synchro/parse_ap synchro/parse_ap:${TAG}
	docker tag synchro/parse_dashboard_ap synchro/parse_dashboard_ap:${TAG}
	docker tag synchro/mongodb_ap synchro/mongodb_ap:${TAG}

# Push our images to the public registry
push:
	docker push "synchro/parse_ap:${TAG}"
	docker push "synchro/parse_ap:latest"
	docker push "synchro/parse_dashboard_ap:${TAG}"
	docker push "synchro/parse_dashboard_ap:latest"
	docker push "synchro/mongodb_ap:${TAG}"
	docker push "synchro/mongodb_ap:latest"
