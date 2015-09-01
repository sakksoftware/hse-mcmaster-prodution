FiltersHelper = require('mocks/support/filters_helper')
StoreMock = require('mocks/support/store_mock')

FilterActions = Reflux.createActions
  loadFilters: {asyncResult: true}

FilterActions.loadFilters.listen (lang) ->
  filters = FiltersHelper.getFilters()
  StoreMock.send(filters: filters, (=> @completed(filters: filters)), "/filters?lang=#{lang}")

module.exports = FilterActions
