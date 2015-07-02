module.exports = React.createClass
  displayName: 'SortOrder'
  render: ->
    <div className="sort-order">
      <span className="sort-order-label">Sort by</span>
      <select className="sort-order-control">
        <option>Relevance</option>
        <option>Most Recent</option>
        <option>Most Popular</option>
      </select>
    </div>