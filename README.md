# README

Simple Ruby on Rails running on Kubernetes project.

## Requirements

- docker
- minikube
- make
- kubectl

## Setup

- Database creation

		make setup-db

- Kubernetes

 		make setup-k8s
		minikube service dummyrails

## Test

		make test


## Deployment instructions

		make deploy


## Local Development

		make run
