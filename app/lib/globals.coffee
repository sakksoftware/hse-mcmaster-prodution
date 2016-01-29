NotificationActions = require('actions/notification_actions')

module.exports = ->
  window.flash = (type='info', msg) ->
    NotificationActions.notify(type, msg)
