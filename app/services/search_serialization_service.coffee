FilterNormalizationService = require('services/filter_normalization_service')

module.exports =
  serializeSearchUrl: (search) ->
    query = search.query || ""
    sortBy = search.sort_by || "relevance"
    applied_filters = serializeAppliedFilters(search.filters)
    "?q=#{query}&sort_by=#{sortBy}&applied_filters=#{applied_filters}"

# private
serializeAppliedFilters = (filters) ->
  appliedFilters = getAppliedFilters(filters) || []
  result = []

  for filter in appliedFilters
    if filter.name == "countries"
      result.push "[#{filter.id},#{filter.mode}]"
    else if filter.name == "date_range"
      end = if filter.end then ",#{filter.end}" else ""
      result.push "[#{filter.id},#{filter.start}#{end}]"
    else
      result.push filter.id

  result.join(';')



getAppliedFilters = (filters) ->
  filters = FilterNormalizationService.getFiltersArray(filters)
  filters.filter((e) -> e.applied)