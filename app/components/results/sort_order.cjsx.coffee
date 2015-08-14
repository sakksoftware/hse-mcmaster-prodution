module.exports = React.createClass
  displayName: 'SortOrder'
  propTypes:
    sortBy: React.PropTypes.string.isRequired
    onChange: React.PropTypes.func.isRequired

  handleChange: (e) ->
    @props.onChange(e.target.value)

  render: ->
    <div className="sort-order">
      <span className="sort-order-label">Results sorted by</span>
      <select className="sort-order-control" onChange={@handleChange} defaultValue={@props.sortBy}>
        <option value="relevance">Relevance</option>
        <option value="most_recent">Most Recent</option>
        <option value="most_popular">Most Popular</option>
      </select>
    </div>
