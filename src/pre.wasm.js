Module = (function () {
  var queue = [];

  onmessage = function (e) {
    if (e.data == 'quit') close();
    else if (queue !== null) queue.push(e.data);
    else Module.ccall('uci_command', 'number', ['string'], [e.data]);
  };

  var xhr = new XMLHttpRequest();
  xhr.open('GET', 'stockfish.wasm?v=niklasf/ddugovic', false);
  xhr.responseType = 'arraybuffer';
  xhr.send(null);

  return {
    wasmBinary: xhr.response,
    print: function(stdout) {
      postMessage(stdout);
    },
    postRun: function() {
      for (var i = 0; i < queue.length; i++) {
        Module.ccall('uci_command', 'number', ['string'], [queue[i]]);
      }
      queue = null;
    }
  };
})();
