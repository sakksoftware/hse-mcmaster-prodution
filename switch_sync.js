var exec = require('child_process').exec;

child = exec('switch csv2json hse.csv ./tmp/locales', function(error, stdout, stderror) {
  console.log('stdout: ' + stdout);
  console.log('stderr: ' + stderr);

  if (error) return console.log('Fatal error executing switch command');

  console.log('Successfully synced locale files');
});
