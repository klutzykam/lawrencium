# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx

FROM ghcr.io/bootcrew/arch-bootc:latest-amd64
COPY build_files /build/
COPY system_root /

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    --mount=type=cache,dst=/usr/lib/sysimage/cache/pacman/pkg \
    bash /build/build.sh

COPY --from=ghcr.io/ublue-os/brew:latest /system_files /
RUN --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /usr/bin/systemctl preset brew-setup.service && \
    /usr/bin/systemctl preset brew-update.timer && \
    /usr/bin/systemctl preset brew-upgrade.timer

RUN bootc container lint
