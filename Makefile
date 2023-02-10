DOCKER_TAG  := experimental:example-rust-server-on-lambda

deploy: push-image pulumi-up

pulumi-up: pulumi/node_modules
	cd ./pulumi/ && pulumi up

push-image: build
	docker tag "${DOCKER_TAG}" "public.ecr.aws/mryhryki/${DOCKER_TAG}"
	docker push "public.ecr.aws/mryhryki/${DOCKER_TAG}"

run-local: build
	docker run --rm -p "3000:3000" "${DOCKER_TAG}"

build:
	printf "${DOCKER_TAG}" > .dockertag
	docker build --tag "${DOCKER_TAG}" .

pulumi/node_modules: pulumi/package.json pulumi/package-lock.json
	cd ./pulumi/ && npm ci
