SearchSerializationService = require('services/search_serialization_service')
Link = require('components/shared/link')
NotificationActions = require('actions/notification_actions')
Toggle = ReactToggle
ApplicationHelper = require('mixins/application_helper')
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'SavedSearchItem'

  mixins: [SearchSerializationService, TranslationHelper, ApplicationHelper]
  baseTranslation: 'saved_search_page'

  propTypes:
    search: React.PropTypes.object.isRequired
    onSelect: React.PropTypes.func
    selected: React.PropTypes.bool

  getDefaultProps: ->
    selected: false
    onToggleSubscription: ->
    onSelect: ->


  onSelect: (e) ->
    @props.onSelect(@props.search)

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

  renderAppliedFilters: ->
    filters = @props.search.filters
    return if !filters || filters.length <= 0

    " (#{@ellipsis(_.pluck(filters, 'title').join(', '), 30)})"

  render: ->
    <li className="saved-search-item list-item">
      <div className="saved-search-item-header clearfix">
        <h2>
          <Link to={['/search', @serializeSearchParams(@props.search)]}>
            {@props.search.query}
            {@renderAppliedFilters()}
          </Link>
        </h2>
        <label className="saved-search-select action">
          <span>{@t('/select')}</span>
          <input type="checkbox" onChange={@onSelect} defaultChecked={@props.selected} />
        </label>
      </div>
      <label className="saved-search-control">
        <span>{@t('subscribe')}</span>
        <Toggle checked={@props.search.subscribed} onChange={@confirmSubscriptionToggle} />
      </label>
    </li>
