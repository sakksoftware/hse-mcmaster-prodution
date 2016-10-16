module.exports =
  snakeCase: (str) -> str.toLowerCase().replace(/ /g, '_')
  sentenceCase: (str) -> str.toLowerCase().replace /[a-z]/, (letter) -> letter.toUpperCase()

  areCookiesEnabled: ->
    cookieEnabled = if navigator.cookieEnabled then true else false

    if typeof navigator.cookieEnabled == 'undefined' and !cookieEnabled
      document.cookie = 'testcookie'
      cookieEnabled = if document.cookie.indexOf('testcookie') != -1 then true else false

    cookieEnabled

  # duplicate logic in server.js (ES5 vs Coffee issue)
  slug: (str) ->
    str = str.toLowerCase().replace('<b>', '').replace('</b>', '')
    window.slug(str)
