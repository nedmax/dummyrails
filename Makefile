VERSION:=$(shell cat VERSION)
PROJECT=dummyrails


all: build

clean:
	docker-compose down

build:
	docker-compose build web

run:
	docker-compose up web

console:
	docker-compose run web bundle exec rails c
