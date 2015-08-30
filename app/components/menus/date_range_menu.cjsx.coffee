TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'DateRangeMenu'

  mixins: [TranslationHelper]
  baseTranslation: 'menus.date_range'

  propTypes:
    context: React.PropTypes.object

  getInitialState: ->
    start: null
    end: null

  componentWillMount: ->
    @filterGroup = @props.context.filterGroup
    @setState(start: @filterGroup.start, end: @filterGroup.end)

  applyOnEnter: (ev) ->
    if ev.keyCode == 13
      @applyFilter(ev)

  applyFilter: ->
    start = @refs.start.getDOMNode().value
    end = @refs.end.getDOMNode().value
    @setState(start: start, end: end)

    SearchActions.toggleDateRangeFilter(@filterGroup, start, end)

  render: ->
    <form className="date-range-menu">
      <span className="label">{@t('published')}</span>
      <input ref="start" name="start" onBlur={@applyFilter} onKeyDown={@applyOnEnter} defaultValue={@state.start} placeholder={@t('placeholder')} />
      <span className="seperator">-</span>
      <input ref="end" name="end" onBlur={@applyFilter} onKeyDown={@applyOnEnter} defaultValue={@state.end} placeholder={@t('placeholder')} />
      <p className="instructions">
        {@t('instructions')}
      </p>
    </form>
