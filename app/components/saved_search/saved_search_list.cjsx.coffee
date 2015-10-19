SavedSearchItem = require('components/saved_search/saved_search_item')
Button = require('components/shared/button')

module.exports = React.createClass
  displayName: 'SavedSearchList'

  propTypes:
    searches: React.PropTypes.array.isRequired

  renderItems: ->
    for search in @props.searches
      <SavedSearchItem search={search} key="saved-search-item-#{search.id}"/>

  render: ->
    <div className="saved-search-list">
      <div className="saved-search-list-header">
        <span>You can subscribe upto one saved search and one curated search</span>
        <ul className="saved-search-list-actions list-inline">
          <li className="action remove-selected"><Button>Remove selected</Button></li>
          <li className="action">
            <label>Select all <input type="checkbox" name="search_to_delete"/></label>
          </li>
        </ul>
      </div>
      <ul className="saved-search-list-content list">
        {@renderItems()}
      </ul>
    </div>
