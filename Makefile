NAME="mateuszdziurdziak/megacmd"

build:
	@docker build \
		--no-cache=true \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		-t $(NAME) \
		.

publish:
	@docker push $(NAME):latest