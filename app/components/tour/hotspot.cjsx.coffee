Button = require('components/shared/button')
TranslationHelper = require('mixins/translation_helper')
TourActions = require('actions/tour_actions')
TourStore = require('stores/tour_store')

NotificationActions = require('actions/notification_actions')

module.exports = React.createClass
  displayName: 'Hotspot'

  mixins: [TranslationHelper]
  baseTranslation: ''

  propTypes:
    tourKey: React.PropTypes.string.isRequired

  getInitialState: ->
    show: TourStore.getStep(@props.tourKey)

  componentWillMount: ->
    @unsubscribeTour = TourStore.listen(@tourStoreUpdated)

  componentWillUnmount: ->
    @unsubscribeTour()

  tourStoreUpdated: (state) ->
    step = _(state.steps).find (s) => s.key == @props.tourKey

    # one step at a time approach
    # if state.steps[0]?.key == @props.tourKey
    if step
      @setState(show: true)
    else
      @setState(show: false)

  showHotspot: ->
    if @state.show
      'block'
    else
      'none'

  onHotspotClick: (e) ->
    e.preventDefault()
    e.stopPropagation()
    NotificationActions.showDialog(title: 'Hotspot', message: @t("/tour.steps.#{@props.tourKey}"), onConfirm: @dismiss, confirmText: @t('/tour.got_it'), displayCancel: false)

  dismiss: ->
    TourActions.markStepCompleted(key: @props.tourKey)

  render: ->
    <div className="hotspot" style={display: @showHotspot()}>
      <div className="hotspot-indicator-wrapper" onClick={@onHotspotClick}>
        <div className="hotspot-indicator"></div>
      </div>
    </div>
