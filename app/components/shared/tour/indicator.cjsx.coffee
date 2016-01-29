# var React = require('react/addons');

Indicator = React.createClass
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
    handleIndicatorClick: React.PropTypes.func.isRequired
  getDefaultProps: ->
    {
      cssPosition: 'absolute'
      xPos: -1000
      yPos: -1000
    }
  render: ->
    styles =
      'position': if @props.cssPosition == 'fixed' then 'fixed' else 'absolute'
      'top': @props.yPos
      'left': @props.xPos

    <div className="tour-indicator" style={styles} onClick={this.props.handleIndicatorClick} />


module.exports = Indicator
