require('./config/boot');
var onceUpon = require('once-upon');
var server = require('./src/app');
server.start(function(err) {
  var logger = require('goodeggs-logger');
  if (err) logger.error(err);
  onceUpon('SIGINT SIGTERM', process, function() {
    server.stop(function(err) {
      if (err) logger.error(err);
    });
  });
});
