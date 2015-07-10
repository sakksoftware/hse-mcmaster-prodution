router = require('lib/router')

module.exports = React.createClass
  displayName: 'Link'
  propTypes:
    to: React.PropTypes.string.isRequired
    children: React.PropTypes.node.isRequired
    className: React.PropTypes.string

  handleClick: (e) ->
    e.preventDefault()
    if @props.to == 'back'
      router.back()
    else
      router.visit(@props.to)

  render: ->
    <a href={@props.to} onClick={@handleClick} className={@props.className}>
      {@props.children}
    </a>