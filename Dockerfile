FROM golang:1.12

SHELL ["/bin/bash", "-c"]

WORKDIR /root

RUN apt update -q && \
    apt install -qy \
      git wget curl silversearcher-ag tmux zlib1g-dev libssl-dev \
      libffi-dev libbz2-dev libreadline-dev libsqlite3-dev

RUN curl -sSL https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz -o /tmp/nvim-linux64.tar.gz && \
    tar zxf /tmp/nvim-linux64.tar.gz -C /tmp && \
    cp -r /tmp/nvim-linux64/* /usr/local/

RUN git clone git://github.com/yyuu/pyenv.git ~/.pyenv && \
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc && \
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc && \
    source ~/.bashrc && \
    pyenv install 3.7.3 && \
    pyenv global 3.7.3 && \
    pyenv rehash

RUN go get -u github.com/gravityblast/fresh

RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
    ~/.fzf/install --key-bindings --completion --update-rc

RUN source ~/.bashrc && \
    pip install neovim && \
    git clone https://github.com/ryicoh/nvim.git ~/.config/nvim && \
    nvim -c "q" && \
    echo "alias vi=nvim" >> ~/.bashrc

EXPOSE 1323

