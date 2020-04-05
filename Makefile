VERSION:=$(shell cat VERSION)
PROJECT=dummyrails


all: build

clean:
	docker-compose down

build:
	docker-compose build

run:
	docker-compose up web

console:
	docker-compose run web bundle exec rails c

setup-db:
	docker-compose run web rake db:create
	docker-compose run web bundle exec rails db:migrate
	docker-compose run web bundle exec rails db:seed
