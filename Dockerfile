FROM kinkard/pyinstaller-alpine as builder

# Unfortunately, we can't pass our Dockerfile to the yt-dlp repo context,
# and `ADD` just doesn't work, so there is nothing else we can do but clone the repo
WORKDIR /usr/src
RUN apk add --no-cache git gcc musl-dev
RUN git clone https://github.com/yt-dlp/yt-dlp.git
WORKDIR /usr/src/yt-dlp

# See https://github.com/yt-dlp/yt-dlp?tab=readme-ov-file#compile for more details
RUN python3 devscripts/install_deps.py --include pyinstaller
RUN python3 devscripts/make_lazy_extractors.py
# Pass explicit `--name` to avoid the difference between `yt-dlp_linux` and `yt-dlp_linux_aarch64`
RUN python3 -m bundle.pyinstaller --name=yt-dlp.bin

FROM alpine as runtime
RUN apk add --no-cache ffmpeg
COPY --from=builder /usr/src/yt-dlp/dist/yt-dlp.bin /usr/local/bin/yt-dlp
WORKDIR /downloads
ENTRYPOINT ["yt-dlp"]
