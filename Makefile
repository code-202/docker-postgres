VERSION=18

build:
	docker build -t code202/postgres:$(VERSION) .
