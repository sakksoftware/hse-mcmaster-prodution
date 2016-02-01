# var React = require('react/addons');
Tooltip = React.createClass
  propTypes:
    cssPosition: React.PropTypes.string.isRequired
    xPos: React.PropTypes.oneOfType([
      React.PropTypes.number
      React.PropTypes.string
    ]).isRequired
    yPos: React.PropTypes.oneOfType([
      React.PropTypes.number
      React.PropTypes.string
    ]).isRequired
    text: React.PropTypes.string.isRequired
    closeButtonText: React.PropTypes.string
    closeTooltip: React.PropTypes.func.isRequired
  getDefaultProps: ->
    {
      cssPosition: 'absolute'
      xPos: -1000
      yPos: -1000
      text: ''
    }
  render: ->
    styles =
      'position': if @props.cssPosition == 'fixed' then 'fixed' else 'absolute'
      'top': @props.yPos
      'left': @props.xPos

    <div>
     <div className="tour-backdrop" onClick={this.props.closeTooltip} />
     <div className="tour-tooltip" style={styles}>
       <p>{this.props.text || ''}</p>
       <div className="tour-btn" onClick={this.props.closeTooltip}>
         {this.props.closeButtonText || 'Close'}
       </div>
     </div>
    </div>

module.exports = Tooltip
