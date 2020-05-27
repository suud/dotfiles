FROM debian:buster

LABEL maintainer="Timo Sutterer <hi@timo-sutterer.de>"

# Better terminal support
ENV TERM screen-256color
# Do not ask any questions and assume defaults
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
    tmux \
    neovim \
    python3-neovim

# install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN rm /root/.zshrc
# install powerlevel10k theme
RUN git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# set default shell to zsh
RUN chsh -s $(which zsh)

# DOTFILES SETUP
COPY . /root/.dotfiles
# install dotfiles
WORKDIR /root/.dotfiles
ENV PATH /root/.dotfiles/bin:$PATH
RUN install-dotfiles --unattended

# Reset to default
ENV DEBIAN_FRONTEND dialog

# set start dir and shell
WORKDIR /app
ENTRYPOINT ["zsh"]
