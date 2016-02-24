UrlStore = require('stores/url_store')

dateRangePattern = /^\[(\d+_\d+),(\d{4})?,?(\d{4})?\]/
countriesPattern = /^\[(\d+_\d+),([a-z_]+)\]/

module.exports =
  deserializeSearchUrl: ->
    params = UrlStore.state.params

    if !_.isEmpty(params.applied_filters)
      applied_filters = params.applied_filters?.split(';')

    related_article = null
    if params.related_article_id
      related_article = {id: params.related_article_id}

    {
      query: if params.q? then params.q else ''
      sort_by: params.sort_by || 'relevance'
      results: []
      results_count: 0
      applied_filters: applied_filters || []
      filters: []
      related_article: related_article || null
    }
