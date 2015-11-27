UrlActions = require('actions/url_actions')

SearchActions = require('actions/search_actions')
SearchSerializationService = require('services/search_serialization_service')
SearchDeserializationService = require('services/search_deserialization_service')
RefluxStateMixin = require('lib/reflux_state_mixin')(Reflux)

UserStore = require('stores/user_store')

module.exports = Reflux.createStore
  listenables: [SearchActions]
  mixins: [RefluxStateMixin, SearchSerializationService, SearchDeserializationService]

  init: ->
    UserStore.listen(@onUserStoreUpdated)

  resetState: ->
    # DO STUFF

  getInitialState: ->
    search: @deserializeSearchUrl()
    errors: null
    loaded: false

  ################
  # Data accessors
  ################
  findFilter: (filter) ->
    @_findFilterRecursive @_getId(filter), @state.search.filters

  hasAppliedFiltersFor: (filter) ->
    return true if filter.applied
    return false unless filter.filters

    for f in filter.filters
      return true if f.applied
      return true if f.filters && @hasAppliedFiltersFor(f)

    return false

  getAppliedFilterGroups: ->
    @_getAppliedFilterGroups(@state.search.filters)

  notifySaved: (value, id) ->
    search = _.clone(@state.search)
    search.saved = value
    search.saved_search_id = id
    # cannot remain subscribed if search is not saved
    if value == false
      search.subscribed = false
      search.saved_search_id = null

    @setState(search: search)

  notifySubscribed: (value) ->
    search = _.clone(@state.search)
    search.subscribed = value
    @setState(search: search)

  ################
  # event handlers
  ################
  onUserStoreUpdated: (state) ->
    if state.loaded
      # TODO: should I start using constant for errors instead of strings?
      errors = _.without(@state.errors, 'reached_search_limit')
      search = _.clone(@state.search)
      search.page = 1
      @setState(search: search, errors: errors)

  onSearch: (search) ->
    @setState(loaded: false)
    @_updateUrl()

  onSearchCompleted: (search) ->
    # TODO: probably want to do a deep clone here before modify search
    if search.page > 1
      search.results = @state.search.results.concat(search.results)

    @setState(search: search, errors: null, loaded: true)

  onLoadMore: (page) ->
    search = _.clone(@state.search)
    search.page = page
    SearchActions.search(search)

  onSortBy: (sortBy) ->
    search = _.clone(@state.search)
    search.sort_by = sortBy
    search.page = 1
    @setState(search: search)
    @_updateUrl()
    SearchActions.search(@state.search)

  onAddFilter: (filter) ->
    @onChangeFilterValue(filter, true)

  onRemoveFilter: (filter) ->
    @onChangeFilterValue(filter, false)

  onRemoveFilterGroup: (filterGroup) ->
    @onChangeParentFilterValue(filterGroup, false)

  onChangeFilterValue: (filter, value) ->
    filter = @findFilter filter
    filter.applied = value
    search = _.clone(@state.search)
    search.page = 1
    @setState(search: search)
    @_updateUrl()
    SearchActions.search(@state.search)

  onChangeParentFilterValue: (parentFilter, value) ->
    parentFilter = @findFilter parentFilter
    @_changeParentFilterValue(parentFilter, value)
    search = _.clone(@state.search)
    search.page = 1
    @setState(search: search)
    @_updateUrl()
    SearchActions.search(@state.search)

  onToggleNestedFilter: (filter) ->
    @onChangeParentFilterValue(filter, !filter.applied)

  onToggleFilter: (filter) ->
    if filter.filters
      return @onToggleNestedFilter(filter)

    if filter.applied
      @onRemoveFilter(filter)
    else
      @onAddFilter(filter)

  onToggleCountryFilter: (filter, filterGroup, mode) ->
    filter = @findFilter(filter)
    filter.applied = !filter.applied
    filterGroup = @findFilter(filterGroup)

    if _.find(filterGroup.filters, (f) -> f.applied)
      filterGroup.applied = true
    else
      filterGroup.applied = false

    filterGroup.mode = mode
    @setState(search: @state.search)
    search = _.clone(@state.search)
    search.page = 1
    @_updateUrl()
    SearchActions.search(@state.search)

  onToggleDateRangeFilter: (filter, start, end) ->
    filter = @findFilter(filter)

    if _.isEmpty(start) && _.isEmpty(end)
      @onRemoveFilter(filter)
    else
      filter.applied = false
      filter.start = start
      filter.end = end
      @onAddFilter(filter)

  onLoadFiltersCompleted: (search) ->
    @setState(search: search, errors: null, loaded: true)

  # private
  _updateUrl: ->
    UrlActions.setParams(@serializeSearchParams(@state.search))

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

  _changeParentFilterValue: (parentFilter, value) ->
    parentFilter.applied = value
    for filter in parentFilter.filters
      filter.applied = value
      if filter.filters
        @_changeParentFilterValue(filter, value)

  _getAppliedFilterGroups: (filters) ->
    appliedFilters = []

    for filter in filters
      filter = _.clone(filter)

      if filter.filters
        filter.filters = @_getAppliedFilterGroups(filter.filters)

      if filter.applied || filter.filters?.length > 0
        appliedFilters.push filter

    appliedFilters
