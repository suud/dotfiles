FROM debian:buster

LABEL maintainer="Timo Sutterer <hi@timo-sutterer.de>"

# Better terminal support
ENV TERM screen-256color
ENV DEBIAN_FRONTEND noninteractive

# BASIC SYSTEM SETUP
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get clean

# install and set locale (might be required by some packages)
RUN \
  apt-get update && \
  apt-get install -qq locales && \
  rm -rf /var/lib/apt/lists/* && \
  localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# update and install additional packages
RUN \
  apt-get update && \
  apt-get install -qq \
    software-properties-common \
    curl \
    htop \
    vim \
    git \
    zsh \
    neovim \
    python3-neovim


# change default shell
RUN chsh -s $(which zsh)

# DOTFILES SETUP
COPY . /root/.dotfiles

WORKDIR /root/.dotfiles
#RUN ./install


WORKDIR /app
