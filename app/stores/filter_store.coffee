API = require('lib/api')
FilterActions = require('actions/filter_actions')

module.exports = Reflux.createStore
  listenables: [FilterActions]

  loadFilters: (lang, success, error) ->
    API.read "filters?lang=#{lang}",
      success: success,
      error: error
