SearchSerializationService = require('services/search_serialization_service')
Link = require('components/shared/link')
NotificationActions = require('actions/notification_actions')
Toggle = ReactToggle
ApplicationHelper = require('mixins/application_helper')
TranslationHelper = require('mixins/translation_helper')
SelectableItem = require('components/shared/selectable_item')
SearchStore = require('stores/search_store')

# TODO: temporary work around, server should mark these as top level with `is_top_level` flag
topLevelFilterIds = ["2_-1", "2_1004", "2_1", "2_2", "2_3", "2_4", "0_6", "0_7", "0_8", "0_9", "0_10", "0_11", "0_12", "0_13", "0_14", "0_15", "0_16", "0_17", "0_18"]

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
    if topLevelFilterIds.indexOf(filter.id) >= 0
      title = title.toUpperCase()

    <li className="applied-filter-item" key="filter-#{i}">
      <div className="applied-filter-item-content">
        <span className="applied-filter-item-filters">{title}</span>
      </div>
    </li>

  renderAppliedFilters: ->
    filters = @props.search.filters
    return if !filters || filters.length <= 0

    <ul className="applied-filters">
      {
        for filter, i in filters
          @renderAppliedFilter(filter, i)
      }
    </ul>

  render: ->
    <SelectableItem {...@props} showSelect={false} className="saved-search-item list-item">
      <div className="saved-search-item-header clearfix">
        <h2>
          <Link to={['/search', @serializeSearchParams(@props.search)]}>
            {@props.search.query}
          </Link>
        </h2>
        {
          if @props.showSelect
            <label className="saved-search-select action">
              <span>{@t('/select')}</span>
              <input type="checkbox" onChange={=> @props.toggleSelect(@)} defaultChecked={@props.selected} />
            </label>
        }
      </div>
      {@renderAppliedFilters()}
      <label className="saved-search-control">
        <span>{@t('subscribe')}</span>
        <Toggle checked={@props.search.subscribed} onChange={@confirmSubscriptionToggle} />
      </label>
    </SelectableItem>
