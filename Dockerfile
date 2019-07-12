FROM golang:1.12

RUN apt update -q && \
    apt install -qy git python3.7 wget curl silversearcher-ag && \
    wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz -o /tmp/nvim-linux64.tar.gz && \
    tar xf -C /tmp/nvim-linux64.tar.gz && \
    mv nvim-linux64 /usr/local && \
    pip3 install neovim
    
RUN go mod download

EXPOSE 1323

