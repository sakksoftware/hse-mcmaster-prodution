ArticleActions = require('actions/article_actions')
ArticleItem = require('components/articles/article_item')
Link = require('components/shared/link')
TranslationHelper = require('mixins/translation_helper')
UserStore = require('stores/user_store')
PageNotFound = require('components/error_pages/page_not_found')
UrlStore = require('stores/url_store')
slug = require('lib/util').slug

module.exports = React.createClass
  displayName: 'ArticlePage'

  mixins: [TranslationHelper]
  baseTranslation: 'articles_page'

  propTypes:
    id: React.PropTypes.string.isRequired

  getInitialState: ->
    article: null
    errors: null

  componentWillMount: ->
    @router = require('lib/router')
    @params = require('lib/url').params()
    lang = UserStore.state.language
    title = @params.t # 10 character of the title to protect against scrapping
    id = parseInt(@props.id, 10)
    ArticleActions.loadArticle(id, title, lang).then(@handleLoad)

  handleLoad: (article) ->
    @setState(article: article)

    # redirect
    # new id contains a number + title, therefore parsing it should result in a difference
    id = parseInt(@props.id, 10)
    if id.toString() == @props.id.toString() && !isNaN(id)
      @router.update("/articles/#{id}-#{slug(article.title)}?t=#{@params.t}&source=#{@params.source}")

    document.title = "#{article.title} | #{@t('/site_name')}"

  backText: ->
    switch UrlStore.getParam('source')
      when 'top_5'
        @t('back_to_top_5')
      when 'newsletter'
        @t('back_to_newsletter')
      when 'saved_documents'
        @t('back_to_saved_documents')
      when 'search'
        @t('back_to_results')
      else
        @t('back_to_results')

  backLink: ->
    if @router.hasHistory()
      <Link to="back" className="btn-back">{@backText()}</Link>

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
