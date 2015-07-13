exports.config =
  # @see http://brunch.io/#documentation for docs
  files:
    javascripts:
      joinTo:
        'scripts/app.js': /^app/
        'scripts/vendor.js': /^(?!app)/
    stylesheets:
      joinTo:
        'styles/app.css': /^app\/styles\/app.scss/
        'styles/vendor.css': /^(bower_components|vendor)/
    templates:
      joinTo: 'scripts/app.js'

  modules:
    nameCleaner: (path) ->
      path
        # Strip the app/ and .cjsx extension from module names
        .replace(/app\//, '')
        .replace(/\.cjsx/, '')

  paths:
    watched: ['app', 'vendor']

  plugins:
    # react:
    #   harmony: yes # include es6 transforms
    coffeelint:
      pattern: /^app\/.*\.coffee$/
      options:
        max_line_length: {level: 'ignore'}

    sass:
      mode: 'ruby'
      options:
        includePaths: [
          'bower_components/bootstrap-sass/assets/stylesheets'
          'bower_components/bootstrap-offcanvas/src/sass'
        ]

    assetsmanager:
      copyTo:
        'fake_api/': ['spec/fixtures/requests/*']