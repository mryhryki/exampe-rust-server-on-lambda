FROM rust:1-slim-buster as builder
WORKDIR /app

COPY ./Cargo.toml /app/Cargo.toml
COPY ./Cargo.lock /app/Cargo.lock
COPY ./src /app/src
RUN cargo build --release

FROM debian:buster-slim

# https://aws.amazon.com/jp/builders-flash/202301/lambda-web-adapter/
COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.5.0 /lambda-adapter /opt/extensions/lambda-adapter

WORKDIR /app
COPY --from=builder "/app/target/release/example-rust-server-on-lambda" "/app/example-rust-server-on-lambda"
EXPOSE 8080
ENTRYPOINT ["/app/example-rust-server-on-lambda"]
