# Dotfiles
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/mr-mustash/dotfiles/main.svg)](https://results.pre-commit.ci/latest/github/mr-mustash/dotfiles/main) [![Docker Build](https://img.shields.io/docker/cloud/build/mrmustash/homedir?label=Docker&logo=docker&style=flat)](https://hub.docker.com/repository/docker/mrmustash/homedir)

Welcome to Patrick King's dotfiles repo.

There are a few things you should know about these dotfiles:
1) I use fish as my default shell, and you'll find the configuration under .config/fish/
2) My vim config is very opinionated. Only options listed under vim's ":options" command are in my .vimrc. The rest are located in the appropriate sub-directory under .vim/
3) There are large parts of my vimrc that require vim 8.0+, and in some cases, vim 8.2+.
4) Certain commands and key bindings might seem strange, but on top of my terminal I'm running Amethyst as window manager and Alfred as a launcher. All of the bindings are in place so everything plays nicely together.

## Homemaker

## Docker
I have provided a Dockerfile so that anyone can try out my environment without modifying theirs. It is also [available on Dockerhub](https://hub.docker.com/repository/docker/mrmustash/homedir/) for a convenient way to run it.

Just run `docker run -it -e TERM=xterm-256color --net host mrmustash/homedir:latest` to try my homedir out!

## Terminal Settings

I have always used DejaVu Sans Mono, but have recently switched to using [Nerd Fonts](https://www.nerdfonts.com/#home) DejaVu Sans Mono.
