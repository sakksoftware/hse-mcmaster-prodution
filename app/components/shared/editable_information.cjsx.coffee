Form = require('components/shared/form')

module.exports = React.createClass
  displayName: 'EditableInformation'

  propTypes:
    title: React.PropTypes.string.isRequired
    object: React.PropTypes.object.isRequired
    children: React.PropTypes.array.isRequired

  getInitialState: ->
    readOnly: true

  toggleReadOnly: ->
    @setState(readOnly: !@state.readOnly)

  renderChildren: ->
    for child in @props.children
      if (child.type == "input" || child.type == "select") && @state.readOnly
        <div key="readonly-field-#{child.props.name}" className="readonly-field readonly-field-#{child.props.name}">
          <div className="readonly-field-label">{child.props.label}</div>
          <div className="readonly-field-value">{@props.object[child.props.name]}</div>
        </div>
      else if child.type == "input"
        <input key="editable-field-#{child.props.name}" className="editable-field editable-field-#{child.props.name}"
          defaultValue={@props.object[child.props.name]} type={child.props.type} label={child.props.label} />
      else if child.type == "select"
        child
      else
        child

  render: ->
    if @state.readOnly
      <div key="readonly-editable" className="editable-information">
        <h2>{@props.title}</h2>
        <a href="#" className="btn-toggle" onClick={@toggleReadOnly}>Edit</a>
        {@renderChildren()}
      </div>
    else
      <Form key="writeable-editable" className="editable-information">
        <h2>{@props.title}</h2>
        <a href="#" className="btn-toggle" onClick={@toggleReadOnly}>Cancel</a>
        {@renderChildren()}
        <button>Update information</button>
      </Form>
