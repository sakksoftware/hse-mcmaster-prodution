SearchSerializationService = require('services/search_serialization_service')
Link = require('components/shared/link')
NotificationActions = require('actions/notification_actions')
Toggle = ReactToggle
ApplicationHelper = require('mixins/application_helper')
TranslationHelper = require('mixins/translation_helper')
SelectableItem = require('components/shared/selectable_item')

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
    return if filters.length <= 0

    " (#{@ellipsis(_.pluck(filters, 'title').join(', '), 30)})"

  render: ->
    <SelectableItem {...@props} className="saved-search-item list-item">
      <div className="saved-search-item-header clearfix">
        <h2>
          <Link to={['/search', @serializeSearchParams(@props.search)]}>
            {@props.search.query}
            {@renderAppliedFilters()}
          </Link>
        </h2>
      </div>
      <label className="saved-search-control">
        <span>{@t('subscribe')}</span>
        <Toggle checked={@props.search.subscribed} onChange={@confirmSubscriptionToggle} />
      </label>
    </SelectableItem>
