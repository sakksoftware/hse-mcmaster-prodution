FilterActions = require('actions/filter_actions')
RefluxStateMixin = require('lib/reflux_state_mixin')(Reflux)

module.exports = Reflux.createStore
  listenables: [FilterActions]
  mixins: [RefluxStateMixin]

  getInitialState: ->
    filters: []
    loaded: false
    errors: null

  #############
  # Data access
  #############
  findFilter: (filter) ->
    @_findFilterRecursive @_getId(filter), @state.filters

  #############
  # Events
  #############
  onLoadFiltersCompleted: (data, lang) ->
    @setState(filters: data.filters, loaded: true, errors: null)

  onLoadFiltersFailed: (xhr, statusCode, responseText) ->
    @setState(loaded: false, errors: responseText)

  # private
  _findFilterRecursive: (filterId, filters) ->
    for filter in filters
      if filter.id == filterId
        return filter
      else if filter.filters
        if result = @_findFilterRecursive(filterId, filter.filters)
          return result

    return null

  _getId: (filter) ->
    if _.isString(filter) or _.isNumber(filter)
      filter
    else
      filter.id
