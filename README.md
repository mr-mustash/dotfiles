<div align="center">
    <img src="https://i.imgur.com/WidJ8uW.jpg">
    <p>
    <a href="https://results.pre-commit.ci/latest/github/mr-mustash/dotfiles/main"><img src="https://results.pre-commit.ci/badge/github/mr-mustash/dotfiles/main.svg" alt="pre-commit.ci status"></a>
    <a href="https://github.com/mr-mustash/dotfiles/actions/workflows/snyk-container-analysis.yml"><img src="https://img.shields.io/github/actions/workflow/status/mr-mustash/dotfiles/snyk-container-analysis.yml?label=Snyk%20Container%20Check&logo=Snyk" alt="Snyk container analysis"></a>
    <a href="https://github.com/mr-mustash/dotfiles/actions/workflows/docker-image.yml"><img src="https://img.shields.io/github/actions/workflow/status/mr-mustash/dotfiles/docker-image.yml?label=Docker%20Image%20Build&logo=Docker" alt="docker image build"></a>
    </p>
    <p><a href="https://unlicense.org/"><img src="https://img.shields.io/github/license/mr-mustash/dotfiles?color=blue&label=Licence&logo=Unlicense" alt="license"></a></p>
</div>

# Dotfiles

Welcome to mr_mustash's dotfiles repo. These configurations have evolved from originally [committing](https://github.com/mr-mustash/dotfiles/tree/9c2b4e315b7a37742b1d2c3b601c3b184c3e9459) my `.config/fish` and `.vimrc` directories to now being a fully automated deployment for when I set up a new machine.

My configuration has, at this point, been incredibly tailored to the way that I work and I _do not_ recommend that you `git clone` this repo and use it wholesale for yourself. If you find any parts of my configuration helpful you are welcome to use them as your own! I have decided to use the [Unlicense](https://unlicense.org/) for this repo so that there are no constraints on how anyone can use code that they find here. I hope that people will find parts of this repo useful, much as I have found other dotfiles repos useful on my journey.

## Configuration Specific READMEs

- [Fish](tilde/.config/fish/README.md)
- [Neovim](tile/.config/nvim/README.md)
- [Hammerspoon](tile/.hammerspoon/README.md)

## Docker

As sated before I don't think it's wise for people to use this wholesale, however if you would like to try them out as-is I have published a container [available on Dockerhub](https://hub.docker.com/repository/docker/mrmustash/homedir/) for a convenient way to test out what my environment is like.

The best experience can by had by running `docker run -it -e TERM=xterm-256color --net host mrmustash/homedir:latest`.

## Terminal Settings

I have always used DejaVu Sans Mono, but have switched to using [Nerd Fonts](https://www.nerdfonts.com/#home) DejaVu Sans Mono for easy access to custom glyphs. Both my Fish and Vim config rely on these patched fonts, and the terminal will look quite strange without them.
