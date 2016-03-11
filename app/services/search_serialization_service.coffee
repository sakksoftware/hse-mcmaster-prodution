serializeParams = require('lib/url').serializeParams
FilterNormalizationService = require('services/filter_normalization_service')

# private
serializeAppliedFilters = (filters) ->
  appliedFilters = getAppliedFilters(filters) || []
  result = []

  for filter in appliedFilters
    if filter.type == 'countries_countries'
      result.push "[#{filter.id},#{filter.attributes?[0]}]"
    else if filter.type == 'date_range'
      result.push "[#{filter.id},#{filter.attributes?[0] || ''},#{filter.attributes?[1] || ''}]"
    else
      result.push filter.id

  result

serializeSearchParams = (search, language, options = {}) ->
  options = _.extend({includePage: false}, options)
  query = search.query || ""
  sortBy = search.sort_by || ""
  applied_filters = serializeAppliedFilters(search.filters).join(';')
  related_article_id = search.related_article?.id

  params =
    q: query
    sort_by: sortBy
    applied_filters: applied_filters

  if options.includePage
    params.page = search.page || 1

  if language
    params.lang = language

  if related_article_id
    params.related_article_id = related_article_id

  params

getAppliedFilters = (filters) ->
  filters = FilterNormalizationService.getFiltersArray(filters)
  filters.filter((e) -> e.applied)

# public
module.exports =
  serializeSearchParams: serializeSearchParams
  serializeSearchUrl: (search, language, options) ->
    serializeParams(serializeSearchParams(search, language, options))

  serializeAppliedFilters: serializeAppliedFilters
