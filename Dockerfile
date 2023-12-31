# FROM nvidia/cuda:11.4.0-base-ubuntu20.04
FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-devel

WORKDIR /app

ENV TZ=Asia/Singapore
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update -y && apt upgrade -y && \
    apt-get install -y wget build-essential checkinstall  libreadline-gplv2-dev  libncursesw5-dev  libssl-dev  libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev && \
    cd /usr/src && \
    wget https://www.python.org/ftp/python/3.9.18/Python-3.9.18.tgz && \
    tar xzf Python-3.9.18.tgz && \
    cd Python-3.9.18 && \
    ./configure --prefix=/usr --enable-optimizations && \
    make install 

RUN ls /usr/bin 

RUN apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    git \
    libfftw3-dev \
    liblapack-dev \
    libsndfile-dev \
    cmake \
    wget \
    && rm -rf /var/lib/apt/lists/* \
    && python3.9 -m pip install --global-option build --global-option --force cython==0.29.19 \
    && python3.9 -m pip install tifresi



COPY requirements.txt ./
RUN python3.9 -m pip install -r requirements.txt

COPY . ./

EXPOSE 8100

WORKDIR /app

ENTRYPOINT ["bash"]