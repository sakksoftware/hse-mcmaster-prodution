window.ENV = 'development'
# if window.location.hostname == "localhost"
#   window.ENV = 'development'
# else
#   window.ENV = 'production'

config = require('config')[window.ENV]
if config.useMockStores
  console.log("using mock stores")
  store = require('mocks/stores')
else
  store = require('stores')

initialize = ->
  # Start application
  Application = require('application')
  new Application

# Initialize application on DOM ready
document.addEventListener 'DOMContentLoaded', initialize, true # use capture
