VERSION=11

build:
	docker build -t code202/postgres:$(VERSION) .
