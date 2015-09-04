params = require('lib/url').params()

if window.location.hostname == "localhost"
  window.ENV = params.ENV || 'development'
else if window.location.hostname == "staging.healthsystemsevidence.org"
  winow.ENV = params.ENV || 'staging'
else
  window.ENV = params.ENV || 'production'

console.log('ENV =', window.ENV)
config = require('config')[window.ENV]
stores = require('stores')

localesUrl = config.localesUrl
if params.remote_locales == "false"
  localesUrl = require('config')['development'].localesUrl

initialize = ->
  language = stores.UserStore.state.language
  $.i18n.init
    lng: language
    fallbackLng: 'en'
    resGetPath: "#{localesUrl}%{lng}.json?cacheBuster=#{Math.random()}"
    interpolationPrefix: '%{'
    interpolationSuffix: '}',
    ->
      # Start application
      Application = require('application')
      new Application

# Initialize application on DOM ready
document.addEventListener 'DOMContentLoaded', initialize, true # use capture
