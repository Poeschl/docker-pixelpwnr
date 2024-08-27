FROM alpine:3.20 as build

WORKDIR /opt

RUN apk add --no-cache \
    git=2.45.2-r0 \
    ca-certificates=20240705-r0 \
    ruby=3.3.3-r0 \
    cargo=1.78.0-r0

ENV COMMIT_SHA '38ce0f0c43b5072e35c19048dbe12301614f25ca'
RUN --mount=type=cache,target=/usr/local/cargo/registry/ --mount=type=cache,target=/opt/pixelpwnr \
    git config --global advice.detachedHead false && \
    git clone https://github.com/timvisee/pixelpwnr.git -b master pixelpwnr && \
    cd pixelpwnr && \
    git checkout ${COMMIT_SHA} && \
    cargo build --release --verbose && \
    ls -al /opt/pixelpwnr/target/release \
    cp /opt/pixelpwnr/target/release/pixelpwnr /opt/pixelpwnr


FROM alpine:3.20

ENTRYPOINT ["pixelpwnr"]

RUN apk add --no-cache libgcc=13.2.1_git20240309-r0

COPY --from=build /opt/pixelpwnr /usr/local/bin/pixelpwnr
