BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
TAG := data4hub/fastlane:$(BRANCH)

build:
	docker pull ruby; \
	docker build -t ${TAG} .

clean:
	docker rmi ${TAG}

rebuild: clean build

release:
	clear
	bash -c 'export FASTLANE_VERSION=$$(docker run --rm -i $(TAG) --version); \
	export JAVA_VERSION=$$(docker run --rm -i --entrypoint java $(TAG) -version 2>&1); \
	export NODE_VERSION=$$(docker run --rm -i --entrypoint nodejs $(TAG) -v 2>&1); \
	export NPM_VERSION=$$(docker run --rm -i --entrypoint npm $(TAG) -v 2>&1); \
	export YARN_VERSION=$$(docker run --rm -i --entrypoint yarn $(TAG) --version 2>&1); \
	bash README.tpl > README.md'

run:    
	docker run --rm -it ${TAG}

publish:
	docker push ${TAG}

.PHONY: build
