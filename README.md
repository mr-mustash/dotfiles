# Dotfiles
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/mr-mustash/dotfiles/main.svg)](https://results.pre-commit.ci/latest/github/mr-mustash/dotfiles/main) [![Snyk Container Analysis](https://img.shields.io/github/workflow/status/mr-mustash/dotfiles/Snyk%20Container?label=Snyk%20Container%20Check&logo=Snyk)](https://github.com/mr-mustash/dotfiles/actions/workflows/snyk-container-analysis.yml) [![Docker Image Build](https://img.shields.io/github/workflow/status/mr-mustash/dotfiles/Docker%20Image%20Build?label=Docker%20Image%20Build&logo=Docker)](https://github.com/mr-mustash/dotfiles/actions/workflows/docker-image.yml) [![mrmustash/homedir:latest](https://img.shields.io/docker/cloud/build/mrmustash/homedir?label=mrmustash%2Fhomedir%3Alatest&logo=docker)](https://hub.docker.com/repository/docker/mrmustash/homedir)

Welcome to Patrick King's dotfiles repo. These configurations have evolved from originally [committing](https://github.com/mr-mustash/dotfiles/tree/9c2b4e315b7a37742b1d2c3b601c3b184c3e9459) my `.config/fish` and `.vimrc` directories to now being a fully automated deployment for when I set up a new machine.

My configuration has, at this point, been _very_ tailored to the way that I work and I *do not* recommend that you just check this repo out and use it wholesale for yourself. However, if you find any parts of my configuration you are welcome to use them as your own! I have decided to use the [Unlicense](https://unlicense.org/) for this repo so that there are no constraints as to how anyone can use code that they find here. I do hope that people will find parts of this repo useful, just as I have found many other dotfiles repos useful on my journey.

## Configuration Specific READMEs.
* [Fish](tilde/.config/fish/README.md)
* [Neovim](tile/.config/nvim/README.md)
* [Hammerspoon](tile/.hammerspoon/README.md)

## Docker
I very much *DO NOT* recommend that people just use these dotfiles wholesale for themselves. However, if you'd like to try them out I have published a container [available on Dockerhub](https://hub.docker.com/repository/docker/mrmustash/homedir/) for a convenient way to test out what my environment is like.

The best experience can by had by running `docker run -it -e TERM=xterm-256color --net host mrmustash/homedir:latest`.

## Terminal Settings
I have always used DejaVu Sans Mono, but have recently switched to using [Nerd Fonts](https://www.nerdfonts.com/#home) DejaVu Sans Mono.
