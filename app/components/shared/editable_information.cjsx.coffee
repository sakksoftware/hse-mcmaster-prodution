Form = require('components/shared/form')

module.exports = React.createClass
  displayName: 'EditableInformation'

  propTypes:
    title: React.PropTypes.string.isRequired
    object: React.PropTypes.object.isRequired
    children: React.PropTypes.array.isRequired
    onSubmit: React.PropTypes.func.isRequired
    editLabel: React.PropTypes.string
    cancelLabel: React.PropTypes.string

  getDefaultProps: ->
    editLabel: "Edit"
    cancelLabel: "Cancel"

  getInitialState: ->
    readOnly: true

  toggleReadOnly: ->
    @setState(readOnly: !@state.readOnly)

  handleSubmit: (data) ->
    @props.onSubmit(data, @)

  getValue: (props, child)->
    if child.type == "select"
      selectedOption = _(child.props.children).find (c) =>
        "" + c.props.value == "" + props.object[child.props.name]
      selectedOption.props.children
    else if child.props.type == "password"
      "******"
    else
      @props.object[child.props.name]

  renderChildren: ->
    for child in @props.children
      if (child.type == "input" || child.type == "select") && @state.readOnly
        <div key="readonly-field-#{child.props.name}" className="readonly-field readonly-field-#{child.props.name}">
          <div className="readonly-field-label">{child.props.label}</div>
          <div className="readonly-field-value">{@getValue(@props, child)}</div>
        </div>
      else if child.type == "input"
        <input key="editable-field-#{child.props.name}" className="editable-field editable-field-#{child.props.name}"
          defaultValue={@props.object[child.props.name]} name={child.props.name} type={child.props.type} label={child.props.label} />
      else if child.type == "select"
        child
      else
        child

  render: ->
    if @state.readOnly
      <div key="readonly-editable" className="editable-information">
        <h2>{@props.title}</h2>
        <a href="#" className="btn-toggle" onClick={@toggleReadOnly}>{@props.editLabel}</a>
        {@renderChildren()}
      </div>
    else
      <Form key="writeable-editable" onSubmit={@handleSubmit} className="editable-information">
        <h2>{@props.title}</h2>
        <a href="#" className="btn-toggle" onClick={@toggleReadOnly}>{@props.cancelLabel}</a>
        {@renderChildren()}
        <button>Update information</button>
      </Form>
