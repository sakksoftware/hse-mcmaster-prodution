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
    selected: []

  # TODO: duplicate logic between saved_search, saved_articles and result_list
  toggleSelect: (article) ->
    selected = _.clone @state.selected
    if found = _.findWhere(selected, id: article.id)
      selected = _(selected).without(found)
    else
      selected.push(article)

    @setState(selected: selected)

  toggleSelectAll: (ev) ->
    selected = @state.articles
    allSelected = false

    if @state.selected.length > 0
      selected = []
      allSelected = false
    else
      allSelected = true

    @setState(selected: selected, allSelected: allSelected)

    @refs.resultList.toggleSelectAll()

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

  sendEmail: ->
    @refs.resultList.emailArticles()

  renderExportButtons: ->
    if @state.selected.length > 0
      <div className="export-buttons fixed-footer">
        <Button className="icon icon-export" onClick={@exportSelected}>Export</Button>
        <Button className="icon icon-email" onClick={@sendEmail}>Email</Button>
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
      <ResultList ref="resultList" results={@state.articles} resultsCount={@state.articles.length} source="saved_documents" onSelectToggle={@toggleSelect} />
    </div>
