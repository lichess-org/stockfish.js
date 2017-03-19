#!/bin/sh -e
cd src
make clean
make ARCH=js build -B -j4
cat ../preamble.js stockfish.js > ../stockfish.js
make clean
make ARCH=wasm build -B -j4
uglifyjs stockfish.js | sed "s/niklasf\/ddugovic/$(git rev-parse --short HEAD)/" | cat ../preamble.js - > ../stockfish.wasm.js
cp stockfish.wasm ../stockfish.wasm
cd ..
