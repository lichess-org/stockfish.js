Module = (function () {
  var queue = [];

  onmessage = function (e) {
    if (e.data == 'quit') close();
    else if (queue !== null) queue.push(e.data);
    else Module.ccall('uci_command', 'number', ['string'], [e.data]);
  };

  return {
    locateFile: function(file) {
      return file;
    },
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
