SearchSerializationService = require('services/search_serialization_service')
Link = require('components/shared/link')
NotificationActions = require('actions/notification_actions')
Toggle = ReactToggle
ApplicationHelper = require('mixins/application_helper')
TranslationHelper = require('mixins/translation_helper')
SelectableItem = require('components/shared/selectable_item')
SearchStore = require('stores/search_store')
FilterNormalizationService = require('services/filter_normalization_service')
Checkbox = require('components/shared/checkbox')

module.exports = React.createClass
  displayName: 'SavedSearchItem'

  mixins: [SearchSerializationService, TranslationHelper, ApplicationHelper]
  baseTranslation: 'saved_search_page'

  propTypes:
    search: React.PropTypes.object.isRequired
    toggleSelect: React.PropTypes.func
    selected: React.PropTypes.bool
    showSelect: React.PropTypes.bool

  getDefaultProps: ->
    selected: false
    showSelect: true
    onToggleSubscription: ->
    toggleSelect: ->

  getUrlParams: ->
    "#{@serializeSearchUrl()}"

  toggleSubscription: ->
    @props.onToggleSubscription(@props.search)

  confirmSubscriptionToggle: ->
    if !@props.search.subscribed
      NotificationActions.showDialog
        message: @t('dialog.message'),
        cancelText: @t('dialog.cancel'),
        confirmText: @t('dialog.confirm'),
        onConfirm: @toggleSubscription
    else
      @toggleSubscription()

  renderAppliedFilter: (filter, i) ->
    title = filter.title
    <li className="applied-filter-item" key="filter-#{i}">
      <div className="applied-filter-item-content">
        <span className="applied-filter-item-filters">{title}</span>
      </div>
    </li>

  renderAppliedFilters: ->
    filters = FilterNormalizationService.getFiltersArray(@props.search.filters)
    filters = filters.filter((e) -> e.applied)
    return if !filters || filters.length <= 0

    <div className="applied-filters-wrapper">
      <span className="saved-search-filters-label">{@t('filters')}</span>
      <ul className="applied-filters">
        {
          for filter, i in filters
            @renderAppliedFilter(filter, i)
        }
      </ul>
    </div>

  renderKeywords: ->
    return unless @props.search.query

    <div className="saved-search-keywords">
      <span className="saved-search-keywords-label">{@t('keywords')}</span>
      <span className="saved-search-keywords-value">{@props.search.query}</span>
    </div>

  renderSelect: ->
    return unless @props.showSelect

    <label className="saved-search-select action">
      <span>{@t('/select')}</span>
      <Checkbox onChange={=> @props.toggleSelect(@)} checked={@props.selected} />
    </label>

  render: ->
    <SelectableItem {...@props} showSelect={false} className="saved-search-item list-item">
      <div className="saved-search-item-header clearfix">
        <h2>
          <Link to={['/search', @serializeSearchParams(@props.search)]}>
            {@props.search.name || @props.search.query}
          </Link>
        </h2>
        {@renderSelect()}
      </div>
      {@renderKeywords()}
      {@renderAppliedFilters()}
      <label className="saved-search-control">
        <span>{@t('subscribe')}</span>
        <Toggle checked={@props.search.subscribed} onChange={@confirmSubscriptionToggle} />
      </label>
    </SelectableItem>
