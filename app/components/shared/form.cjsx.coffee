Input = ReactBootstrap.Input
Button = ReactBootstrap.Button
Util = require('lib/util')

module.exports = React.createClass
  propTypes:
    onSubmit: React.PropTypes.func.isRequired

  getInitialState: ->
    {errors: {}, saved: false, submitted: false}

  handleChange: (e) ->
    errors = @state.errors
    delete errors[e.target.name]
    @setState errors: errors

  handleSubmit: (e) ->
    console.log('form submitted')
    e.preventDefault()
    user = $(@refs['form'].getDOMNode()).serializeObject()
    @props.onSubmit(user, @handleSaved, @handleError)

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
      <Input type={options.type} label={label} key={options.name} name={options.name} ref={options.name} bsStyle={@getFieldStyle(options.name)} hasFeedback onChange={@handleChange} help={@state.errors[options.name]}>{label}</Input>
    else
      <Input type={options.type} placeholder={label} key={options.name} name={options.name} ref={options.name} bsStyle={@getFieldStyle(options.name)} hasFeedback onChange={@handleChange} help={@state.errors[options.name]} />

  render: ->
    fields =
      @props.children.map (field) =>
        if field.type is 'input'
          @renderInput field.props.label, _.omit(field.props, 'label')
        else
          field

    if @state.saved
      <div>
        <h3 className='confirmation-msg'>A conformation email has been sent to you. Pleaes confirm your registration to activate your account!</h3>
        <small>Didn&#39;t receive an emai? <a href="#">Send Again</a></small>
      </div>
    else
      <form ref='form' onSubmit={@handleSubmit}>
        {fields}
      </form>
