Url = require('lib/url')

dateRangePattern = /^\[(\d+-\d+),(\d{4})?,?(\d{4})?\]/
countriesPattern = /^\[(\d+-\d+),([a-z_]+)\]/

module.exports =
  deserializeSearchUrl: ->
    params = Url.params()
    applied_filters = params.applied_filters?.split(';')
    # set applied filters until we fetch filers from search
    filters = applied_filters?.map (f) ->
      if match = f.match(dateRangePattern)
        id: match[1], applied: true, start: match[2], end: match[3], name: 'date_range'
      else if match = f.match(countriesPattern)
        id: match[1], applied: true, mode: match[2], name: 'countries'
      else
        id: f, applied: true

    {
      query: if params.q? then params.q else null
      sort_by: params.sort_by || 'relevance'
      results: null
      applied_filters: applied_filters || null
      filters: filters || []
    }
