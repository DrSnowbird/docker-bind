all: build

build:
	@docker build --tag=openkbs/bind .
