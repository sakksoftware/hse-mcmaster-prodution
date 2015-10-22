ResultItem = require('components/results/result_item')
TranslationHelper = require('mixins/translation_helper')
InfiniteScroll = require('mixins/infinite_scroll')

UserActions = require('actions/user_actions')
UserStore = require('stores/user_store')
config = require('config')

module.exports = React.createClass
  displayName: 'ResultList'

  mixins: [TranslationHelper, InfiniteScroll]
  baseTranslation: 'search_page.result_list'

  propTypes:
    results: React.PropTypes.array.isRequired
    resultsCount: React.PropTypes.number.isRequired
    onLoadMore: React.PropTypes.func

  defaultProps: ->
    onLoadMore: ->

  getInitialState: ->
    selectedArticles: []

  onSelectToggle: (article) ->
    selectedArticles = _.clone @state.selectedArticles
    if selectedArticle = _.findWhere(selectedArticles, id: article.id)
      selectedArticles = _.reject selectedArticles, (a) -> a.id == selectedArticle.id
    else
      selectedArticles.push(article)

    @setState(selectedArticles: selectedArticles)

  saveArticles: ->
    UserActions.saveArticles(@state.selectedArticles).then =>
      flash('success', 'saved articles')

  getCSVDataUrl: (data) ->
    csvContent = 'data:text/csv;charset=utf-8,'
    csvContent += Papa.unparse data, {
    	quotes: true,
    	delimiter: ",",
    	newline: "\r\n"
    }

    csvContent

  openNewWindow: (csvContent) ->
    encodedUri = encodeURI(csvContent)
    window.open(encodedUri)

  exportArticles: ->
    lang = UserStore.state.language
    data = [
      [
        'Title'
        'URL'
        'Description'
        'Details'
        'ShortDetails'
        'Resource'
        'Type'
        'Identifiers'
        'Db'
        'EntrezUID'
        'Properties'
      ]
    ]

    # TODO: verify the data is correct
    for article in @state.selectedArticles
      data.push [
        article.title
        "#{config.siteUrl}/articles/#{article.id}?t=#{article.traversal}&lang=#{lang}"
        article.citation
        "doi: #{article.doi}"
        "??? publisher ???"
        "PubMed"
        "citation"
        article.id
        "pubmed",
        article.id
        "create date:#{article.created_at}"
      ]


    @openNewWindow(@getCSVDataUrl(data))

  loadMore: (page) ->
    @props.onLoadMore(page)

  hasMore: ->
    @props.resultsCount > 0 and @props.resultsCount > @props.results.length

  renderList: ->
    if @props.results.length == 0
      return <p className="no-results">{@t('no_results')}</p>

    for result, i in @props.results
      <ResultItem result={result} resultNumber={i + 1} key="result-#{i}" onSelectToggle={@onSelectToggle} />

  render: ->
    <ol className="result-list">
      {@renderList()}
    </ol>
