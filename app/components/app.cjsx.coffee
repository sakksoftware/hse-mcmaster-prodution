SearchPage = require('components/search/search_page')
DocumentPage = require('components/documents/document_page')
ReactCSSTransitionGroup = React.addons.CSSTransitionGroup

module.exports = React.createClass
  displayName: 'App'

  propTypes:
    page: React.PropTypes.string.isRequired

  getInitialState: ->
    menuToggled: false

  componentDidMount: ->
    @offcanvasMenu = new Offcanvas($(@refs.btnOffcanvas.getDOMNode()))

  componentWillUnmount: ->
    @offcanvasMenu = null

  toggleMenu: ->
    @setState(menuToggled: !@state.menuToggled)

  dismissMenu: ->
    @state.menuToggled && @toggleMenu()

  renderHeader: ->
    <button ref="btnOffcanvas" type="button" onClick={@toggleMenu} className="navbar-toggle offcanvas-toggle" data-toggle="offcanvas" data-target="#sidebar-wrapper">
      <span className="sr-only">Toggle navigation</span>
      <span className="icon-bar"></span>
      <span className="icon-bar"></span>
      <span className="icon-bar"></span>
    </button>

  renderSideBar: ->
    <nav id="sidebar-wrapper" role="navigation">
      <div className="sidebar">
        <div className="sidebar-header">
          <a className="sidebar-header-brand" href="#">HSE</a>
        </div>
        <ul className="sidebar-nav">
          <li>Home</li>
          <li>Select Language</li>
          <li>About HSE</li>
          <li>Sign Up</li>
          <li>Login</li>
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
    className = "app #{@state.menuToggled && ('menu-toggled' || '')}"
    <div className={className} id="app">
      {@renderSideBar()}
      <div id="page-content-wrapper" onClick={@dismissMenu}>
        {@renderHeader()}
        <div id="page-content">
          <ReactCSSTransitionGroup transitionName="page" component="div">
            {@renderPage()}
          </ReactCSSTransitionGroup>
        </div>
      </div>
    </div>