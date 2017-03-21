#!/bin/sh -e
cd src

make clean
make ARCH=js build -B -j4
cat ../preamble.js stockfish.js > ../stockfish.js

make clean
make ARCH=wasm build -B -j4
uglifyjs --compress --mangle -- stockfish.js | sed "s/SF_VERSION/$(sha256sum stockfish.wasm | cut -c1-8)/" | cat ../preamble.js - > ../stockfish.wasm.js
cp stockfish.wasm ../stockfish.wasm

cd ..
