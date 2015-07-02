module.exports = React.createClass
  displayName: 'FilterItem'
  propTypes:
    filter: React.PropTypes.object.isRequired
  render: ->
    <li className="filter-item">
      <a href="#">{@props.filter.name} ({@props.filter.count})</a>
    </li>