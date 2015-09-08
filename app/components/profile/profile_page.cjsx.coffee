languages = require('constants/languages')
EditableInformation = require('components/shared/editable_information')
UserActions = require('actions/user_actions')
UserStore = require('stores/user_store')
CountryActions = require('actions/country_actions')
CountryStore = require('stores/country_store')
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'ProfilePage'

  mixins: [TranslationHelper]
  baseTranslation: 'profile_page'

  getInitialState: ->
    _.extend {}, UserStore.state,
      countriesLoaded: CountryStore.state.loaded
      countries: CountryStore.state.countries

  componentWillMount: ->
    UserActions.loadUser()
    CountryActions.loadCountries()
    @unsubscribeUserStore = UserStore.listen(@onUserStoreUpdated)
    @unsubscribeCountryStore = CountryStore.listen(@onCoutnryStoreUpdated)

  componentWillUnmount: ->
    @unsubscribeUserStore()

  onUserStoreUpdated: (state) ->
    userState = _.omit(state, 'loaded')
    userState.userLoaded = state.loaded
    @setState(userState)
    if state.errors
      window.flash('error', @t('short_cannot_load_user_profile'))

  onCoutnryStoreUpdated: (state) ->
    unless state.errors
      @setState(countriesLoaded: state.loaded, countries: state.countries)

  updateUser: (user, form) ->
    user.country = parseInt(user.country, 10)
    user = _.extend({}, @state.user, user)
    unsubscribe = UserActions.updateUser.completed.listen =>
      window.flash 'success', @t('successfully_updated')
      form.toggleReadOnly()
      unsubscribe()
    UserActions.updateUser(user)

  renderCountriesSelect: ->
    if @state.countriesLoaded && @state.userLoaded
      options =
        for country in @state.countries
          <option key="country-#{country.id}" value={country.id}>{country.title}</option>

      <select label={@t('country')} name="country_id" type="select" defaultValue={@state.user.country_id} className="form-control form-group">
        {options}
      </select>
    else
      <Loader loaded=false />

  renderLanguageSelect: ->
    options =
      for language in languages
        <option key="language-#{language.name}" value={language.name}>{language.title}</option>

    <select label={@t('language')} name="language" type="select" defaultValue={@state.user.language} className="form-control form-group">
      {options}
    </select>

  render: ->
    # TODO: desktop needs to support columns
    if @state.userLoaded && !@state.errors
      <div className="profile-page">
        <h1>{@t('my_profile')}</h1>

        <EditableInformation title={@t('account_information')}
          onSubmit={@updateUser}
          object={@state.user}
          editLabel={@t('edit')}
          cancelLabel={@t('cancel')}
        >
          <input label={@t('email')} name="email" type="email" />
          <input label={@t('password')} name="password" type="password" />
          <input label={@t('confirm_password')} name="confirm_password" type="password" />
        </EditableInformation>

        <EditableInformation title={@t('personal_information')}
          onSubmit={@updateUser}
          object={@state.user}
          editLabel={@t('edit')}
          cancelLabel={@t('cancel')}
        >
          <input label={@t('first_name')} name="first_name" />
          <input label={@t('last_name')} name="last_name" />
          <input label={@t('role')} name="roles" />
          {@renderCountriesSelect()}
          {@renderLanguageSelect()}
        </EditableInformation>
      </div>
    else if @state.errors
      <div className="profile-page">
        {@t('cannot_load_user_profile')}
      </div>
    else
      <div className="profile-page">
        <Loader loaded={false} />
      </div>
