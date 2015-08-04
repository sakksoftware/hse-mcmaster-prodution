API = require('lib/api')
FilterActions = require('actions/filter_actions')
StoreMock = require('mocks/support/store_mock')

module.exports = Reflux.createStore
  listenables: [FilterActions]
  mixins: [StoreMock]

  loadFilters: (success, error) ->
    filters = @addCountryFilters(filterData.filters)
    @send(filters: filters, success)

filterData =
  "filters": [
    {"name": "All of them", "id": 1234, "count": 350, "type": "document" },
    {"name": "Option A", "id": 1235, "count": 200, "type": "document" },
    {"name": "Option B", "id": 1236, "count": 100, "type": "document" },
    {"name": "Governance", "id": 1237, "count": 100, "type": "document" },
    {"name": "Human Studies", "id": 1238, "count": 135, "type": "document" }
  ]
