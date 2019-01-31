# pixelpwnr (Dockerized)

[![](https://img.shields.io/microbadger/layers/poeschl/pixelpwnr.svg)](https://microbadger.com/images/poeschl/pixelpwnr)
[![](https://img.shields.io/microbadger/image-size/poeschl/pixelpwnr.svg)](https://microbadger.com/images/poeschl/pixelpwnr)
[![](https://img.shields.io/docker/pulls/poeschl/pixelpwnr.svg)](https://hub.docker.com/r/poeschl/pixelpwnr)
[![](https://img.shields.io/github/license/poeschl/docker-pixelpwnr.svg?maxAge=3600)](https://github.com/poeschl/docker-pixelpwnr/blob/master/LICENCE)

A docker container wih the [pixelpwnr](https://github.com/timvisee/pixelpwnr) inside.

# Usage

The contained pixelpwnr can be used like that

`docker run -v ./images:/images poeschl/pixelpwnr 127.0.0.1:1234 -i /images/image.png`

to paint `images/image.png` towards the pixelflut server on your own machine. For more options look at [`--help`](https://github.com/timvisee/pixelpwnr#help).

# Licence

The included pixelpwnr application is under [GNU GPL-3.0](https://raw.githubusercontent.com/timvisee/pixelpwnr/master/LICENSE)
