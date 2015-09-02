ArticleActions = require('actions/article_actions')
ArticleItem = require('components/articles/article_item')
Link = require('components/shared/link')
TranslationHelper = require('mixins/translation_helper')
UserStore = require('stores/user_store')
PageNotFound = require('components/error_pages/page_not_found')

module.exports = React.createClass
  displayName: 'ArticlePage'

  mixins: [TranslationHelper]
  baseTranslation: ''

  propTypes:
    id: React.PropTypes.string.isRequired

  getInitialState: ->
    article: null
    errors: null

  componentWillMount: ->
    lang = UserStore.state.language
    ArticleActions.loadArticle(@props.id, lang, @handleLoad, @handleError)

  handleLoad: (article) ->
    @setState(article: article)

  handleError: (xhr, errorText, response) ->
    console.log("Failed to load article #{@props.id}")
    if xhr.status != 404
      if errorText == "parseText"
        flash('error', @t('errors.unexpected_server_response'))
      else
        flash('error', @t('errors.no_connection'))

    @setState(errors: [{type: 'page_not_found'}])

  backLink: ->
    router = require('lib/router')
    if router.hasHistory()
      <Link to="back" className="btn-back">{@t('back_to_results')}</Link>

  render: ->
    if @state.errors?[0].type == 'page_not_found'
      <PageNotFound />

    body =
      if @state.article
        id = @state.article.id
        <ArticleItem key={"article-item-#{id}"} article={@state.article} />
      else
        <Loader loaded={false} />

    <div className="article-page">
      {body}
      {@backLink()}
    </div>
