if false #window.location.hostname == "localhost"
  window.ENV = 'development'
else
  window.ENV = 'production'

require('stores')

initialize = ->
  # Start application
  Application = require('application')
  new Application

# Initialize application on DOM ready
document.addEventListener 'DOMContentLoaded', initialize, true # use capture
