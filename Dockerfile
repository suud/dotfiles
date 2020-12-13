FROM debian:buster

LABEL maintainer="Timo Sutterer <hi@timo-sutterer.de>"

# better terminal support
ENV TERM xterm-256color
# do not ask any questions and assume defaults
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

# install basic packages
RUN \
  apt-get update && \
  apt-get install -qq \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    curl \
    htop \
    vim \
    git \
    zsh \
    tmux \
    python3-neovim \
    python3-pip \
    exuberant-ctags \
    vim-python-jedi

# install node.js and npm
RUN \
  apt-get update && \
  apt-get install -qq nodejs && \
  curl -L https://www.npmjs.com/install.sh | sh

# install docker cli and docker-compose
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian \
        $(lsb_release -cs) \
        stable"
RUN apt-get update && \
    apt-get install -qq \
    docker-ce-cli \
    docker-compose

# install python packages
RUN pip3 install flake8 black

# install clojure(script) linters
RUN curl -sLO https://raw.githubusercontent.com/borkdude/clj-kondo/master/script/install-clj-kondo && \
    chmod +x install-clj-kondo && \
    ./install-clj-kondo && \
    rm install-clj-kondo
RUN cd /usr/local/bin && \
    curl -sOL https://github.com/candid82/joker/releases/download/v0.15.7/joker-0.15.7-linux-amd64.zip && \
    unzip joker-0.15.7-linux-amd64.zip && \
    rm joker-0.15.7-linux-amd64.zip

# install neovim (newer version as through apt)
WORKDIR /
RUN \
  curl -LO \
  https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
  chmod u+x nvim.appimage && \
  ./nvim.appimage --appimage-extract && \
  rm nvim.appimage && \
  rm /usr/bin/nvim && \
  ln -s /squashfs-root/AppRun /usr/bin/nvim

# install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN rm /root/.zshrc
# install powerlevel10k theme
RUN git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
# install autosuggestions plugin
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# install zsh syntax highlighting
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# set default shell to zsh
RUN chsh -s $(which zsh)

# install vim-plug
RUN curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# DOTFILES SETUP
COPY . /root/.dotfiles
# install dotfiles
WORKDIR /root/.dotfiles
ENV PATH /root/.dotfiles/bin:$PATH
RUN install-dotfiles --unattended

# this directory is required for the nvim undo history
RUN mkdir -p ~/.nvimundo

# reset to default
ENV DEBIAN_FRONTEND dialog

# set shell
ENTRYPOINT ["zsh"]
