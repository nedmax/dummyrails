VERSION:=$(shell cat VERSION)
PROJECT=dummyrails
REPO=nedmax
IMAGE=${REPO}/${PROJECT}:${VERSION}

all: build

clean:
	docker-compose down

clean-all: clean
	kubectl delete -f kubernetes

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

restart-k8s:
	kubectl set env deployment dummyrails DEPLOY_DATE="$(date)"

setup-k8s:
	kubectl apply -f kubernetes
	sleep 30
	kubectl exec -ti deploy/dummyrails rake db:create
	kubectl set env deployment dummyrails DEPLOY_DATE="$(date)"
	sleep 30
	kubectl exec -ti deploy/dummyrails rails db:migrate
	kubectl set env deployment dummyrails DEPLOY_DATE="$(date)"
	sleep 30
	kubectl exec -ti deploy/dummyrails rails db:seed

push: build
	# $(DOCKER_LOGIN_CMD)
	docker tag ${PROJECT}_web:latest ${IMAGE}
	docker push ${IMAGE}

deploy: build push

test:
	docker-compose run web rake test
