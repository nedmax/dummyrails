VERSION:=$(shell cat VERSION)
PROJECT=dummyrails
REPO=nedmax
IMAGE=${REPO}/${PROJECT}:${VERSION}

#DOCKER_IMAGE_ID:=$(shell docker images -q ${IMAGE})
DOCKER_LOGIN_CMD:=$(shell docker login)


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

setup-k8s:
	kubectl apply -f kubernetes
	kubectl exec -ti deploy/dummyrails rake db:create

push: build
	# $(DOCKER_LOGIN_CMD)
	docker tag ${PROJECT}_web:latest ${IMAGE}
	docker push ${IMAGE}
