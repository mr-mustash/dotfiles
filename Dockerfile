# Patrick King's homedir container
# Includes typical client utilities for percona, postgres and redis.
FROM ubuntu:21.10

ENV TZ=US/Pacific
ENV DEBIAN_FRONTEND=noninteractive

# hadolint ignore=DL3008
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update && apt-get install --no-install-recommends -y software-properties-common \
    && apt-get install --no-install-recommends -y gpg gpg-agent \
    && apt-add-repository ppa:fish-shell/release-3 \
    && add-apt-repository ppa:neovim-ppa/stable \
    && apt-get update && apt-get install --no-install-recommends -y \
                       git fish vim neovim curl golang wget \
                       build-essential file sudo rsync dstat  \
                       jq less sysstat fzf highlight python3 python3-pip \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu impish stable" \
    && apt-get install --no-install-recommends -y docker-ce \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# hadolint ignore=DL3013
RUN pip3 install --no-cache-dir awscli --upgrade --user

RUN adduser --disabled-password --gecos '' --uid 20454 pking \
 && adduser pking sudo \
 && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers


# Properly set the local
#RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
#    locale-gen

# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8


COPY tilde/ /tmp/dotfiles/tilde/
COPY homemaker.toml /tmp/dotfiles/
RUN chown -R pking:pking /tmp/dotfiles/

# Set as my user and setup things from there
USER pking
WORKDIR /home/pking

# Get homemaker
RUN go get github.com/FooSoft/homemaker

# Get my homedir
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
WORKDIR /tmp/dotfiles/
RUN /home/pking/go/bin/homemaker -clobber -variant nix -task default ./homemaker.toml ./tilde/
WORKDIR /home/pking
# For some reason this returns a non-zero exit code, so putting in `|| :` to ignore it
RUN nvim -es -u ~/.config/nvim/init.vim -i NONE -c "PlugUpdate" -c "qa" || :


# Environment Variables
ENV LANG en_US.utf8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

CMD ["fish"]
