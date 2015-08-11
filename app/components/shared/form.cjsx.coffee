Input = ReactBootstrap.Input
Button = ReactBootstrap.Button
Util = require('lib/util')

module.exports = React.createClass
  propTypes:
    onSubmit: React.PropTypes.func.isRequired
    afterSave: React.PropTypes.func
    afterSaveContent: React.PropTypes.node
    replaceContent: React.PropTypes.bool

  getInitialState: ->
    {errors: {}, saved: false, submitted: false}

  componentDidUpdate: ->
    @state.saved == true && @props.afterSave?()

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

    if @props.replaceContent && @state.saved
      @props.afterSaveContent?() || <div></div>
    else
      <form ref='form' onSubmit={@handleSubmit}>
        {fields}
      </form>
