ContentActions = require('actions/content_actions')

module.exports = React.createClass
  displayName: 'StaticPage'

  propTypes:
    name: React.PropTypes.string.isRequired

  componentWillMount: ->
    ContentActions.loadMarkdownFile(@props.name, @handleContentLoaded, @handleContentError)

  getInitialState: ->
    content: ""

  handleContentLoaded: (content) ->
    @setState(content: content)

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
