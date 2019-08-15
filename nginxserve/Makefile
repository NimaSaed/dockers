DOCKER ?= /usr/bin/docker
TAG_IMAGE ?= nimasaed/nginxserve

.PHONY: all clean build test

all: clean build test

clean:
	$(DOCKER) rmi -f $(TAG_IMAGE)

build:
	$(DOCKER) build -t $(TAG_IMAGE) .

test:
	$(DOCKER) images | grep -q "^$(TAG_IMAGE) " || ( echo No nginxserve image. && exit 1)
	$(DOCKER) run --rm -d --name nginxserve -p 80:80 -p 443:443 -v "$(pwd):/srv/data" $(TAG_IMAGE)
	sleep 1
	curl localhost || echo "test faild"
	$(DOCKER) kill nginxserve
