#!/bin/sh
cd src
make clean
make ARCH=js build -B -j4
cat ../preamble.js stockfish.js > ../stockfish.js
make clean
make ARCH=wasm build -B -j4
uglifyjs stockfish.js | cat ../preamble.js - > ../stockfish.wasm.js
cp stockfish.wasm ../stockfish.wasm
cd ..
