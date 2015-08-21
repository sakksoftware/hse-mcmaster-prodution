params = require('lib/url').params()

if window.location.hostname == "localhost"
  window.ENV = params.ENV || 'development'
else
  # TODO: remvoe temporary measure for setting env
  window.ENV = params.ENV || 'development'

console.log('ENV =', window.ENV)

config = require('config')[window.ENV]
if config.useMockStores
  console.log("using mock stores")
  store = require('mocks/stores')
else
  store = require('stores')

localesUrl = config.localesUrl
if params.remote_locales == "false"
  localesUrl = require('config')['development'].localesUrl

initialize = ->
  language = Cookies.get('lng') || 'en'
  $.i18n.init
    lng: language
    fallbackLng: 'en'
    resGetPath: "#{localesUrl}?cacheBuster=#{Math.random()}"
    interpolationPrefix: '%{'
    interpolationSuffix: '}',
    ->
      # Start application
      Application = require('application')
      new Application

# Initialize application on DOM ready
document.addEventListener 'DOMContentLoaded', initialize, true # use capture
