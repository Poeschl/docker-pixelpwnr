FROM alpine:3.9 as build

WORKDIR /opt

RUN apk -Uuv add git ca-certificates ruby cargo

ENV COMMIT_SHA 'b8fd77ebad8a890addfdefd95cabd96ce031cc54'
RUN git clone https://github.com/timvisee/pixelpwnr.git -b master pixelpwnr && \
    cd pixelpwnr && \
    git checkout ${COMMIT_SHA} && \
    cargo build --release
RUN ls -al /opt/pixelpwnr/target/release


FROM alpine:3.9
MAINTAINER Poeschl@users.noreply.github.com

ENTRYPOINT ["pixelpwnr"]

RUN apk -Uuv add libgcc && rm /var/cache/apk/*

COPY --from=build /opt/pixelpwnr/target/release/pixelpwnr /usr/local/bin/pixelpwnr
