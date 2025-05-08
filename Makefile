.PHONY: build up down migrate status

build:
	docker-compose build

up: build
	docker-compose up -d

down:
	docker-compose down -v

migrate:
	dbmate up

status:
	dbmate status
