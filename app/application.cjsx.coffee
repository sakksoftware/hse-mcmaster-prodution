require('lib/globals')()
router = require('lib/router')

module.exports = class Application
  constructor: ->
    router.start()
