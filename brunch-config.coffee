exports.config =
  # @see http://brunch.io/#documentation for docs
  files:
    javascripts:
      joinTo:
        'scripts/app.js': /^app/
        'scripts/vendor.js': /^(?!app)/
    stylesheets:
      joinTo: 'styles/app.css'
    templates:
      joinTo: 'scripts/app.js'

  modules:
    nameCleaner: (path) ->
      path
        # Strip the app/ and .cjsx extension from module names
        .replace(/\.cjsx/, '')
        .replace(/app\//, '')

  plugins:
    # react:
    #   harmony: yes # include es6 transforms
    coffeelint:
      pattern: /^app\/.*\.coffee$/
      options:
        max_line_length: {level: 'ignore'}
  paths:
    watched: ['app', 'vendor']