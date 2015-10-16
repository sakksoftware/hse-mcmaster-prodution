SavedSearchItem = require('components/saved_search/saved_search_item')

module.exports = React.createClass
  displayName: 'SavedSearchList'

  propTypes:
    searches: React.PropTypes.array.isRequired

  renderItems: ->
    for search in @props.searches
      <SavedSearchItem search={search} key="saved-search-item-#{search.id}"/>

  render: ->
    <ul className="saved-search-list">
      {@renderItems()}
    </ul>
