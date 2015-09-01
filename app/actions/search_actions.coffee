config = require('config')[window.ENV]
if config.useMocks
  return module.exports = require('mocks/actions/search_actions')

API = require('lib/api')
serializeSearchUrl = require('services/search_serialization_service').serializeSearchUrl

SearchActions = Reflux.createActions
  sortBy: {}
  addFilter: {}
  removeFilter: {}
  removeFilterGroup: {}
  changeFilterValue: {}
  changeParentFilterValue: {}
  toggleNestedFilter: {}
  toggleFilter: {}
  toggleCountryFilter: {}
  toggleDateRangeFilter: {}
  search: {asyncResult: true}
  suggestions: {asyncResult: true}

SearchActions.search.listen (search, language) ->
  API.read("search#{serializeSearchUrl(search, language)}").
    done(@completed).fail(@failed)

module.exports = SearchActions
