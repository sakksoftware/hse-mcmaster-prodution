serializeParams = require('lib/url').serializeParams
FilterNormalizationService = require('services/filter_normalization_service')

ANY_FILTER_IDS = ["2_-1", "2_1004", "2_1", "2_2", "2_3", "2_4", "0_6", "0_7", "0_8", "0_9", "0_10", "0_11", "0_12", "0_13", "0_14", "0_15", "0_16", "0_17", "0_18"]

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
      result.push filter.id unless ANY_FILTER_IDS.indexOf(filter.id.toString()) > 0

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
