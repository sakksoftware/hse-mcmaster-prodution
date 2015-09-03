Input = ReactBootstrap.Input
Button = ReactBootstrap.Button
Util = require('lib/util')
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'Form'
  propTypes:
    onSubmit: React.PropTypes.func.isRequired
    afterSave: React.PropTypes.func
    afterSaveContent: React.PropTypes.func
    replaceContent: React.PropTypes.bool

  # TODO: think of how to remove dependency on translations helper in
  # this generic form component
  mixins: [TranslationHelper]
  baseTranslation: 'errors'

  getInitialState: ->
    {errors: {}, saved: false, submitted: false}

  componentDidUpdate: ->
    @state.saved == true && @props.afterSave?(@model())

  handleChange: (e) ->
    errors = @state.errors
    delete errors[e.target.name]
    @setState errors: errors

  handleSubmit: (e) ->
    e.preventDefault()
    @props.onSubmit(@model(), @handleSaved, @handleError)

  handleSaved: ->
    @setState(errors: {}, saved: true, submitted: true)

  handleError: (xhr, errorType, statusCode) ->
    data = JSON.parse(xhr.responseText)
    errors = data.errors
    # transform data for .NET
    if _.isArray(errors)
      _errors = {}
      for error in errors
        _errors[error.key] = @t(error.value)
      errors = _errors

    @setState(errors: errors, saved: false, submitted: true)

  getFieldStyle: (field) ->
    return if !@state[field] && !@state.submitted
    if @state.errors[field] then 'error' else 'success'

  model: -> $(@refs['form'].getDOMNode()).serializeObject()

  renderInput: (label, options = {}) ->
    options = $.extend {
      name: Util.snakeCase(label)
      type: 'text'
    }, options

    if options.type == 'checkbox'
      <Input type={options.type} label={label} key={options.name} name={options.name} ref={options.name} bsStyle={@getFieldStyle(options.name)} defaultValue={options.defaultValue} hasFeedback onChange={@handleChange} help={@state.errors[options.name]}>{label}</Input>
    else
      <Input type={options.type} placeholder={label} key={options.name} name={options.name} ref={options.name} bsStyle={@getFieldStyle(options.name)} defaultValue={options.defaultValue} hasFeedback onChange={@handleChange} help={@state.errors[options.name]} />

  renderFields: (fields) ->
    fields = [fields] unless _.isArray(fields)
    fields.map (field) =>
      if field?.type is 'input'
        @renderInput field.props.label, _.omit(field.props, 'label')
      else if _.isArray(field)
        @renderFields(field)
      else
        field

  render: ->
    if @props.replaceContent && @state.saved
      @props.afterSaveContent?() || <div></div>
    else
      <form ref='form' onSubmit={@handleSubmit} className={@props.className}>
        {@renderFields(@props.children)}
      </form>
