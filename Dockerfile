FROM alpine:3.15 as build

WORKDIR /opt

RUN apk add --no-cache \
    git=2.34.1-r0 \
    ca-certificates=20211220-r0 \
    ruby=3.0.3-r0 \
    cargo=1.56.1-r0

ENV COMMIT_SHA '0d83b3e0b54448a59844e330a36f2e4b0e19e611'
RUN git config --global advice.detachedHead false && \
    git clone https://github.com/timvisee/pixelpwnr.git -b master pixelpwnr && \
    cd pixelpwnr && \
    git checkout ${COMMIT_SHA} && \
    cargo build --release && \
    ls -al /opt/pixelpwnr/target/release


FROM alpine:3.15

ENTRYPOINT ["pixelpwnr"]

RUN apk add --no-cache libgcc=10.3.1_git20211027-r0

COPY --from=build /opt/pixelpwnr/target/release/pixelpwnr /usr/local/bin/pixelpwnr
