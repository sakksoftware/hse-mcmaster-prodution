SearchPage = require('components/search/search_page')
DocumentPage = require('components/documents/document_page')

module.exports = React.createClass
  displayName: 'App'

  propTypes:
    page: React.PropTypes.string.isRequired

  componentDidMount: ->
    @oc = new Offcanvas($(@refs.btnOffcanvas.getDOMNode()))

  componentWillUnmount: ->
    @oc = null

  renderHeader: ->
    <button ref="btnOffcanvas" type="button" className="navbar-toggle offcanvas-toggle" data-toggle="offcanvas" data-target="#js-bootstrap-offcanvas">
      <span className="sr-only">Toggle navigation</span>
      <span className="icon-bar"></span>
      <span className="icon-bar"></span>
      <span className="icon-bar"></span>
    </button>

  renderSideBar: ->
    <nav className="navbar navbar-default navbar-offcanvas navbar-offcanvas-touch navbar-offcanvas-right" role="navigation" id="js-bootstrap-offcanvas">
      <div className="container-fluid">
        <div className="navbar-header">
          <a className="navbar-brand" href="#">Brand</a>
        </div>
        <ul className="nav navbar-nav">
          <li>Item #1</li>
        </ul>
      </div>
    </nav>

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
    <div className="app" id="app">
      {@renderHeader()}
      {@renderSideBar()}
      <div id="content">
        {@renderPage()}
      </div>
    </div>