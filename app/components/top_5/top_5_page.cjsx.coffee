API = require('lib/api')
ResultList = require('components/results/result_list')
UserStore = require('stores/user_store')
TranslationHelper = require('mixins/translation_helper')

params = require('lib/url').params()

module.exports = React.createClass
  displayName: 'Top5Page'

  mixins: [TranslationHelper]
  baseTranslation: 'top_5_page'

  getInitialState: ->
    results: []

  componentWillMount: ->
    API.read("top_5?type=#{params.type || 'all'}&lang=#{UserStore.state.language}").done (results) => @setState(results: results)

  render: ->
    <div className="top-5-page">
      {
        if params.type == 'policy_makers'
          <h1>{@t('title.policy_makers')}</h1>
        else
          <h1>{@t('title.all')}</h1>
      }
      <ResultList results={@state.results} resultsCount={5} source="top_5" />
    </div>
