DOCKER_CONTAINER=my-docker-1
DOCKER_IMAGE=my-docker

docker-stop:
	@docker rm --force $(DOCKER_CONTAINER) || echo -n "\n + Skipped!\n\n"

docker-clean: docker-stop
	@docker rmi $(DOCKER_IMAGE) || echo -n "\n + Skipped!\n\n"

docker-run: docker-stop
	@docker build --tag $(DOCKER_IMAGE):latest .
	@docker run \
--name $(DOCKER_CONTAINER) \
--network host \
--cpus 1 \
--memory 100m \
--env MY_ENV_VAR=my-env-var-value \
--add-host=myserver.orioltristany.com:127.0.0.1 \
--log-driver json-file \
--log-opt max-size=10k \
--log-opt max-file=2 \
--detach \
$(DOCKER_IMAGE):latest