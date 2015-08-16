FilterNormalizationService = require('services/filter_normalization_service')

module.exports =
  serializeSearchUrl: (search) ->
    query = search.query || ""
    applied_filters = getAppliedFilters(search.filters) || []
    sortBy = search.sort_by || "relevance"
    countries_mode = ''#search.countries_mode ? "&countries_mode=#{options.countries_mode}" : ""

    applied_filters = _(applied_filters).pluck('id').join(";")
    "?q=#{query}&sort_by=#{sortBy}&applied_filters=#{applied_filters}#{countries_mode}"

# private
getAppliedFilters = (filters) ->
  filters = FilterNormalizationService.getFiltersArray(filters)
  filters.filter((e) -> e.applied)
