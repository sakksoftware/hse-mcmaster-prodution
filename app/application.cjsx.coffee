require('lib/globals')()
router = require('lib/router')

module.exports = class Application
  constructor: ->
    # Enable touch events for mobile / tablet
    React.initializeTouchEvents(true)

    router.start()
