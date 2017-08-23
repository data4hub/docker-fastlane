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
	bash README.tpl > README.md'

run:    
	docker run --rm -it ${TAG}

publish:
	docker push ${TAG}

.PHONY: build
