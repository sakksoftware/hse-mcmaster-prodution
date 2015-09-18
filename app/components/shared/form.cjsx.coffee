Input = ReactBootstrap.Input
Button = ReactBootstrap.Button
Util = require('lib/util')
TranslationHelper = require('mixins/translation_helper')

# TODO: either replace with React-Form or refactor to be more like form_for in rails
# i.e. we get passed a model (required) and based on that do all sorts of validations
# and display things
module.exports = React.createClass
  displayName: 'Form'
  propTypes:
    onSubmit: React.PropTypes.func.isRequired
    onError: React.PropTypes.func
    afterSave: React.PropTypes.func
    afterSaveContent: React.PropTypes.func
    replaceContent: React.PropTypes.bool
    model: React.PropTypes.object

  # TODO: think of how to remove dependency on translations helper in
  # this generic form component
  mixins: [TranslationHelper]
  baseTranslation: 'errors'

  getInitialState: ->
    {errors: {}, saved: false, submitted: false}

  componentWillMount: ->
    @setState(errors: @props.model.errors || {}) if @props.model

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
    @props.onError?(errors)

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
      <Input type={options.type} label={label} key={options.name} name={options.name} ref={options.name} bsStyle={@getFieldStyle(options.name)} defaultValue={options.defaultValue} hasFeedback onChange={@handleChange} help={@state.errors[options.name]} />
    else
      <Input type={options.type} placeholder={label} key={options.name} name={options.name} ref={options.name} bsStyle={@getFieldStyle(options.name)} defaultValue={options.defaultValue} hasFeedback onChange={@handleChange} help={@state.errors[options.name]} />

  renderFields: (fields) ->
    fields = [fields] unless _.isArray(fields)
    fields.map (field) =>
      if field?.type is 'input'
        options = _.omit(field.props, 'label')
        options.defaultValue = @props.model[field.props.name] if @props.model
        @renderInput field.props.label, options
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
