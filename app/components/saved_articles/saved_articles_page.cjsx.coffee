API = require('lib/api')
ResultList = require('components/results/result_list')
Button = require('components/shared/button')

UserActions = require('actions/user_actions')
UserStore = require('stores/user_store')

module.exports = React.createClass
  displayName: 'SavedArticlesPage'

  getInitialState: ->
    articles: UserStore.state.articles

  componentWillMount: ->
    UserActions.loadArticles()
    @unsubscribeUserStore = UserStore.listen(@userStoreUpdated)

  componentWillUnmount: ->
    @unsubscribeUserStore()

  userStoreUpdated: (data) ->
    @setState(articles: data.articles)

  exportSelected: ->
    @refs.resultList.exportArticles()

  renderExportButtons: ->
    <div className="export-buttons">
      <Button className="btn btn-primary" onClick={@exportSelected}>Export selected</Button>
      <Button className="btn btn-primary">Email Selected</Button>
    </div>

  render: ->
    <div className="saved_articles_page">
      <h1>Saved documents</h1>
      <p>
        Documents you saved will be kept on this page for upto 6 hours.
        You can email or export those documents.
      </p>
      {@renderExportButtons()}
      <ResultList ref="resultList" results={@state.articles} resultsCount={@state.articles.length} />
    </div>
