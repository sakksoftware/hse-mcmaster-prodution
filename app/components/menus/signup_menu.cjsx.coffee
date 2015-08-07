Input = ReactBootstrap.Input
Button = ReactBootstrap.Button
Util = require('lib/util')
UserActions = require('actions/user_actions')

module.exports = React.createClass
  propTypes:
    onChangePage: React.PropTypes.func

  getInitialState: ->
    {errors: {}, saved: false, submitted: false}

  handleChange: (e) ->
    errors = @state.errors
    delete errors[e.target.name]
    @setState errors: errors

  handleSubmit: (e) ->
    user = $(@refs['form'].getDOMNode()).serializeObject()
    UserActions.createUser(user, @handleSaved, @handleError)

  handleSaved: ->
    @setState(errors: {}, saved: true, submitted: true)

  handleError: (xhr, errorType, statusCode) ->
    data = JSON.parse(xhr.responseText)
    @setState(errors: data.user.errors, saved: false, submitted: true)

  getFieldStyle: (field) ->
    return if !@state[field] && !@state.submitted
    if @state.errors[field] then 'error' else 'success'

  renderInput: (label, options = {}) ->
    options = $.extend {
      name: Util.snakeCase(label)
      type: 'text'
    }, options

    if options.type == 'checkbox'
      <Input type={options.type} label={label} name={options.name} ref={options.name}  bsStyle={@getFieldStyle(options.name)} hasFeedback onChange={@handleChange} help={@state.errors[options.name]}>{label}</Input>
    else
      <Input type={options.type} placeholder={label} name={options.name} ref={options.name}  bsStyle={@getFieldStyle(options.name)} hasFeedback onChange={@handleChange} help={@state.errors[options.name]} />

  render: ->
    if @state.saved
      <div>
        <h3 className='confirmation-msg'>A conformation email has been sent to you. Pleaes confirm your registration to activate your account!</h3>
        <small>Didn&#39;t receive an emai? <a href="#">Send Again</a></small>
        <Button bsStyle='default' block disabled>Confirm Account</Button>
      </div>
    else
      <form ref='form'>
        {@renderInput('Email')}
        {@renderInput('Password')}
        {@renderInput('Confirm Password')}
        {@renderInput('I accept the', type: 'checkbox', name: 'news_letter')}<a href="/terms-of-use" target="_blank">Terms of Use</a>
        <Button bsStyle='primary' onClick={@handleSubmit} block>Create account</Button>
      </form>
