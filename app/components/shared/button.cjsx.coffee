module.exports = React.createClass
  displayName: 'Button'

  propTypes:
    children: React.PropTypes.any.isRequired
    onClick: React.PropTypes.func
    className: React.PropTypes.string

  onClick: (e) ->
    e.preventDefault()
    @props.onClick?(e)

  render: ->
    <a href="#" className="button #{@props.className}" onClick={@onClick}>{@props.children}</a>
