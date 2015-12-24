SortOrder = require('components/results/sort_order')
ResultList = require('components/results/result_list')
SelectableList = require('components/shared/selectable_list')
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
    hasSelected: false
    allSelected: false

  saveArticles: ->
    @refs.resultList.saveArticles()

  emailArticles: ->
    @refs.resultList.emailArticles()

  toggleSelect: (selected) ->
    @setState(hasSelected: selected.length > 0, allSelected: selected.length == @props.search.results.length)

  toggleSelectAll: ->
    @refs.resultList.toggleSelectAll()

  renderSavedArticlesButtons: ->
    if UserStore.isLoggedIn()
      <div className="saved-articles-actions">
        {
          if @state.hasSelected
            [
              <Button key="icon-email" className="icon icon-email" onClick={@emailArticles}>Email</Button>
              <Button key="icon-save-article" className="icon icon-save-article" onClick={@saveArticles}>Save</Button>
            ]
        }
        <Link className="icon icon-view-saved-articles button" to="/user/articles">View saved</Link>
        <label className="select-all-action action">{@t('/select_all')}<input type="checkbox" checked={@state.allSelected} onChange={@toggleSelectAll} /></label>
      </div>

  render: ->
    <div className="result-box">
      <div className="result-box-header #{'logged-in' if UserStore.isLoggedIn()}">
        <SortOrder sortBy={@props.sortBy} onChange={@props.onSortChange} />
        <div className="result-box-count">{@props.search.results_count} {@t('results')}</div>
        {@renderSavedArticlesButtons()}
      </div>
      <SavedSearchButtons search={@props.search} toggleSelectAll={@toggleSelectAll} onSaveAndSubscribe={@props.onSaveAndSubscribe} />
      <ResultList ref="resultList" results={@props.search.results} resultsCount={@props.search.results_count} onLoadMore={@props.onLoadMore} toggleSelect={@toggleSelect} />
    </div>
