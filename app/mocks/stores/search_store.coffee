API = require('lib/api')
config = require('config')[window.ENV]
SearchActions = require('actions/search_actions')
StoreMock = require('mocks/support/store_mock')
FilterNormalizationService = require('services/filter_normalization_service')
SearchSerializationService = require('services/search_serialization_service')
FiltersHelper = require('mocks/support/filters_helper')

console.log('loaded mock search')

module.exports = Reflux.createStore
  listenables: [SearchActions]
  mixins: [StoreMock, FiltersHelper]

  _addAppliedProperty: (filters, appliedFilters) ->
    _(filters).each (f) =>
      if f.id
        appliedFilter = _(appliedFilters).find (af) -> af.id == f.id
        f.applied = appliedFilter?.applied || false
        if appliedFilter?.name == "countries"
          f.mode = appliedFilter.mode
        if appliedFilter?.name == "date_range"
          f.start = appliedFilter.start
          f.end = appliedFilter.end
      if f.filters
        @_addAppliedProperty(f.filters, appliedFilters)

  _getAppliedFilters: (filters) ->
    filters = FilterNormalizationService.getFiltersArray(filters)
    filters.filter((e) -> e.applied)

  search: (search, success, error, options = {}) ->
    allFilters = @getFilters()
    applied_filters = @_getAppliedFilters(search.filters)
    @_addAppliedProperty(allFilters, applied_filters)
    query = SearchSerializationService.serializeSearchUrl(search)

    res = searchData
    res.applied_filters = applied_filters
    res.filters = allFilters
    res.query = search.query
    res.sort_by = search.sort_by

    @send(res, success, "/search#{query}")

  suggestions: (query, success, error, options = {}) ->
    res = _.clone(suggestionData)
    res.suggestions = _.filter suggestionData.suggestions, (s) => s.query.toLowerCase().match(query.toLowerCase())
    @send(res, success, '/search/suggestions')

searchData = {
  "query": "HIV",
  "page": 1,
  "results_per_page": 50,
  "results_count": 1500,
  "sort_by": "relevance",
  "saved": false,
  "results": [
    {
      "id": "all_filled_all_visible",
      "title": "All fields Filled & Visible",
      "created_at": "2014-09-20 11:33:00Z",
      "updated_at": "2014-09-20 11:33:00Z",
      "quality": 7.0,
      "description": "Some Crazy long description goes here.....",
      "category": "International Organizations Document"
    },
    {
      "id": "not_filled_all_visible",
      "title": "All optional fields are emtpy & visible",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": 7.0,
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies"
    },
    {
      "id": "all_hidden",
      "title": "All fields are hidden",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": 7.0,
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies"
    }
  ],
  "filters": {}
}

suggestionData = {
  "suggestions": [
    {"query": "HIV", "count": 1544},
    {"query": "HIV Positive", "count": 444},
    {"query": "HIV Research in Africa", "count": 987},
    {"query": "HIV Things", "count": 543}
  ]
}
