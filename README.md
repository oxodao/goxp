# GoXP

This repository builds a simple docker image with a Golang 1.24.4 version patched to work on Windows XP.

The maintainer of this patched version is [syncguy](https://github.com/syncguy/go-legacy-winxp). Thanks to him!!

```sh
$ docker pull ghcr.io/oxodao/goxp:1.24.4
```

## Usage

### Building yourself

```sh
$ make build # Build the docker image
$ make build-test-app
```

Builds a simple hello world to test that everything works.

### Build your own app

Mount your app folder to /work and use the following env vars:
- GOOS=windows
- GOARCH=386
- GO386=softfloat # Targets CPU that do not have SSE2, untested

Example command:
```sh
$ docker run --rm -v ./:/work -e GOOS=windows -e GOARCH=386 -e GO386=softfloat goxp:1.24.4 go build -trimpath -o app.exe .
```

# License

```
           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                   Version 2, December 2004

Copyright (C) 2025 Oxodao

Everyone is permitted to copy and distribute verbatim or modified
copies of this license document, and changing it is allowed as long
as the name is changed.

           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

 0. You just DO WHAT THE FUCK YOU WANT TO.
```
