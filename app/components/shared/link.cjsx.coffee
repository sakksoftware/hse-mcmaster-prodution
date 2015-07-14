module.exports = React.createClass
  displayName: 'Link'
  propTypes:
    to: React.PropTypes.string.isRequired
    children: React.PropTypes.node.isRequired
    className: React.PropTypes.string

  handleClick: (e) ->
    e.preventDefault()
    router = require('lib/router')
    if @props.to == 'back'
      router.back()
    else
      router.visit(@props.to)

  render: ->
    <a href={@props.to} onClick={@handleClick} className={@props.className}>
      {@props.children}
    </a>