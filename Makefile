VERSION=13

build:
	docker build -t code202/postgres:$(VERSION) .