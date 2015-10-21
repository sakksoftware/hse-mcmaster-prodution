SearchSerializationService = require('services/search_serialization_service')
Link = require('components/shared/link')
NotificationActions = require('actions/notification_actions')
Toggle = ReactToggle
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'SavedSearchItem'

  mixins: [SearchSerializationService, TranslationHelper]
  baseTranslation: 'saved_search_page'

  propTypes:
    search: React.PropTypes.object.isRequired
    onSelect: React.PropTypes.func
    selected: React.PropTypes.bool

  getDefaultProps: ->
    selected: false
    onSelect: ->

  onSelect: (e) ->
    @props.onSelect(@props.search)

  getUrlParams: ->
    "#{@serializeSearchUrl()}"

  confirmSubscriptionToggle: ->
    NotificationActions.showDialog(message: @t('dialog.message'), cancelText: @t('dialog.cancel'), confirmText: @t('dialog.confirm'), onConfirm: @toggleSubscription)

  toggleSubscription: ->
    console.log('toggling your subscription')

  render: ->
    <li className="saved-search-item list-item">
      <div className="saved-search-item-header">
        <h2>
          <Link to={['/search', @serializeSearchParams(@props.search)]}>{@props.search.query}</Link>
        </h2>
        <label className="saved-search-select action">
          <span>{@t('select')}</span>
          <input type="checkbox" onClick={@onSelect} defaultChecked={@props.selected} />
        </label>
      </div>
      <label className="saved-search-control">
        <span>{@t('subscribe')}</span>
        <Toggle defaultChecked={@props.search.subscribed} onClick={@confirmSubscriptionToggle} />
      </label>
    </li>
