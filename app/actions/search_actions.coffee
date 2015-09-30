config = require('config')
if config.useMocks
  return module.exports = require('mocks/actions/search_actions')

API = require('lib/api')
serializeSearchUrl = require('services/search_serialization_service').serializeSearchUrl
UserStore = require('stores/user_store')

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
  loadMore: {}
  search: {asyncResult: true}
  loadFilters: {asyncResult: true}

SearchActions.search.listen (search) ->
  language = UserStore.state.language
  API.read("search#{serializeSearchUrl(search, language, includePage: true)}", skipErrorHandlingFor: [403]).
    done(@completed).fail(@failed)

SearchActions.loadFilters.listen ->
  API.read("search?q=").done(@completed).fail(@failed)

module.exports = SearchActions
