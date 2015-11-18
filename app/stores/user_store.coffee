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

    @setState(user: user, loaded: true, errors: null, language: UrlStore.state.params.lang || user.language)

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
    Cookies.set('token', user.token)

  onCreateUserFailed: (xhr, statusCode, responseText) ->
    @setState(errors: responseText, loaded: true)

  onLoginUserCompleted: (user) ->
    @setState(user: user, loaded: true, language: user.language)
    Cookies.set('token', user.token)

  onLoginUserFailed: (xhr) ->
    errors = ['unknown_error']
    if xhr.status == 403
      errors = ['invalid_login']
    @setState(errors: errors, loaded: true)

  onLogoutUserCompleted: ->
    @setState(user: null, loaded: false, errors: null)
    Cookies.remove('token')

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
    searches = _.deepClone(@state.searches)

    search = _(searches).findWhere(id: search.id)
    search.subscribed = false

    @setState(searches: searches)

  onSaveSearchCompleted: (search) ->
    searches = _.deepClone(@state.searches)
    searches.push(search)
    @setState(searches: searches)

  onSaveArticlesCompleted: (article) ->
    articles = _.deepClone(@state.articles)
    articles.push(article)
    @setState(articles: articles)

  onRemoveSearchesCompleted: (removedIds) ->
    searches = _(@state.searches).reject (s) -> removedIds.indexOf(s.id) >= 0
    @setState(searches: searches)

  onRemoveArticlesCompleted: (removedIds) ->
    articles = _(@state.articles).reject (a) -> removedIds.indexOf(a.id) >= 0
    @setState(articles: articles)

  onSubscribeToSearchCompleted: (search) ->
    searches = _.deepClone(@state.searches)

    searches.map (s) -> s.subscribed = false
    search = _(searches).findWhere(id: search.id)
    search.subscribed = true

    @setState(searches: searches)
