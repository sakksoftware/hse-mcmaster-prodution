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

  render: ->
    body =
      if @state.document
        [
          <Link to="back" className="btn-back">Return to search results</Link>
          <DocumentItem document={@state.document} />
          <Link to="back" className="btn-back">Return to search results</Link>
        ]

    <div className="document-page">
      {body}
    </div>