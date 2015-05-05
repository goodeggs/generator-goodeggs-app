require('./config/boot');
var gulp = require('gulp');
var glob = require('glob');

var taskFiles = glob.sync('./tasks/**/*.coffee');
taskFiles.forEach(function(taskFile) {
  require('./'+taskFile);
});

gulp.on('err', function(e) {
  console.error(e.err.stack);
});

