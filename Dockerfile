FROM debian:9-slim

RUN apt-get update && \
    apt-get install -y \
       sudo \
       curl \
       wget \
       gnupg \
       git \
       gcc \
       make \
       zlib1g \
       zlib1g-dev \
       libffi-dev \
       bzip2 \
       openssl \
       build-essential \
       libssl-dev \
       libbz2-dev \
       libreadline-dev \
       libsqlite3-dev \
       llvm \
       libncurses5-dev \
       libncursesw5-dev \
       xz-utils \
       tk-dev \
       liblzma-dev \
       python-openssl \
       vim && \
    echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/2/Debian_9.0/ /' | sudo tee -a /etc/apt/sources.list && \
    wget -q -O - https://download.opensuse.org/repositories/shells:fish:release:2/Debian_9.0/Release.key | apt-key add - && \
    apt-get update && \
    apt-get install -y fish && \
    mkdir -p /home/yusuken/.config/fish && \
    useradd yusuken -d /home/yusuken -s /usr/bin/fish && \
    echo "yusuken	ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    apt-get clean && \
    apt-get autoremove -y && \
    git clone https://github.com/riywo/anyenv /home/yusuken/.anyenv && \
    export PATH=/home/yusuken/.anyenv/bin:$PATH && \
    mkdir -p $(anyenv root)/plugins && \
    git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update && \
    echo 'set -x PATH "/home/yusuken/.anyenv/bin" $PATH' >> /home/yusuken/.config/fish/config.fish && \
    echo 'set -x PATH "/home/yusuken/.anyenv/envs/pyenv/bin" $PATH' >> /home/yusuken/.config/fish/config.fish && \
    echo 'set -x PATH "/home/yusuken/.anyenv/envs/rbenv/bin" $PATH' >> /home/yusuken/.config/fish/config.fish && \
    echo 'set -x PATH "/home/yusuken/.anyenv/envs/nodenv/bin" $PATH' >> /home/yusuken/.config/fish/config.fish && \
    echo 'eval (anyenv init - | source)' >> /home/yusuken/.config/fish/config.fish && \
    chown -R yusuken /home/yusuken
 
USER yusuken
WORKDIR /home/yusuken
SHELL ["/usr/bin/fish", "-c"]
RUN sudo apt-get remove python -y; \
    source .config/fish/config.fish; \
    and anyenv install --force-init; \
    and anyenv install pyenv; \
    and anyenv install rbenv; \
    and anyenv install nodenv; \
    and source .config/fish/config.fish; \
    and pyenv install 3.7.4; \
    and rbenv install 2.6.2; \
    and pyenv global 3.7.4; \
    and rbenv global 2.6.2

