API = require('lib/api')
FilterActions = require('actions/filter_actions')
StoreMock = require('mocks/support/store_mock')

module.exports = Reflux.createStore
  listenables: [FilterActions]
  mixins: [StoreMock]

  loadFilters: (success, error) ->
    filters = @getFilters()
    @send(filters: filters, success, '/filters')
