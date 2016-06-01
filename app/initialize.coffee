window.reactAppLoaded = false

require('lib/extensions/underscore')
params = require('lib/url').params()

if window.location.hostname == "localhost" || window.location.hostname == "hse.dev" || window.location.hostname == "phcpi.hse.dev"
  window.ENV = params.ENV || 'development'
else if window.location.hostname == "staging.healthsystemsevidence.org"
  window.ENV = params.ENV || 'staging'
else
  window.ENV = params.ENV || 'production'

# window.ENV = 'staging'
console.log('ENV =', window.ENV)
config = require('config')
stores = require('stores')

localesUrl = config.localesUrl

if config.useMocks
  require('mocks/url')

initialize = ->
  language = stores.UrlStore.state.params.lang || 'en'
  console.log('locales', localesUrl)
  $.i18n.init
    lng: language,
    fallbackLng: 'en',
    resGetPath: localesUrl,
    interpolationPrefix: '%{',
    interpolationSuffix: '}',
    ->
      # Start application
      Application = require('application')
      new Application

# Initialize application on DOM ready
document.addEventListener 'DOMContentLoaded', initialize, true # use capture
