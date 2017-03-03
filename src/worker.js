var queue = [];

onmessage = function(e) {
  if (queue === null) {
    Module.ccall('uci_command', 'number', ['string'], [e.data]);
  } else {
    queue.push(e.data);
  }
};

var xhr = new XMLHttpRequest();
xhr.open('GET', 'stockfish.wasm', false);
xhr.responseType = 'arraybuffer';
xhr.send(null);

Module = {
  wasmBinary: xhr.response,
  noExitRuntime: true,
  print: function(stdout) {
    postMessage(stdout);
  },
  postRun: function () {
    for (var i = 0; i < queue.length; i++) {
      Module.ccall('uci_command', 'number', ['string'], [queue[i]]);
    }
    queue = null;
  }
};

importScripts('stockfish.js');
