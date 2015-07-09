API = require('lib/api')
DocumentActions = require('actions/document_actions')

module.exports = Reflux.createStore
  listenables: [DocumentActions]

  loadDocument: (id, success, error) ->
    API.read "documents/#{id}",
      success: success,
      error: error