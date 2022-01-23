# Patrick King's homedir container
# Includes typical client utilities for percona, postgres and redis.
FROM ubuntu:impish-20211015

ENV TZ=US/Pacific
ENV DEBIAN_FRONTEND=noninteractive

# hadolint ignore=DL3008
RUN apt-get update && apt-get install --no-install-recommends -y software-properties-common \
    && apt-get install --no-install-recommends -y gpg gpg-agent \
    && apt-add-repository ppa:fish-shell/release-3 \
    && add-apt-repository ppa:neovim-ppa/stable \
    && apt-get update && apt-get install --no-install-recommends -y \
                       git fish mysql-client postgresql redis vim neovim docker.io \
                       curl wget golang build-essential file sudo rsync dstat \
                       jq less percona-toolkit mytop sysstat \
                       fzf highlight python3 python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# hadolint ignore=DL3013
RUN pip3 install --no-cache-dir awscli --upgrade --user

RUN adduser --disabled-password --gecos '' --uid 20454 pking \
 && adduser pking sudo \
 && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers


# Properly set the local
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen

# Set as my user and setup things from there
USER pking
WORKDIR /home/pking

# Get homemaker
RUN go get github.com/FooSoft/homemaker

# Get my homedir
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN git clone https://github.com/mr-mustash/dotfiles.git /tmp/dotfiles/

WORKDIR /tmp/dotfiles
RUN git checkout main && git submodule init && git pull --recurse-submodules
RUN /home/pking/go/bin/homemaker -clobber -variant nix -task default ./homemaker.toml ./tilde/


# Environment Variables
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

CMD ["fish"]
