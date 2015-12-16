TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'SelectableList'

  baseTranslation: ''
  mixins: [TranslationHelper]

  propTypes:
    className: React.PropTypes.string

  componentWillMount: ->
    @children = []

  getInitialState: ->
    selected: []

  toggleSelect: (child) ->
    selected = _.clone @state.selected
    if found = _.find(selected, (c) -> c.props.id == child.props.id)
      selected = _(selected).without(found)
    else
      selected.push(child)

    @setState(selected: selected)

  toggleSelectAll: (ev) ->
    selected = @children

    if @state.selected.length > 0
      selected = []

    @setState(selected: selected)

  getSelected: -> @state.selected
  allSelected: ->
    @state.selected.length == @props.children.length

  hasSelectedItems: ->
    @state.selected > 0

  renderListItems: ->
    @children = []
    for child, i in @props.children
      props = _.clone(child.props)
      props.toggleSelect = @toggleSelect
      props.selected = !!_.find(@state.selected, (c) -> c.props.id == i)
      props.id = i
      props.key = "item-#{i}"
      props.key += "-selected" if props.selected

      @children.push React.cloneElement(child, props)

    @children

  render: ->
    <ol className="selectable-list #{@props.className}">
      <label>
        {@t('/select_all')}
        <input type="checkbox" checked={@allSelected()} onChange={@toggleSelectAll} name="search_to_delete"/>
      </label>
      {@renderListItems()}
    </ol>
