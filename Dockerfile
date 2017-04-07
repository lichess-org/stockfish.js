FROM debian:testing

RUN apt-get update && apt-get install -y --no-install-recommends python build-essential cmake nodejs git-core uglifyjs ca-certificates default-jre-headless

RUN useradd --create-home --user-group builder
WORKDIR /home/builder

ADD https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz /home/builder/
RUN chown builder:builder /home/builder/emsdk-portable.tar.gz
USER builder:builder
RUN tar -xzf emsdk-portable.tar.gz && rm emsdk-portable.tar.gz

WORKDIR /home/builder/emsdk-portable
RUN ./emsdk install -j8 --build=MinSizeRel sdk-incoming-64bit && ./emsdk activate sdk-incoming-64bit
ENV PATH /home/builder/emsdk-portable:/home/builder/emsdk-portable/clang/fastcomp/build_incoming_64/bin:/home/builder/emsdk-portable/node/4.1.1_64bit/bin:/home/builder/emsdk-portable/emscripten/incoming:$PATH

WORKDIR /tmp
RUN echo "int main() { return 0; }" > t.cpp && em++ -fno-exceptions -fno-rtti -std=c++11 t.cpp && em++ -fno-exceptions -fno-rtti -std=c++11 -s WASM=1 t.cpp

VOLUME /home/builder/stockfish.js
WORKDIR /home/builder/stockfish.js

CMD ./build.sh
