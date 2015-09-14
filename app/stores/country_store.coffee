CountryActions = require('actions/country_actions')
RefluxStateMixin = require('lib/reflux_state_mixin')(Reflux)

module.exports = Reflux.createStore
  listenables: [CountryActions]

  mixins: [RefluxStateMixin]

  getInitialState: ->
    countries: []
    loaded: false

  onLoadCountriesCompleted: (countries) ->
    @setState(countries: countries, loaded: true)

  onLoadCountriesFailed: (xhr) ->
    @setState(loaded: false)
