NotificationActions = require('actions/notification_actions')
RefluxStateMixin = require('lib/reflux_state_mixin')(Reflux)

module.exports = Reflux.createStore
  listenables: [NotificationActions]
  mixins: [RefluxStateMixin]

  getInitialState: ->
    dialogs: []
    notifications: []

  onNotify: (notification) ->
    notifications = _.clone(@state.notifications)
    notifications.push(notification)
    @setState(notifications: notifications)

  onCloseDialog: ->
    @setState(dialogs: @state.dialogs[0..-2])

  onShowDialog: (dialog) ->
    dialogs = _.clone(@state.dialogs)
    dialogs.push(dialog)
    @setState(dialogs: dialogs)
