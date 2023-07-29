FROM alpine:3.18 as build

WORKDIR /opt

RUN apk add --no-cache \
    git=2.40.1-r0 \
    ca-certificates=20230506-r0 \
    ruby=3.2.2-r0 \
    cargo=1.71.0-r0

ENV COMMIT_SHA 'b157c44871d6df01776112e29a564a1d9edddc37'
RUN git config --global advice.detachedHead false && \
    git clone https://github.com/timvisee/pixelpwnr.git -b master pixelpwnr && \
    cd pixelpwnr && \
    git checkout ${COMMIT_SHA} && \
    cargo build --release && \
    ls -al /opt/pixelpwnr/target/release


FROM alpine:3.18

ENTRYPOINT ["pixelpwnr"]

RUN apk add --no-cache libgcc=12.2.1_git20220924-r10

COPY --from=build /opt/pixelpwnr/target/release/pixelpwnr /usr/local/bin/pixelpwnr
