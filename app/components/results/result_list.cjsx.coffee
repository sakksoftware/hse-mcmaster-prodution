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
    selected: []

  onSelectToggle: (article) ->
    selected = _.clone @state.selected
    if selectedArticle = _.findWhere(selected, id: article.id)
      selected = _.reject selected, (a) -> a.id == selectedArticle.id
    else
      selected.push(article)

    @setState(selected: selected)

  saveArticles: ->
    UserActions.saveArticles(@state.selected).then =>
      flash('success', @t('on_save'))

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
    for article in @state.selected
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

  removeUserArticles: ->
    UserActions.removeArticles(@state.selected).then =>
      flash('success', @t('on_remove', documents_count: @state.selected.length))

  toggleSelectAll: (ev) ->
    articles = _.difference(@props.results, @state.selected)
    @setState(selected: articles)

  emailArticles: ->
    UserActions.emailArticles(@state.selected).then =>
      email = UserStore.state.user.email
      count = @state.selected.length
      flash('success', @t('on_email', email: email, documents_count: count))

  loadMore: (page) ->
    @props.onLoadMore(page)

  hasMore: ->
    @props.resultsCount > 0 and @props.resultsCount > @props.results.length

  renderList: ->
    if @props.results.length == 0
      return <p className="no-results">{@t('no_results')}</p>

    for result, i in @props.results
      selected = !!_.findWhere(@state.selected, id: result.id)
      <ResultItem result={result} resultNumber={i + 1} key="result-#{i}" onSelectToggle={@onSelectToggle} selected={selected} />

  render: ->
    <ol className="result-list">
      {@renderList()}
    </ol>
