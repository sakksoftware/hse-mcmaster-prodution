serializeParams = require('lib/url').serializeParams
FilterNormalizationService = require('services/filter_normalization_service')

serializeSearchParams = (search, language, options = {}) ->
  options = _.extend({includePage: false}, options)
  query = search.query || ""
  sortBy = search.sort_by || "relevance"
  applied_filters = serializeAppliedFilters(search.filters)
  if options.includePage
    page = search.page || 1
  else
    page = undefined

  q: query
  sort_by: sortBy
  language: language
  applied_filters: applied_filters
  page: page

module.exports =
  serializeSearchParams: serializeSearchParams
  serializeSearchUrl: (search, language, options) ->
    serializeParams(serializeSearchParams(search, language, options))

# private
serializeAppliedFilters = (filters) ->
  appliedFilters = getAppliedFilters(filters) || []
  result = []

  for filter in appliedFilters
    if filter.type == 'countries_countries'
      result.push "[#{filter.id},#{filter.mode}]"
    else if filter.type == 'date_range'
      end = if filter.end then ",#{filter.end}" else ""
      result.push "[#{filter.id},#{filter.start}#{end}]"
    else
      result.push filter.id

  result.join(';')



getAppliedFilters = (filters) ->
  filters = FilterNormalizationService.getFiltersArray(filters)
  filters.filter((e) -> e.applied)
