API = require('lib/api')
FilterActions = require('actions/filter_actions')

module.exports = Reflux.createStore
  listenables: [FilterActions]

  loadFilters: (success, error) ->
    API.read "filters",
      success: success,
      error: error
