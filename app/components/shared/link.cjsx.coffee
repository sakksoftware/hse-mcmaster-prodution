router = require('lib/router')

module.exports = React.createClass
  displayName: 'Link'
  propTypes:
    to: React.PropTypes.string.isRequired
    children: React.PropTypes.node.isRequired

  handleClick: (e) ->
    e.preventDefault()
    router.visit(@props.to)

  render: ->
    <a href={@props.to} onClick={@handleClick}>
      {@props.children}
    </a>