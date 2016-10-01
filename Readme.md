stockfish.js
============

The strong open source chess engine
[Stockfish](https://github.com/official-stockfish/Stockfish)
compiled to JavaScript using
[Emscripten](https://kripken.github.io/emscripten-site/). See it in action
for [local computer analysis on lichess.org](https://de.lichess.org/analysis).

Downloads
---------

About 1MB uncompressed, 220 KB gzipped:

* [stockfish.js](https://raw.githubusercontent.com/niklasf/stockfish.js/master/stockfish.js)
  based on original Stockfish
* [stockfish.js](https://raw.githubusercontent.com/niklasf/stockfish.js/ddugovic/stockfish.js)
  with [multi-variant support by @ddugovic](https://github.com/ddugovic/Stockfish)

Building
--------

[Install Emscripten](https://kripken.github.io/emscripten-site/docs/getting_started/downloads.html),
then:

```
cd src
make ARCH=js build
```

Usage
-----

```javascript
var stockfish = new Worker('stockfish.js');

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
