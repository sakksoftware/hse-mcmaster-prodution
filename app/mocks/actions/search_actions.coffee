console.log('loaded mock search')

API = require('lib/api')
StoreMock = require('mocks/support/store_mock')
FilterNormalizationService = require('services/filter_normalization_service')
SearchSerializationService = require('services/search_serialization_service')
FiltersHelper = require('mocks/support/filters_helper')
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

SearchActions.search.listen (search) -> performSearch.call(@, search)
SearchActions.loadFilters.listen ->
  search = require('stores/search_store').state.search
  performSearch.call(@, search)

module.exports = SearchActions

# private
performSearch = (search) ->
  language = UserStore.state.language
  allFilters = FiltersHelper.getFilters()
  applied_filters = getAppliedFilters(search.filters)
  addAppliedProperty(allFilters, applied_filters)
  query = SearchSerializationService.serializeSearchUrl(search, language, includePage: true)

  res = _.clone(searchData)
  res.applied_filters = applied_filters
  res.filters = allFilters
  res.query = search.query
  res.sort_by = search.sort_by
  res.page = search.page
  lastResultIndex = Math.min(res.results_count - (res.results_per_page * (res.page - 1)), res.results_per_page) - 1
  res.results = res.results[0..lastResultIndex]

  StoreMock.send(res, (=> @completed(res)), "/search#{query}")

addAppliedProperty = (filters, appliedFilters) ->
  _(filters).each (f) =>
    if f.id
      appliedFilter = _(appliedFilters).find (af) -> af.id == f.id
      f.applied = appliedFilter?.applied || false
      if appliedFilter?.type == "countries_countries"
        f.mode = appliedFilter.mode
      if appliedFilter?.type == "date_range"
        f.start = appliedFilter.start
        f.end = appliedFilter.end
    if f.filters
      addAppliedProperty(f.filters, appliedFilters)

getAppliedFilters = (filters) ->
  filters = FilterNormalizationService.getFiltersArray(filters)
  filters.filter((e) -> e.applied)

searchData = {
  "query": "HIV",
  "page": 1,
  "results_per_page": 10,
  "results_count": 55,
  "sort_by": "relevance",
  "saved": false,
  "results": [
    {
      "id": "all_filled_all_visible",
      "traversal": "tencharacters",
      "title": "All <B>fields</B> Filled & Visible",
      "created_at": "2014-09-20 11:33:00Z",
      "updated_at": "2014-09-20 11:33:00Z",
      "quality": "7/11",
      "description": "Some <B>Crazy</B> long description goes here.....",
      "category": "<B>International</B> Organizations Document",
      "country_groupings": "<B>USA</B> (26); UK (2); Australia (1); Turkey (1)"
    },
    {
      "id": "not_filled_all_visible",
      "traversal": "tencharacters",
      "title": "All optional fields are emtpy & visible",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "country_groupings": "USA (26); UK (2); Australia (1); Turkey (1)"
    },
    {
      "id": "all_hidden",
      "traversal": "tencharacters",
      "title": "All fields are hidden",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "country_groupings": "USA (26); UK (2); Australia (1); Turkey (1)"
    },
    {
      "id": "all_visible",
      "traversal": "tencharacters",
      "title": "Article D",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "country_groupings": "USA (26); UK (2); Australia (1); Turkey (1)"
    },
    {
      "id": "all_visible",
      "traversal": "tencharacters",
      "title": "Article E",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "country_groupings": "USA (26); UK (2); Australia (1); Turkey (1)"
    },
    {
      "id": "all_visible",
      "traversal": "tencharacters",
      "title": "Article F",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "country_groupings": "USA (26); UK (2); Australia (1); Turkey (1)"
    },
    {
      "id": "all_visible",
      "traversal": "tencharacters",
      "title": "Article G",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "country_groupings": "USA (26); UK (2); Australia (1); Turkey (1)"
    },
    {
      "id": "all_visible",
      "traversal": "tencharacters",
      "title": "Article H",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "country_groupings": "USA (26); UK (2); Australia (1); Turkey (1)"
    },
    {
      "id": "all_visible",
      "traversal": "tencharacters",
      "title": "Article I",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "country_groupings": "USA (26); UK (2); Australia (1); Turkey (1)"
    },
    {
      "id": "all_visible",
      "traversal": "tencharacters",
      "title": "Article J",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "country_groupings": "USA (26); UK (2); Australia (1); Turkey (1)"
    }
  ],
  "filters": {}
}
