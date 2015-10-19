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
      <div className="saved-search-header">
        <h1>Saved searches</h1>
        <label className="saved-search-subscribed-only action">Show only subscribed searches <input type="checkbox" /></label>
      </div>
      <SavedSearchList searches={@state.searches} />
    </div>
