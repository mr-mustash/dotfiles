# Patrick King's homedir container
# Includes typical client utilities for percona, postgres and redis.
FROM ubuntu:20.04

ENV TZ=US/Pacific
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y software-properties-common
RUN apt-add-repository ppa:fish-shell/release-3
RUN apt-add-repository ppa:jonathonf/vim
RUN apt update
RUN apt-get install -y git fish mysql-client postgresql redis vim docker.io \
                       curl wget golang build-essential file sudo rsync dstat \
                       jq less percona-toolkit mytop sysstat \
                       fzf highlight python3 python3-pip

RUN adduser --disabled-password --gecos '' --uid 20454 pking
RUN adduser pking sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN pip3 install awscli --upgrade --user

# Set as my user and setup things from there
USER pking
WORKDIR /home/pking

# Get homemaker
RUN go get github.com/FooSoft/homemaker

# Get my homedir
RUN git clone https://github.com/mr-mustash/dotfiles.git /tmp/dotfiles/
RUN cd /tmp/dotfiles && git submodule init && git submodule update --remote
RUN cd /tmp/dotfiles && yes "c" | /home/pking/go/bin/homemaker -clobber -variant nix -task default ./homemaker.toml ./tilde/

# Properly set the local
RUN sudo sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    sudo locale-gen

# Environment Vairables
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

CMD fish
