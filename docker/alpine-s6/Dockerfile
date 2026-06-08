FROM --platform=${BUILDPLATFORM} alpine AS builder

ARG TARGETPLATFORM
ARG S6_OVERLAY_VERSION=3.2.3.0

WORKDIR /s6

RUN apk add --no-cache tar xz curl

# build a URL to download S6 binaries
RUN echo "Downloading S6 Overlay ..." \
    && case "${TARGETPLATFORM}" in \
    linux/amd64) ARCH="x86_64" ;; \
    linux/arm/v7) ARCH="armhf" ;; \
    linux/arm64) ARCH="aarch64" ;; \
    *) echo "Unsupported target platform: ${TARGETPLATFORM}." && exit 1 ;; \
    esac \
    && printf "%s" "${ARCH}" > ARCH \
    && URL=https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay \
    && curl -L -sS ${URL}-${ARCH}.tar.xz -o /tmp/s6-overlay-${ARCH}.tar.xz \
    && curl -L -sS ${URL}-noarch.tar.xz -o /tmp/s6-overlay-noarch.tar.xz \
    && tar -C /s6 -Jxpf /tmp/s6-overlay-${ARCH}.tar.xz \
    && tar -C /s6 -Jxpf /tmp/s6-overlay-noarch.tar.xz

FROM alpine:latest

COPY --from=builder /s6 /
COPY etc/ /etc/

# base options
ENV PATH="${PATH}:/command"
ENV TZ=Etc/UTC

# s6 options
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

# crond options
ENV ENABLE_CRONTAB=0
ENV CRONTAB_OPTIONS="-d 5"

RUN apk upgrade --no-cache \
    && apk add --no-cache bash tzdata ca-certificates wget curl jq \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

ENTRYPOINT ["/init"]
