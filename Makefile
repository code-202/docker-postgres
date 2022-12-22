VERSION=15

build:
	docker build -t code202/postgres:$(VERSION) .
