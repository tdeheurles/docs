# golang

[Docker container](https://github.com/docker-library/docs/tree/master/golang) is a container for building golang.

You can add this to your .bashrc for running go :

```bash
export PATH="~/go/bin:$PATH"
function go {
  docker run \
  --rm \
  -v ~/go:/go \
  -v `pwd`:/usr/src/`basename $(pwd)` \
  golang:latest \
  /bin/bash -c "adduser user --disabled-password --quiet --gecos "" ; su user ; mkdir -p /go/src/`basename $(pwd)` ; cp -r /usr/src/`basename $(pwd)` /go/src/ ; cd /go/src/`basename $(pwd)` ; go $@"
}
```

It will use the `~/go ` path as the caching `GOPATH`
