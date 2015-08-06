module.exports = React.createClass
  displayName: 'FilterItem'
  propTypes:
    filter: React.PropTypes.object.isRequired
    onAddFilter: React.PropTypes.func.isRequired

  handleAdd: (e) ->
    e.preventDefault()
    @props.onAddFilter(@props.filter)

  render: ->
    <li className="filter-item">
      <a href="#" onClick={@handleAdd}>{@props.filter.name} ({@props.filter.count})</a>
    </li>
