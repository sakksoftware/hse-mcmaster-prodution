SortOrder = require('components/results/sort_order')
ResultList = require('components/results/result_list')
SelectableList = require('components/shared/selectable_list')
TranslationHelper = require('mixins/translation_helper')
SavedSearchButtons = require('components/search/saved_search_buttons')
Button = require('components/shared/button')
Link = require('components/shared/link')
Hotspot = require('components/tour/hotspot')

UserStore = require('stores/user_store')
TourActions = require('actions/tour_actions')

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

  componentWillMount: ->
    TourActions.addSteps [
      {
        key: 'select_article'
        order: 6
        afterStep: -> $('.result-item:first-child .result-item-select input').click()
      }
      {
        key: 'view_saved_articles'
        order: 9
      }
    ]

  componentWillUnmount: ->
    TourActions.removeSteps ['select_article', 'email_articles', 'save_articles']

  saveArticles: ->
    @refs.resultList.saveArticles()

  emailArticles: ->
    @refs.resultList.emailArticles()

  toggleSelect: (selected) ->
    allSelected = selected.length > 0 && selected.length == @props.search.results.length
    @setState { hasSelected: selected.length > 0, allSelected: allSelected }, =>
      if @state.hasSelected
        TourActions.addSteps [
          {
            key: 'email_articles'
            element: '.saved-articles-actions .icon-email'
            position: 'top'
            order: 7
          }
          {
            key: 'save_articles'
            element: '.saved-articles-actions .icon-save-article'
            position: 'top'
            order: 8
          }
        ]

  toggleSelectAll: ->
    @refs.resultList.toggleSelectAll()

  clearSelected: ->
    @refs.resultList.clearSelected()

  renderSavedArticlesButtons: ->
    if UserStore.isLoggedIn()
      <div className="saved-articles-actions">
        {
          if @state.hasSelected
            [
              <Button key="icon-email" className="icon icon-email" onClick={@emailArticles}>
                <Hotspot tourKey="email_articles" />
                {@t('email')}
              </Button>
              <Button key="icon-save-article" className="icon icon-save-article" onClick={@saveArticles}>
                <Hotspot tourKey="save_articles" />
                {@t('save')}
              </Button>
            ]
        }
        <Link className="icon icon-view-saved-articles button" to="/user/articles">
          <Hotspot tourKey="view_saved_articles" />
          {@t('view_saved')}
        </Link>
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
