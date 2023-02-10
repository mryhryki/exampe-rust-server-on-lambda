FROM rust:1-slim-buster as builder
WORKDIR /app

COPY ./Cargo.toml /app/Cargo.toml
COPY ./Cargo.lock /app/Cargo.lock
COPY ./src /app/src
RUN cargo build --release

FROM debian:buster-slim
WORKDIR /app
COPY --from=builder "/app/target/release/example-rust-server-on-lambda" "/app/example-rust-server-on-lambda"
EXPOSE 3000
ENTRYPOINT ["/app/example-rust-server-on-lambda"]
