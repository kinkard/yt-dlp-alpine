# About

[yt-dlp](https://github.com/yt-dlp/yt-dlp) standalone binary for arm64 alpine linux.

Useful for small projects that use alpine and where downloading the whole python3 is not an option because of the size.

## Usage

```sh
docker run --rm -v $PWD:/downloads kinkard/yt-dlp-alpine [OPTIONS] URL [URL...]
```

- `-v $PWD:/downloads` mounts the current directory to `/downloads` in the container so that the downloaded files are saved on the host
- For yt-dlp options see [yt-dlp documentation](https://github.com/yt-dlp/yt-dlp?tab=readme-ov-file#usage-and-options)

For example, to download a video:

```sh
docker run --rm -v $PWD:/downloads kinkard/yt-dlp-alpine 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
```

or to download best quality audio:

```sh
docker run --rm -v $PWD:/downloads kinkard/yt-dlp-alpine -f 'ba[abr>0][vcodec=none]/best' 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
```

## Use in docker images

Alternatively, you can use that binary directly in your alpine image

```dockerfile
# ...

FROM alpine as runtime
COPY --from=kinkard/yt-dlp-alpine:latest /usr/local/bin/yt-dlp /usr/local/bin/yt-dlp

# now in `runtime` image you can use `yt-dlp` binary
```
