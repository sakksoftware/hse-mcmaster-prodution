SearchPage = require('components/search/search_page')
Sidebar = require('components/shared/sidebar')
DocumentPage = require('components/documents/document_page')
MainMenu = require('components/menus/main_menu')
ReactCSSTransitionGroup = React.addons.CSSTransitionGroup

module.exports = React.createClass
  displayName: 'App'

  propTypes:
    page: React.PropTypes.string.isRequired

  getInitialState: ->
    menuToggled: false

  componentDidMount: ->
    # @offcanvasMenu = new Offcanvas($(@refs.btnOffcanvas.getDOMNode()))

  componentWillUnmount: ->
    # @offcanvasMenu = null

  toggleMenu: ->
    @setState(menuToggled: !@state.menuToggled)

  dismissMenu: ->
    @state.menuToggled && @toggleMenu()
    return # avoid warning message from react by return undefined

  renderHeader: ->
    <button ref="btnOffcanvas" type="button" onClick={@toggleMenu} className="toggle-main-menu">
      <span className="sr-only">Toggle navigation</span>
      <span className="icon-bar"></span>
      <span className="icon-bar"></span>
      <span className="icon-bar"></span>
    </button>

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
      <Sidebar onClose={@dismissMenu}>
        <MainMenu />
      </Sidebar>
      <div id="page-content-wrapper" onClick={@dismissMenu}>
        {@renderHeader()}
        <div id="page-content">
          <ReactCSSTransitionGroup transitionName="page" component="div">
            {@renderPage()}
          </ReactCSSTransitionGroup>
        </div>
      </div>
    </div>