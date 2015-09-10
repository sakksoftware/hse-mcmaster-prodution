config = require('config')
if config.useMocks
  module.exports = require('mocks/actions/filter_actions')
  return

API = require('lib/api')

FilterActions = Reflux.createActions
  loadFilters: {asyncResult: true}

FilterActions.loadFilters.listen (lang) ->
  API.read("filters?lang=#{lang}").done(@completed).fail(@failed)

module.exports = FilterActions
