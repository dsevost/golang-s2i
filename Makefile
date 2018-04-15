#
#
#

all: build-docker build-test

.PHONY: build-docker
build-docker:
	docker build -t golang-s2i --build-arg YUM=dnf .

.PHONY: build-test
build-test:
	s2i build -e DEBUG=1 https://github.com/dsevost/golang-s2i \
	    --context-dir=test/test-app golang-s2i golang-s2i-test

.PHONY: test
test:
	docker run -d -p 8080:8080 --name golang-s2i-test-container golang-s2i-test
	curl http://127.0.0.1:8080

.PHONY: test-stop
test-stop:
	docker kill golang-s2i-test-container || true
	docker rm golang-s2i-test-container
