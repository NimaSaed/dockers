DOCKER ?= /usr/bin/docker
TAG_IMAGE ?= nimasaed/openvas

.PHONY: all clean build test

all: clean build

clean:
	$(DOCKER) rmi -f $(TAG_IMAGE)

build:
	$(DOCKER) build -t $(TAG_IMAGE) .

