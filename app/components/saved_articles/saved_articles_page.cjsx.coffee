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
    hasSelected: false
    allSelected: false

  componentDidMount: ->
    document.title = "#{@t('title')} | #{@t('/site_name')}"

  toggleSelect: (selected) ->
    @setState(hasSelected: selected.length > 0, allSelected: selected.length == @state.articles.length)

  toggleSelectAll: (numSelected) ->
    @refs.resultList.toggleSelectAll()

  componentWillMount: ->
    UserActions.loadArticles()
    @unsubscribeUserStore = UserStore.listen(@userStoreUpdated)

  componentWillUnmount: ->
    @unsubscribeUserStore()

  userStoreUpdated: (data) ->
    @setState(articles: data.articles, hasSelected: false, allSelected: false)

  exportSelected: ->
    @refs.resultList.exportArticles()

  removeSelected: ->
    @refs.resultList.removeUserArticles()

  sendEmail: ->
    @refs.resultList.emailArticles()

  renderExportButtons: ->
    if @state.hasSelected
      <div className="export-buttons fixed-footer">
        <Button className="icon icon-export" onClick={@exportSelected}>{@t('export')}</Button>
        <Button className="icon icon-email" onClick={@sendEmail}>{@t('email')}</Button>
      </div>

  renderListActions: ->
    <ul className="list-actions list-inline">
      {
        if @state.hasSelected
          <li className="action remove-selected">
            <Button onClick={@removeSelected}>{@t('/remove_selected')}</Button>
          </li>
      }
      {
        if @state.articles.length > 0
          <li className="action">
            <label>{@t('/select_all')}<input type="checkbox" onChange={@toggleSelectAll} checked={@state.allSelected} name="search_to_delete"/></label>
          </li>
      }
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
      {
        if @state.articles.length > 0
          <ResultList ref="resultList" results={@state.articles} resultsCount={@state.articles.length} source="saved_documents" toggleSelect={@toggleSelect} />
        else
          <div className="result-list">
            {@t('no_saved_articles')}
          </div>
      }
    </div>
