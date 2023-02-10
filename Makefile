DOCKER_TAG     := experimental:example-rust-server-on-lambda
AWS_ACCOUNT_ID  = $(shell aws sts get-caller-identity | jq -r ".Account")
ECR_URI         = "${AWS_ACCOUNT_ID}.dkr.ecr.ap-northeast-1.amazonaws.com/${DOCKER_TAG}"

deploy: push-image pulumi-up

pulumi-up: pulumi/node_modules
	cd ./pulumi/ && ECR_URI="${ECR_URI}" pulumi up

push-image: build
	docker tag "${DOCKER_TAG}" "public.ecr.aws/mryhryki/${DOCKER_TAG}"
	docker push "${ECR_URI}"

run-local: build
	docker run --rm -p "3000:3000" "${DOCKER_TAG}"

build:
	printf "${DOCKER_TAG}" > .dockertag
	docker build --tag "${DOCKER_TAG}" .

pulumi/node_modules: pulumi/package.json pulumi/package-lock.json
	cd ./pulumi/ && npm ci
