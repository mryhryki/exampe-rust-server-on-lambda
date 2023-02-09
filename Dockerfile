FROM rust:1-slim-buster
WORKDIR /app

COPY ./Cargo.toml /app/Cargo.toml
COPY ./Cargo.lock /app/Cargo.lock
COPY ./src /app/src
RUN cargo build --release

EXPOSE 3000
ENTRYPOINT ["/app/target/release/exampe-rust-server-on-lambda"]
