FROM alpine:3.13 as build

WORKDIR /opt

RUN apk add --no-cache \
    git=2.30.2-r0 \
    ca-certificates=20191127-r5 \
    ruby=2.7.3-r0 \
    cargo=1.47.0-r2

ENV COMMIT_SHA 'fd8f35639dfaefef83ccb752bdc20434d208f0a6'
RUN git config --global advice.detachedHead false && \
    git clone https://github.com/timvisee/pixelpwnr.git -b master pixelpwnr && \
    cd pixelpwnr && \
    git checkout ${COMMIT_SHA} && \
    cargo build --release && \
    ls -al /opt/pixelpwnr/target/release


FROM alpine:3.13

ENTRYPOINT ["pixelpwnr"]

RUN apk add --no-cache libgcc=10.2.1_pre1-r3

COPY --from=build /opt/pixelpwnr/target/release/pixelpwnr /usr/local/bin/pixelpwnr
