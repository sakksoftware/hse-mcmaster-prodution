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

  conventions:
    # this prevents bower package from being included in assets copy:
    # https://github.com/brunch/brunch/issues/893
    assets: /^app\/assets\//

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
      options:
        includePaths: [
          'bower_components/bootstrap-sass/assets/stylesheets'
        ]

    assetsmanager:
      copyTo:
        'fonts/': ['bower_components/bootstrap-sass/assets/fonts/*']
        'fake_api/': ['spec/fixtures/requests/*']
        'locales/': ['locales/*']
