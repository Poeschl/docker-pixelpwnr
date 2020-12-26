FROM alpine:3.12 as build

WORKDIR /opt

RUN apk --update add --no-cache \
    git=2.26.2-r0 \
    ca-certificates=20191127-r4 \
    ruby=2.7.1-r3 \
    cargo=1.44.0-r0

ENV COMMIT_SHA 'fd8f35639dfaefef83ccb752bdc20434d208f0a6'
RUN git clone https://github.com/timvisee/pixelpwnr.git -b master pixelpwnr && \
    cd pixelpwnr && \
    git checkout ${COMMIT_SHA} && \
    cargo build --release
RUN ls -al /opt/pixelpwnr/target/release


FROM alpine:3.12

ENTRYPOINT ["pixelpwnr"]

RUN apk --update add --no-cache libgcc=9.3.0-r2

COPY --from=build /opt/pixelpwnr/target/release/pixelpwnr /usr/local/bin/pixelpwnr
