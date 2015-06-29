ENV = 'development'
require('stores')

initialize = ->
  # Start application
  Application = require('application')
  new Application

# Initialize application on DOM ready
document.addEventListener 'DOMContentLoaded', initialize, true # use capture
