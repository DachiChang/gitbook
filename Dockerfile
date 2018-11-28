FROM node:8-alpine

LABEL maintainer="Dachi Chang<femc7488@gmail.com>"

RUN apk update &&\
    apk upgrade &&\
    apk add git openjdk8-jre graphviz &&\
    npm install -g gitbook-cli &&\
    gitbook fetch &&\
    rm -rf /tmp/*

RUN apk add font-noto wget sudo &&\
    wget https://noto-website-2.storage.googleapis.com/pkgs/NotoSerifTC.zip &&\
    unzip NotoSerifTC.zip &&\
    sudo mkdir -p /usr/share/fonts/opentype/noto &&\
    sudo cp *otf /usr/share/fonts/opentype/noto &&\
    sudo fc-cache -f -v

ENV BOOKDIR /gitbook
ENV LANG zh_TW.UTF-8
ENV LC_CTYPE zh_TW.UTF-8

VOLUME $BOOKDIR

EXPOSE 4000

WORKDIR $BOOKDIR

ENTRYPOINT ["/usr/local/bin/gitbook"]
