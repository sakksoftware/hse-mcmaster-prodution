SavedSearchItem = require('components/saved_search/saved_search_item')
Button = require('components/shared/button')
UserActions = require('actions/user_actions')

module.exports = React.createClass
  displayName: 'SavedSearchList'

  propTypes:
    searches: React.PropTypes.array.isRequired

  getInitialState: ->
    selectedSearches: []

  toggleSelectAll: (ev) ->
    searches = _.difference(@props.searches, @state.selectedSearches)
    @setState(selectedSearches: searches)

  addSelected: (search) ->
    selectedSearches = @state.selectedSearches
    selectedSearches.push(search)
    @setState(selectedSearches: selectedSearches)

  removeSelected: ->
    UserActions.removeSearches(@state.selectedSearches)

  renderItems: ->
    for search in @props.searches
      selected = !!_.findWhere(@state.selectedSearches, id: search.id)
      <SavedSearchItem search={search}
        key="saved-search-item-#{search.id}-#{'selected' if selected}"
        selected={selected}
        onSelect={@addSelected}
      />

  render: ->
    <div className="saved-search-list">
      <div className="saved-search-list-header">
        <span className="saved-search-list-instructions">You can subscribe upto one saved search and one curated search</span>
        <ul className="saved-search-list-actions list-inline">
          <li className="action remove-selected"><Button onClick={@removeSelected}>Remove selected</Button></li>
          <li className="action">
            <label>Select all <input type="checkbox" onChange={@toggleSelectAll} name="search_to_delete"/></label>
          </li>
        </ul>
      </div>
      <ul className="saved-search-list-content list">
        {@renderItems()}
      </ul>
    </div>
