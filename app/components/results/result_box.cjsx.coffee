SortOrder = require('components/results/sort_order')
ResultList = require('components/results/result_list')
TranslationHelper = require('mixins/translation_helper')
SavedSearchButtons = require('components/search/saved_search_buttons')
Button = require('components/shared/button')
Link = require('components/shared/link')

UserStore = require('stores/user_store')

module.exports = React.createClass
  displayName: 'ResultBox'
  propTypes:
    search: React.PropTypes.object.isRequired
    sortBy: React.PropTypes.string.isRequired
    onLoadMore: React.PropTypes.func.isRequired
    onSortChange: React.PropTypes.func.isRequired
    onSaveAndSubscribe: React.PropTypes.func

  mixins: [TranslationHelper]
  baseTranslation: 'search_page.result_box'

  getInitialState: ->
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
    selected = @props.search.results
    allSelected = false

    if @state.selected.length > 0
      selected = []
      allSelected = false
    else
      allSelected = true

    @setState(selected: selected, allSelected: allSelected)

    @refs.resultList.toggleSelectAll()

  saveArticles: ->
    @refs.resultList.saveArticles()

  emailArticles: ->
    @refs.resultList.emailArticles()


  renderSavedArticlesButtons: ->
    if UserStore.isLoggedIn()
      <div className="saved-articles-actions">
        {
          if @state.selected.length > 0
            [
              <Button key="icon-email" className="icon icon-email" onClick={@emailArticles}>Email</Button>
              <Button key="icon-save-article" className="icon icon-save-article" onClick={@saveArticles}>Save</Button>
            ]
        }
        <Link className="icon icon-view-saved-articles button" to="/user/articles">View saved</Link>
        <label className="select-all-action action">{@t('/select_all')}<input type="checkbox" onChange={@toggleSelectAll} /></label>
      </div>

  render: ->
    <div className="result-box">
      <div className="result-box-header #{'logged-in' if UserStore.isLoggedIn()}">
        <SortOrder sortBy={@props.sortBy} onChange={@props.onSortChange} />
        <div className="result-box-count">{@props.search.results_count} {@t('results')}</div>
        {@renderSavedArticlesButtons()}
      </div>
      <SavedSearchButtons search={@props.search} toggleSelectAll={@toggleSelectAll} onSaveAndSubscribe={@props.onSaveAndSubscribe} />
      <ResultList ref="resultList" results={@props.search.results} resultsCount={@props.search.results_count} onLoadMore={@props.onLoadMore} onSelectToggle={@toggleSelect} />
    </div>
