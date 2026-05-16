# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx

FROM ghcr.io/bootcrew/arch-bootc:latest-amd64
COPY build_files /build/
COPY system_root /

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    bash /build/build.sh

RUN bootc container lint
