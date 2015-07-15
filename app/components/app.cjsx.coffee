SearchPage = require('components/search/search_page')
DocumentPage = require('components/documents/document_page')
ReactCSSTransitionGroup = React.addons.CSSTransitionGroup

module.exports = React.createClass
  displayName: 'App'

  propTypes:
    page: React.PropTypes.string.isRequired

  componentDidMount: ->
    @offcanvasMenu = new Offcanvas($(@refs.btnOffcanvas.getDOMNode()))

  componentWillUnmount: ->
    @offcanvasMenu = null

  renderHeader: ->
    <button ref="btnOffcanvas" type="button" className="navbar-toggle offcanvas-toggle" data-toggle="offcanvas" data-target="#js-bootstrap-offcanvas">
      <span className="sr-only">Toggle navigation</span>
      <span className="icon-bar"></span>
      <span className="icon-bar"></span>
      <span className="icon-bar"></span>
    </button>

  renderSideBar: ->
    <nav className="col-xs-6 col-sm-3 navbar navbar-default navbar-offcanvas navbar-offcanvas-touch navbar-offcanvas-right" role="navigation" id="js-bootstrap-offcanvas">
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
        <SearchPage key="search-page" />
      when 'DocumentPage'
        id = @props.args.id
        <DocumentPage id={id} key={"document-page-#{id}"} />
      else
        throw new Error("Page not found! Please check the URL")

  render: ->
    <div className="app" id="app">
      <div className="col-xs-6 col-sm-9 content-wrapper">
        {@renderHeader()}
        <div id="content">
          <ReactCSSTransitionGroup transitionName="page" component="div">
            {@renderPage()}
          </ReactCSSTransitionGroup>
        </div>
      </div>
      {@renderSideBar()}
    </div>