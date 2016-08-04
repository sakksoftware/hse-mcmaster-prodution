TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'MenuFilterItem'
  mixins: [TranslationHelper]
  baseTranslation: 'menus.filters'
  propTypes:
    filter: React.PropTypes.object.isRequired
    onToggle: React.PropTypes.func.isRequired
    indicatorColor: React.PropTypes.string
    className: React.PropTypes.string

  handleToggle: (e) ->
    e.preventDefault()
    @props.onToggle(@props.filter)

  getFilterTitle: ->
    filter = @props.filter
    return filter.title if filter.any

    @t("/filters.#{filter.id}")

  renderCheckMark: (filter) ->
    if filter.applied
      <i className="checkmark"></i>

  render: ->
    filter = @props.filter
    style = {}
    if @props.indicatorColor
      style =
        borderColor: @props.indicatorColor
        borderLeftWidth: "4px"
        borderLeftStyle: "solid"

    <li className="menu-item menu-filter-item #{@props.className}" style={style}>
      <a className="menu-item-text" href="#" onClick={@handleToggle}>{@getFilterTitle()}</a>
      {@renderCheckMark(filter)}
    </li>
