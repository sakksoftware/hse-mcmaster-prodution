API = require('lib/api')
FilterActions = require('actions/filter_actions')
FiltersHelper = require('mocks/support/filters_helper')
StoreMock = require('mocks/support/store_mock')

module.exports = Reflux.createStore
  listenables: [FilterActions]
  mixins: [StoreMock, FiltersHelper]

  loadFilters: (lang, success, error) ->
    filters = @getFilters()
    @send(filters: filters, success, "/filters?lang=#{lang}")
