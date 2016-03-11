API = require('lib/api')
UserActions = require('actions/user_actions')
UrlActions = require('actions/url_actions')
RefluxStateMixin = require('lib/reflux_state_mixin')(Reflux)

UrlStore = require('stores/url_store')

module.exports = Reflux.createStore
  listenables: [UserActions]
  mixins: [RefluxStateMixin]

  getInitialState: ->
    if Cookies.get('guided_search')
      guidedSearch = Cookies.get('guided_search') == 'true'
    else
      guidedSearch = true

    # TODO: instead of having language outside of the guest object and then updating it,
    # have an guest user object. Can even query the API for guest users.
    user: null
    loaded: false
    errors: null
    language: UrlStore.state.params.lang || 'en'
    guidedSearch: guidedSearch
    region: UrlStore.state.params.region || 'worldwide'
    articles: []
    searches: []
    curatedSearches: []

  ##
  # Data accessors
  ##
  isLoggedIn: -> !!@state.user

  ##
  # Event listeners
  ##
  onLoadUserCompleted: (user) ->
    if user.id == 0
      # session expired or something else is wrong
      UrlActions.navigateTo('/login')
      Cookies.remove('token')
      return

    language = UrlStore.state.params.lang || user.language
    if language != @state.language
      UrlActions.setParams(lang: language)
      _.defer -> window.location.reload()

    @setState(user: user, loaded: true, errors: null, language: language)

    @_markIfStaff(user)
    @_setRollbarPerson(user)

  onLoadUserFailed: (xhr, statusCode, responseText) ->
    @setState(errors: responseText, loaded: true)

  onUpdateUserCompleted: (user) ->
    user = _.extend({}, @state.user, user)

    # language changed?
    if @state.user.language != user.language
      UrlActions.setParams(lang: user.language)
      _.defer -> window.location.reload()

    @setState(user: user, loaded: true, errors: null, language: user.language)

  onUpdateUserFailed: (xhr, statusCode, responseText) ->
    @setState(errors: responseText, loaded: true)

  onChangeLanguage: (language) ->
    UrlActions.setParams(lang: language)
    if @state.loaded
      UserActions.updateUser(language: language).then =>
        window.location.reload()
    else
      _.defer -> window.location.reload()

  onToggleGuidedSearch: (language) ->
    @setState(guidedSearch: !@state.guidedSearch)
    Cookies.set('guided_search', @state.guidedSearch)

  onToggleComplementaryContent: (fieldName) ->
    data = {}
    data[fieldName] = !@state.user[fieldName]
    UserActions.updateUser(data)

  onCreateUserCompleted: (user) ->
    @setState(user: user, loaded: true, language: user.language)
    Cookies.set('token', user.token, expires: 365)

  onCreateUserFailed: (xhr, statusCode, responseText) ->
    @setState(errors: responseText, loaded: true)

  onLoginUserCompleted: (user) ->
    # language changed?
    if @state.language != user.language
      UrlActions.setParams(lang: user.language)
      _.defer -> window.location.reload()

    @setState(user: user, loaded: true, language: user.language)
    Cookies.set('token', user.token, expires: 365)

    @_markIfStaff(user)
    @_setRollbarPerson(user)

  onLoginUserFailed: (xhr) ->
    errors = ['unknown_error']
    if xhr.status == 403
      errors = ['invalid_login']
    @setState(errors: errors, loaded: true)

  onLogoutUserCompleted: ->
    @setState(user: null, loaded: false, errors: null)
    Cookies.remove('token')
    _.defer -> window.location = '/'

  onLogoutUserFailed: ->
    @setState(errors: ['faild_logout'])

  onForgotPasswordCompleted: ->
    @setState(loaded: false)

  onForgotPasswordFailed: () ->
    @setState(errors: ['wrong_email'])

  onResetPasswordCompleted: (user) ->
    @setState(user: user, loaded: true, errors: null)

  onResetPasswordFailed: ->
    @setState(errors: ['failed_password_reset'])

  onLoadRegionCompleted: (geo) ->
    @setState(region: UrlStore.state.params.region || geo.region)

  onLoadSearchesCompleted: (searches) ->
    @setState(searches: searches)

  onLoadArticlesCompleted: (articles) ->
    @setState(articles: articles)

  onUnsubscribeCompleted: ->

  onSaveSearchCompleted: (savedSearch) ->
    searches = _.deepClone(@state.searches)
    searches.push(savedSearch)
    require('stores/search_store').notifySaved(true, savedSearch.id)
    @setState(searches: searches)

  onSaveArticlesCompleted: (article) ->
    articles = _.deepClone(@state.articles)
    articles.push(article)
    @setState(articles: articles)

  onRemoveSearchesCompleted: (removedIds) ->
    searches = _(@state.searches).reject (s) -> removedIds.indexOf(s.id) >= 0
    searchStore = require('stores/search_store')
    currentSearch = searchStore.state.search.saved_search_id
    if currentSearch && removedIds.indexOf(currentSearch.saved_search_id)
      searchStore.notifySaved(false, null)

    @setState(searches: searches)

  onRemoveArticlesCompleted: (removedIds) ->
    articles = _(@state.articles).reject (a) -> removedIds.indexOf(a.id) >= 0
    @setState(articles: articles)

  onToggleSubscribeToSavedSearchCompleted: (saved_search) ->
    searches = _.deepClone(@state.searches)

    search = _(searches).findWhere(id: saved_search.id)
    if search
      search.subscribed = saved_search.subscribed
      require('stores/search_store').notifySubscribed(saved_search.subscribed)

    @setState(searches: searches)

  onToggleSubscribeToCuratedSearchCompleted: (saved_search) ->
    searches = _.deepClone(@state.curatedSearches)

    search = _(searches).find (s) ->
      s.query == saved_search.query &&
      s.applied_filters.toString() == saved_search.applied_filters.toString()

    if search
      search.subscribed = saved_search.subscribed
      search.saved_search_id = saved_search.id
      require('stores/search_store').notifySubscribed(saved_search.subscribed)

    @setState(curatedSearches: searches)

  onLoadCuratedSearchesCompleted: (curatedSearches) ->
    @setState(curatedSearches: curatedSearches)

  # private

  _markIfStaff: (user) ->
    if user.user_type == 'Staff'
      ga('set', 'dimension1', 'staff');

  _setRollbarPerson: (user) ->
    Rollbar.configure
      payload:
        person:
          id: user.id
          username: "#{user.first_name} #{user.last_name}"
          email: user.email
