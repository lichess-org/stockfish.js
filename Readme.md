stockfish.js
============

The strong open source chess engine
[Stockfish](https://github.com/official-stockfish/Stockfish)
compiled to JavaScript and WebAssembly using
[Emscripten](https://kripken.github.io/emscripten-site/). See it in action
for [local computer analysis on lichess.org](https://lichess.org/analysis).

[![npm](https://badge.fury.io/js/stockfish.js.svg)](https://badge.fury.io/js/stockfish.js)
[![Build status](https://travis-ci.org/niklasf/stockfish.js.svg?branch=ddugovic)](https://travis-ci.org/niklasf/stockfish.js)
[![Passively maintained](https://img.shields.io/badge/passively%20maintained-x-yellow.svg)](#)

Maintained with bugfixes to keep supporting older browsers, but active
development is happening on [stockfish.wasm](https://github.com/niklasf/stockfish.wasm).

Releases
--------

[About 1.4MB uncompressed, 250 KB gzipped.](https://github.com/niklasf/stockfish.js/releases)

Building
--------

[Install Emscripten](https://kripken.github.io/emscripten-site/docs/getting_started/downloads.html) and 
[uglifyjs](https://github.com/mishoo/UglifyJS2),
then:

```
./build.sh
```

Or using Docker:

```
docker run --user $(id -u):$(id -g) --volume $(pwd):/home/builder/stockfish.js:rw niklasf/emscripten-for-stockfish
```

Usage
-----

```javascript
var wasmSupported = typeof WebAssembly === 'object' && WebAssembly.validate(Uint8Array.of(0x0, 0x61, 0x73, 0x6d, 0x01, 0x00, 0x00, 0x00));

var stockfish = new Worker(wasmSupported ? 'stockfish.wasm.js' : 'stockfish.js');

stockfish.addEventListener('message', function (e) {
  console.log(e.data);
});

stockfish.postMessage('uci');
```

Changes to original Stockfish
-----------------------------

* Expose as web worker.
* Web workers are inherently single threaded. Limit to one thread.
* Break down main iterative deepening loop to allow interrupting search.
* Limit total memory to 32 MB.
* Disable Syzygy tablebases.
* Disable benchmark.

Acknowledgements
----------------

Thanks to [@nmrugg](https://github.com/nmrugg/stockfish.js) for doing the same
thing with Stockfish 6, to [@ddugovic](https://github.com/ddugovic) for his
[multi-variant Stockfish fork](https://github.com/ddugovic/Stockfish) and to
the Stockfish team for ...
[Stockfish](https://github.com/official-stockfish/Stockfish).
