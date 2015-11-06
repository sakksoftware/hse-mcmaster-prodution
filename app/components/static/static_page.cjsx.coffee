ContentActions = require('actions/content_actions')
Util = require('lib/util')
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'StaticPage'

  propTypes:
    name: React.PropTypes.string.isRequired

  mixins: [TranslationHelper]
  baseTranslation: ''

  componentWillMount: ->
    ContentActions.loadMarkdownFile(@props.name, @handleContentLoaded, @handleContentError)

  getInitialState: ->
    content: ""

  handleContentLoaded: (content) ->
    @setState(content: content)
    document.title = "#{Util.sentenceCase(@props.name)} | #{@t('site_name')}"

  handleContentError: (xhr, statusCode, responseText) ->
    console.log('Failed to load content', statusCode, responseText)
    flash('Oops something went wrong with loading the content')

  render: ->
    if @state.content == ""
      <div className="#{@props.name}-page">
        <Loader loaded={false} />
      </div>
    else
      <div className="#{@props.name}-page" dangerouslySetInnerHTML={__html: marked(@state.content, 'Maruku')}>
      </div>
