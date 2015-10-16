API = require('lib/api')
SavedSearchList = require('components/saved_search/saved_search_list')

module.exports = React.createClass
  displayName: 'SavedSearchPage'

  getInitialState: ->
    searches: []

  componentWillMount: ->
    API.read('/user/searches').done(@loadSearches)

  loadSearches: (searches) ->
    @setState(searches: searches)

  render: ->
    <div className="saved-search-page">
      <h1>Saved searches</h1>
      <p>You can subscribe upto one saved search and one curated search</p>

      <SavedSearchList searches={@state.searches} />
    </div>
