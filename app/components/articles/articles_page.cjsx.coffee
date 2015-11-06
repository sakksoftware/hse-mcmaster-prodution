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
    params = require('lib/url').params()
    lang = UserStore.state.language
    title = params.t # 10 character of the title to protect against scrapping
    ArticleActions.loadArticle(@props.id, title, lang).then(@handleLoad)

  handleLoad: (article) ->
    @setState(article: article)
    document.title = "#{article.title} | #{@t('site_name')}"

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
