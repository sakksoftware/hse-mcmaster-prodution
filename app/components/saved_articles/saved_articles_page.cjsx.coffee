API = require('lib/api')
ResultList = require('components/results/result_list')
Button = require('components/shared/button')
TranslationHelper = require('mixins/translation_helper')

UserActions = require('actions/user_actions')
UserStore = require('stores/user_store')

module.exports = React.createClass
  displayName: 'SavedArticlesPage'

  mixins: [TranslationHelper]
  baseTranslation: 'saved_articles_page'

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

  removeSelected: ->
    @refs.resultList.removeUserArticles()

  toggleSelectAll: ->
    @refs.resultList.toggleSelectAll()

  sendEmail: ->
    @refs.resultList.emailArticles()

  renderExportButtons: ->
    <div className="export-buttons fixed-footer">
      <Button className="btn btn-primary" onClick={@exportSelected}>Export selected</Button>
      <Button className="btn btn-primary" onClick={@sendEmail}>Email selected</Button>
    </div>

  renderListActions: ->
    <ul className="list-actions list-inline">
      <li className="action remove-selected"><Button onClick={@removeSelected}>{@t('/remove_selected')}</Button></li>
      <li className="action">
        <label>{@t('/select_all')}<input type="checkbox" onChange={@toggleSelectAll} name="search_to_delete"/></label>
      </li>
    </ul>

  render: ->
    <div className="saved-articles-page">
      <h1>{@t('title')}</h1>
      <div className="saved-articles-instructions">
        <p>{@t('warning')}</p>
        <p>{@t('instructions')}</p>
      </div>
      <div className="saved-articles-list-header">
        {@renderExportButtons()}
        {@renderListActions()}
      </div>
      <ResultList ref="resultList" results={@state.articles} resultsCount={@state.articles.length} />
    </div>
