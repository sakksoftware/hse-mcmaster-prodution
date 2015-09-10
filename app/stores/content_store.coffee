ContentActions = require('actions/content_actions')
config = require('config')

module.exports = Reflux.createStore
  listenables: [ContentActions]

  loadMarkdownFile: (fileName, success, error) ->
    language = $.i18n.lng()
    $.get("#{config.localesUrl}markdowns/#{fileName}/#{language}.md")
      .done(success)
      .fail(error)
