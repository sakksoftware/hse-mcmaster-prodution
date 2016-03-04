NotificationActions = require('actions/notification_actions')

module.exports = React.createClass
  displayName: 'Dialog'
  propTypes:
    message: React.PropTypes.string.isRequired
    cancelText: React.PropTypes.string
    confirmText: React.PropTypes.string
    onConfirm: React.PropTypes.func

  getDefaultProps: ->
    cancelText: 'Cancel'
    confirmText: 'Confirm'
    displayCancel: true
    onConfirm: ->

  onConfirm: ->
    @props.onConfirm()
    @closeDialog()

  closeDialog: ->
    NotificationActions.closeDialog()

  render: ->
    <div className="modal fade">
      <div className="modal-dialog">
        <div className="modal-content">
          <div className="modal-header">
            <button type="button" className="close" data-dismiss="modal" aria-label="Close" onClick={@closeDialog}><span aria-hidden="true">&times;</span></button>
          </div>
          <div className="modal-body">
            <p>{@props.message}</p>
          </div>
          <div className="modal-footer">
            {
              if @props.displayCancel
                <button type="button" className="btn btn-default" data-dismiss="modal" onClick={@closeDialog}>{@props.cancelText}</button>
            }
            <button type="button" className="btn btn-primary" onClick={@onConfirm}>{@props.confirmText}</button>
          </div>
        </div>
      </div>
    </div>
