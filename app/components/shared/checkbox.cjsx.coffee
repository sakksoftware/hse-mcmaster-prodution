module.exports = React.createClass
  displayName: 'Checkbox'
  propTypes:
    name: React.PropTypes.string
    checked: React.PropTypes.bool
    showMinus: React.PropTypes.bool
    onChange: React.PropTypes.func

  getDefaultProps: ->
    checked: false
    showMinus: false
    onChange: ->

  render: ->
    className = "checkbox"
    if @props.checked
      className += " checkbox-checked"
    else if @props.showMinus
      className += " checkbox-deselect"

    <div className={className}>
      <input type="checkbox"
        checked={@props.allSelected}
        onChange={@props.onChange}
        onClick={@props.onClick}
        name={@props.name} />
    </div>
