UrlStore = require('stores/url_store')

dateRangePattern = /^\[(\d+_\d+),(\d{4})?,?(\d{4})?\]/
countriesPattern = /^\[(\d+_\d+),([a-z_]+)\]/

module.exports =
  deserializeSearchUrl: ->
    params = UrlStore.state.params

    if !_.isEmpty(params.applied_filters)
      applied_filters = params.applied_filters?.split(';')

    # set applied filters until we fetch filers from search
    filters = applied_filters?.map (f) ->
      if match = f.match(dateRangePattern)
        id: match[1], applied: true, attributes: [match[2], match[3]], type: 'date_range'
      else if match = f.match(countriesPattern)
        id: match[1], applied: true, attributes: [match[2]], type: 'countries_countries'
      else
        id: f, applied: true, type: ''

    related_article = null
    if params.related_article_id
      related_article = {id: params.related_article_id}

    {
      query: if params.q? then params.q else ''
      sort_by: params.sort_by || 'relevance'
      results: null
      results_count: 0
      applied_filters: applied_filters || []
      filters: filters || []
      related_article: related_article || null
    }
