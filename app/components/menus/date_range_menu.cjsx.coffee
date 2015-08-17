# Form = require('components/shared/form')

module.exports = React.createClass
  displayName: 'DateRangeMenu'
  propTypes:
    context: React.PropTypes.object

  getInitialState: ->
    start: null
    end: null

  componentWillMount: ->
    @filterGroup = @props.context.filterGroup
    @onToggleFilter = @props.context.onToggleFilter
    @setState(start: @filterGroup.start, end: @filterGroup.end)


  applyFilter: ->
    start = @refs.start.getDOMNode().value
    end = @refs.end.getDOMNode().value
    @setState(start: start, end: end)

    if _.isEmpty(start) && _.isEmpty(end)
      @filterGroup.applied = true
      @onToggleFilter(@filterGroup)
    else
      @filterGroup.applied = false
      @filterGroup.start = start
      @filterGroup.end = end
      @onToggleFilter(@filterGroup)

  render: ->
    <form className="date-range-menu">
      Published
      <input ref="start" name="start" onBlur={@applyFilter} value={@state.start} />
      <input ref="end" name="end" onBlur={@applyFilter} value={@state.end} />
      <p className="instructions">
        (Please include two four-digit years, such as 2008 and 2009, or leave them blank to include
        publications from any year)
      </p>
    </form>
