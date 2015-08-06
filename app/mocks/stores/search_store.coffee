API = require('lib/api')
config = require('config')[window.ENV]
SearchActions = require('actions/search_actions')
StoreMock = require('mocks/support/store_mock')
FilterNormalizationService = require('services/filter_normalization_service')

console.log('loaded mock search')

module.exports = Reflux.createStore
  listenables: [SearchActions]
  mixins: [StoreMock, FilterNormalizationService]

  _addAppliedProperty: (filters, applied_filters) ->
    _(filters).each (f) =>
      if f.id
        f.applied = applied_filters.indexOf(f.id) >= 0
      if f.filters
        @_addAppliedProperty(f.filters, applied_filters)

  search: (query, success, error, options = {}) ->
    options = _.extend {sortBy: 'relevance', filters: []}, options
    filters = @getFilters()
    applied_filters = _(options.applied_filters).pluck('id')

    @_addAppliedProperty(filters, applied_filters)

    res = searchData
    res.filters = filters
    res.query = query
    res.sort_by = options.sortBy

    @send(res, success, '/search')

  suggestions: (query, success, error, options = {}) ->
    console.log('using mock suggestions')

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
      "id": "0df62f0040ffd8ecd725c9a602056034",
      "title": "Article Title A",
      "created_at": "2014-09-20 11:33:00Z",
      "updated_at": "2014-09-20 11:33:00Z",
      "quality": 7.0,
      "description": "Some Crazy long description goes here.....",
      "category": "International Organizations Document"
    },
    {
      "id": "40e3343c159defef46c266410a1a9059",
      "title": "Article Title B",
      "created_at": "2014-02-30 11:00:00Z",
      "updated_at": "2014-02-30 11:00:00Z",
      "quality": 7.0,
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies"
    }
  ],
  "questions": [
    {
      "text": "Do you want to know about particular types of health system arrangements?",
      "filters": [
        {"name": "How decisions (about care) are made", "type": "document", "id": 1234, "count": "350", "applied": false },
        {"name": "How care is paid for", "type": "document", "id": 1235, "count": "200", "applied": false },
        {"name": "How care is organized", "type": "document", "id": 1236, "count": "100", "applied": false },
        {"name": "How change can be brought about", "type": "document", "id": 1236, "count": "100", "applied": false }
      ]
    },
    {
      "text": "Q2: Narrow your search by selecting one of the options below.",
      "filters": [
        {"name": "All of them", "id": 1234, "count": "350", "applied": false },
        {"name": "Option A", "id": 1235, "count": "200", "applied": false },
        {"name": "Option B", "id": 1236, "count": "100", "applied": false }
      ]
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
