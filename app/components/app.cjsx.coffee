AboutPage = require('components/about/about_page')
ArticlesPage = require('components/articles/articles_page')
SearchPage = require('components/search/search_page')

Sidebar = require('components/menus/sidebar')
SidebarGroup = require('components/menus/sidebar_group')
MenuToggle = require('components/menus/menu_toggle')
Offcanvas = require('components/menus/offcanvas')

MainMenu = require('components/menus/main_menu')
DesktopMainMenu = require('components/menus/desktop_main_menu')
HelpMenu = require('components/menus/help_menu')
FilterGroupsMenu = require('components/menus/filter_groups_menu')
FiltersMenu = require('components/menus/filters_menu')
CountriesMenu = require('components/menus/countries_menu')
SignupMenu = require('components/menus/signup_menu')
LoginMenu = require('components/menus/login_menu')
LanguagesMenu = require('components/menus/languages_menu')

ReactCSSTransitionGroup = React.addons.CSSTransitionGroup

module.exports = React.createClass
  displayName: 'App'

  propTypes:
    page: React.PropTypes.string.isRequired

  getInitialState: ->
    currentUser: null

  login: (user) ->
    @dismissMenu()
    @setState(currentUser: user)

  logout: ->
    @setState(currentUser: null)
    @dismissMenu()

  selectLanguage: (language) ->
    console.log('language selected', language)
    @dismissMenu()
    # TODO: implement

  toggleMenu: (menuName) ->
    @refs.offcanvas.toggleMenu(menuName)

  dismissMenu: ->
    @refs.offcanvas.dismissMenu(menuName)

  renderHeader: ->
    <nav className="top-nav">
      <h1>Health System Evidence</h1>
      <MenuToggle menu="main" onToggle={@toggleMenu}>
        <span className="icon-bar"></span>
        <span className="icon-bar"></span>
        <span className="icon-bar"></span>
      </MenuToggle>
      <DesktopMainMenu />
    </nav>

  renderPage: ->
    # TODO: can be generalized by invoking the right factory based on page name passed in
    # and passing the arguments
    switch @props.page
      when 'search'
        <SearchPage key="search-page"
          onShowHelp={@toggleMenu}
          onShowFilters={@toggleMenu}
         />
      when 'articles'
        id = @props.args.id
        <ArticlesPage id={id} key={"article-page-#{id}"} />
      when 'about'
        <AboutPage key="about-page" />
      else
        throw new Error("Page not found! Please check the URL")

  renderFilterGroups: ->
    filters = menu.context.filters
    onToggleFilter = menu.context.onToggleFilter
    @renderSidebar <FilterGroupsMenu
      filters={filters}
      onToggleFilter={onToggleFilter}
      onFilterGroupClick={@toggleMenu} />, title, level

  # renderFiltersOrCountries: (menuName) ->
  #   if menuName is 'countries'
  #     name = "countries"
  #     title = "Countries"
  #     Menu = CountriesMenu
  #   else # menu.name is subFilters
  #     name = "filters"
  #     section = menu.context.section
  #     filterGroup = menu.context.filterGroup
  #     title = "Select #{section}: #{filterGroup}"
  #     Menu = FiltersMenu
  #
  #   filters = menu.context.filters
  #   onToggleFilter = (filter) =>
  #     menu.context.onToggleFilter(filter)
  #     # must do a force update since context is updated in a child as a state
  #     # but we want to re-render the menu with the updated context too
  #     @forceUpdate()
  #
  #   <Sidebar name={name} title={title}>
  #     <Menu filters={filters} onToggleFilter={onToggleFilter} />
  #   </Sidebar>

  renderSidebarGroup: ->
    # <Sidebar name="filters" title="Filter documents by...">
    #   {@renderFilterGroups()}
    # </Sidebar>
    # {@renderFiltersOrCountries('filters')}
    # {@renderFiltersOrCountries('countries')}
    <SidebarGroup>
      <Sidebar name="help" title="Help">
        <HelpMenu />
      </Sidebar>
      <Sidebar name="signup" title="Signup">
        <SignupMenu />
      </Sidebar>
      <Sidebar name="main" title="Menu">
        <MainMenu currentUser={@state.currentUser}
          onSubMenuClick={@toggleMenu}
          onLogout={@logout}
          onLinkClick={@dismissMenu}
          />
      </Sidebar>
      <Sidebar name="login" title="Login">
        <LoginMenu onLogin={@login} />
      </Sidebar>
      <Sidebar name="languages" title="Languages">
        <LanguagesMenu onSelectLanguage={@selectLanguage} />
      </Sidebar>

    </SidebarGroup>

  render: ->
    <Offcanvas ref="offcanvas">
      {@renderSidebarGroup()}
      {@renderHeader()}
      <div id="page-content">
        <ReactCSSTransitionGroup transitionName="page" component="div">
          {@renderPage()}
        </ReactCSSTransitionGroup>
      </div>
    </Offcanvas>
