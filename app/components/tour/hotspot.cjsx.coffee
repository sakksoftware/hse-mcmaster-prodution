Button = require('components/shared/button')
TranslationHelper = require('mixins/translation_helper')
TourActions = require('actions/tour_actions')

NotificationActions = require('actions/notification_actions')

module.exports = React.createClass
  displayName: 'Hotspot'

  mixins: [TranslationHelper]
  baseTranslation: ''

  propTypes:
    tourKey: React.PropTypes.string.isRequired
    text: React.PropTypes.string.isRequired

  getInitialState: ->
    showInfo: false

  showInfo: ->
    if @state.showInfo
      'block'
    else
      'none'

  showHotspot: ->
    if !@state.showInfo
      'block'
    else
      'none'

  onHotspotClick: ->
    NotificationActions.showDialog(title: 'Hotspot', message: @props.text, onConfirm: @dismiss, confirmText: @t('/tour.got_it'), displayCancel: false)

  dismiss: ->
    TourActions.markStepCompleted(key: @props.tourKey)

  render: ->
    <div className="hotspot">
      <div className="hotspot-indicator-wrapper" onClick={@onHotspotClick}>
        <div className="hotspot-indicator"></div>
      </div>
    </div>
