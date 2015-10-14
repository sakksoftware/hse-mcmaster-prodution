API = require('lib/api')
ResultList = require('components/results/result_list')
UserStore = require('stores/user_store')
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  mixins: [TranslationHelper]
  baseTranslation: 'newsletter_page'

  propTypes:
    id: React.PropTypes.string.isRequired

  getInitialState: ->
    newsletter: { articles: [] }

  componentWillMount: ->
    API.read("newsletters/#{@props.id}?lang=#{UserStore.state.language}").done (newsletter) => @setState(newsletter: newsletter)

  render: ->
    <div className="newsletter-page">
      <h1>{@t('title')}</h1>
      <h2>{moment(@state.newsletter.date).format('MMMM YYYY')}</h2>
      <ResultList results={@state.newsletter.articles} resultsCount={@state.newsletter.articles.length || 0} onLoadMore={=>} />
    </div>
