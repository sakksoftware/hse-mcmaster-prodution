DocumentActions = require('actions/document_actions')
DocumentItem = require('components/documents/document_item')
Link = require('components/shared/link')

module.exports = React.createClass
  displayName: 'DocumentPage'
  propTypes:
    id: React.PropTypes.string.isRequired

  getInitialState: ->
    document: null

  componentWillMount: ->
    # TODO: remove hardcoded id after API has been implemented
    # id = @props.id
    id = "0df62f0040ffd8ecd725c9a602056034"
    DocumentActions.loadDocument(id, @handleLoad, @handleError)

  handleLoad: (document) ->
    @setState(document: document)

  handleError: (xhr, statusCode, response) ->
    console.log("Failed to load document #{id}")

  backLink: ->
    router = require('lib/router')
    if router.hasHistory()
      <Link to="back" className="btn-back">Return to search results</Link>

  render: ->
    body =
      if @state.document
        id = @state.document.id
        <DocumentItem key={"document-item-#{id}"} document={@state.document} />
      else
        <Loader loaded={false} />

    <div className="document-page">
      {@backLink()}
      {body}
      {@state.document && @backLink()}
    </div>