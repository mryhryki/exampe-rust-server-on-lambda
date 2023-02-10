# exampe-rust-server-on-lambda


## Prepare

```shell
$ aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/mryhryki
```


## Build Docker

```shell
$ docker build --tag experimental:rust-server-on-lambda .

# Run
$ docker run --rm -p 3000:3000 experimental:rust-server-on-lambda
```