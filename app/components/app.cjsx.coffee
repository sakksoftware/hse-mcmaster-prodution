SearchPage = require('components/search/search_page')
DocumentPage = require('components/documents/document_page')

module.exports = React.createClass
  displayName: 'App'

  propTypes:
    page: React.PropTypes.string.isRequired

  renderPage: ->
    # TODO: can be generalized by invoking the right factory based on page name passed in
    # and passing the arguments
    switch @props.page
      when 'SearchPage'
        <SearchPage />
      when 'DocumentPage'
        <DocumentPage id={@props.args.id} />
      else
        throw new Error("Page not found! Please check the URL")

  render: ->
    <div className="wrapper">
      {@renderPage()}
    </div>