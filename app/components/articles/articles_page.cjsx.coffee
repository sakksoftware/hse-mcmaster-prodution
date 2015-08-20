ArticleActions = require('actions/article_actions')
ArticleItem = require('components/articles/article_item')
Link = require('components/shared/link')
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'ArticlePage'

  mixins: [TranslationHelper]
  baseTranslation: ''

  propTypes:
    id: React.PropTypes.string.isRequired

  getInitialState: ->
    article: null

  componentWillMount: ->
    ArticleActions.loadArticle(@props.id, @handleLoad, @handleError)

  handleLoad: (article) ->
    @setState(article: article)

  handleError: (xhr, statusCode, response) ->
    console.log("Failed to load article #{@props.id}")
    flash('error', @t('errors.no_connection'))

  backLink: ->
    router = require('lib/router')
    if router.hasHistory()
      <Link to="back" className="btn-back">{@t('back_to_results')}</Link>

  render: ->
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
