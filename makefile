MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail
.DEFAULT_GOAL := build

TAG?=latest

# Build the Docker containers
build: build-nginx build-parse build-dashboard build-mongodb build-redis

build-nginx:
	docker build -t synchro/parse_nginx_ap nginx

build-parse:
	docker build -t synchro/parse_ap parse

build-dashboard:
	docker build -t synchro/parse_dashboard_ap parse-dashboard

build-redis:
	docker build -t synchro/parse_redis_ap redis

build-mongodb:
	docker build -t synchro/parse_mongodb_ap mongodb

triton.env:
	./setup.sh

# Start the composition on Triton
runtriton: triton.env
	$(eval include triton.env)
	$(eval export $(shell sed 's/=.*//' triton.env))
	docker-compose -f triton-compose.yml up

tag:
	docker tag synchro/parse_ap synchro/parse_ap:${TAG}
	docker tag synchro/parse_dashboard_ap synchro/parse_dashboard_ap:${TAG}
	docker tag synchro/parse_nginx_ap synchro/parse_nginx_ap:${TAG}
	docker tag synchro/parse_redis_ap synchro/parse_redis_ap:${TAG}
	docker tag synchro/parse_mongodb_ap synchro/parse_mongodb_ap:${TAG}

# Push our images to the public registry
push:
	docker push "synchro/parse_nginx_ap:${TAG}"
	docker push "synchro/parse_nginx_ap:latest"
	docker push "synchro/parse_ap:${TAG}"
	docker push "synchro/parse_ap:latest"
	docker push "synchro/parse_dashboard_ap:${TAG}"
	docker push "synchro/parse_dashboard_ap:latest"
	docker push "synchro/parse_mongodb_ap:${TAG}"
	docker push "synchro/parse_mongodb_ap:latest"
	docker push "synchro/parse_redis_ap:${TAG}"
	docker push "synchro/parse_redis_ap:latest"
