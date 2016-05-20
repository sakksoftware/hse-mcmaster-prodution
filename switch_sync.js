var sys = require('sys');
var exec = require('child_process').exec;

child = exec('switch csv2json hse.csv ./tmp/locales', function(error, stdout, stderror) {
  sys.print('stdout: ' + stdout);
  sys.print('stderr: ' + stderr);

  if (error) return sys.print('Fatal error executing switch command');

  sys.print('Successfully synced locale files');
});
