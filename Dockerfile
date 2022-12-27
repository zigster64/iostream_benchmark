FROM ubuntu:22.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y python3 python3-venv vim build-essential wget git htop python3-pip cmake colordiff net-tools gdb curl clang-format clang time

RUN curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain stable -y
RUN ~/.cargo/bin/cargo install hyperfine

WORKDIR /work
RUN curl https://datasets.imdbws.com/title.basics.tsv.gz | gunzip > text
COPY iostream.cc stdio.cc Makefile .
COPY run.sh .
RUN make
