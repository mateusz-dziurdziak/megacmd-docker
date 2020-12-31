NAME="mateuszdziurdziak/megacmd"

build:
	@docker build \
		--no-cache=true \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		-t $(NAME) \
		-t $(NAME):`date -u +"%Y%m%dT%H%M%SZ"` \
		.

publish: publish-latest

publish-latest:
	@docker push $(NAME):latest
