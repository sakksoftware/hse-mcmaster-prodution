module.exports =
  isFilterObject: (obj) -> obj?.id
  getFiltersArray: (filters) ->
    results = []
    return results unless filters
    
    for filter in filters
      nestedFilters = _.clone(filter.filters)

      if @isFilterObject(filter)
        results.push _.omit(filter, 'filters')
      if nestedFilters
        results = results.concat @getFiltersArray(nestedFilters)

    return results
