FetchAPI = require('lib/fetch_api')
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
  clearRelatedArticle: {}
  search: {asyncResult: true}
  loadFilters: {asyncResult: true}

SearchActions.search.listen (search) ->
  language = UserStore.state.language
  FetchAPI.read("search#{serializeSearchUrl(search, language, includePage: true)}").then(@completed).catch(@failed)

SearchActions.loadFilters.listen ->
  FetchAPI.read("search?q=").then(@completed).catch(@failed)

module.exports = SearchActions
