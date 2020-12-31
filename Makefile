NAME="mateuszdziurdziak/megacmd"

build:
	@docker build \
		--no-cache=true \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		-t $(NAME) \
		-t $(NAME):`date -u +"%Y%m%dT%H%M%SZ"` \
		.

publish: publish-latest publish-newest-tag

publish-latest:
	docker push $(NAME):latest

publish-newest-tag:
	tag = docker images | grep $(NAME) | grep -vE "<none>|latest" | head -n 1 | awk '{print $$1":"$$2}' | xargs --no-run-if-empty docker push
