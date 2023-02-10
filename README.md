# exampe-rust-server-on-lambda

## Prepare

```shell
# Check Node.js version
$ node --version
v16.x.x # or later. If you do not have Node.js installed, please visit https://nodejs.org/.

# Login Amazon ECR
$ aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/mryhryki
```

## How to deploy

```shell
$ make deploy
```
