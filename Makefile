VERSION=17

build:
	docker build -t code202/postgres:$(VERSION) .
