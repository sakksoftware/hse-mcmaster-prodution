Button = require('components/shared/button')
TranslationHelper = require('mixins/translation_helper')
TourActions = require('actions/tour_actions')

module.exports = React.createClass
  displayName: 'Hotspot'

  mixins: [TranslationHelper]
  baseTranslation: ''

  propTypes:
    key: React.PropTypes.string.isRequired
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

  dismiss: ->
    TourActions.markStepCompleted(key: @props.key)

  render: ->
    <div className="hotspot">
      <div className="hotspot-indicator-wrapper" onClick={=> @setState(showInfo: true)}>
        <div className="hotspot-indicator"></div>
      </div>
      <div className="hotspot-info" style={display: @showInfo()}>
        {@props.text}
        <div className="actions">
          <Button className="btn btn-primary" onClick={@dismiss}>{@t('/tour.got_it')}</Button>
        </div>
      </div>
    </div>
