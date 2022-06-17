# gem5 and NVmain Hybrid Simulator Docker Image

[![Docker](https://github.com/SonodaKazuto/gem5-nvmain-docker/actions/workflows/docker-publish.yml/badge.svg?branch=main)](https://github.com/SonodaKazuto/gem5-nvmain-docker/actions/workflows/docker-publish.yml)

**(status may show fail even if the image is published successfully)**

integrate gem5 and nvmain into a docker image

## Environment and Setting
- ubuntu 18.04
- zsh
- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
- [gem5](https://gem5.googlesource.com/public/gem5/+/525ce650e1a5bbe71c39d4b15598d6c003cc9f9e)
- [NVmain](https://github.com/SEAL-UCSB/NVmain)

## Goal
- [x] set up environment
- [x] integrate oh-my-zsh
- [x] install necessary packages
- [x] download and build gem5
- [x] download and build nvmain
- [x] hybrid build gem5 and NVmain
- [x] workable dockerfile
- [x] add L3 cache (CMD failed in l3-cache version)
- [x] L3 cache add replacement policy
- [x] github action release

## Usage

### build locally

```sh
docker build -t gem5-nvmain-hybrid . \
--no-cache // optional
```

### Pull from remote

```sh
docker pull ghcr.io/sonodakazuto/gem5-nvmain-docker:l3-cache
```

- **Important**
  
  please execute the command below to use oh-my-zsh
  ```sh
  exec $SHELL
  ```
