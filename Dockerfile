FROM debian:testing

MAINTAINER Niklas Fiekas <niklas.fiekas@backscattering.de>

RUN apt-get update && apt-get install -y --no-install-recommends python build-essential cmake nodejs default-jre-headless git-core uglifyjs

RUN useradd --create-home --user-group builder

WORKDIR /home/builder
ADD https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz /home/builder/
RUN chown builder:builder /home/builder/emsdk-portable.tar.gz
USER builder:builder
RUN tar -xvzf emsdk-portable.tar.gz && rm emsdk-portable.tar.gz

WORKDIR /home/builder/emsdk_portable
RUN ./emsdk install --build=MinSizeRel sdk-incoming-64bit
RUN ./emsdk activate
ENV PATH /home/builder/emsdk_portable:/home/builder/emsdk_portable/clang/fastcomp/build_incoming_64/bin:/home/builder/emsdk_portable/node/4.1.1_64bit/bin:/home/builder/emsdk_portable/emscripten/incoming:$PATH

VOLUME /home/builder/stockfish.js
WORKDIR /home/builder/stockfish.js

CMD ./release.sh
