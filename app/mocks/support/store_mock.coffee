config = require('config')
allCountries = require('constants/countries_list')

module.exports =
  send: (res, success) ->
    callback = =>
      console.log("response:", res)
      success(res)

    setTimeout callback, config.mockResponseTime

  addCountryFilters: (filters) ->
    filters = _.clone(filters)
    countryFilters = _.map allCountries, (country) ->
      id: country.id
      code: country.code
      name: country.name
      type: 'country'

    for f in countryFilters
      filters.push(f) unless _(filters).findWhere({id: f.id})

    filters
