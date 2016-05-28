onmessage = function (e) {
  if (e.data == 'quit') close();
  else Module.ccall("uci_command", "number", ["string"], [e.data]);
};
