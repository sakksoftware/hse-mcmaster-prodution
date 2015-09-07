SignupMenu = require('components/menus/signup_menu')

module.exports = React.createClass
  displayName: 'SignupPrompt'

  getInitialState: ->
    isDismissed: false

  onDismiss: (e) ->
    e.preventDefault()
    @dismiss()

  dismiss: ->
    @setState(isDismissed: true)

  render: ->
    return false if @state.isDismissed

    <div className="signup-prompt">
      <div className="signup-prompt-title">
        Sign up to view more than 20 results, to save documents and searches,
        and to subscribe to email alerts
        <a href="#" className="signup-prompt-dismiss" onClick={@onDismiss}>x</a>
      </div>
      <SignupMenu onSignup={@dismiss} />
    </div>
