module.exports = React.createClass
  displayName: 'SelectableList'

  propTypes:
    className: React.PropTypes.string

  getInitialState: ->
    selected: []
    allSelected: false

  toggleSelect: (article) ->
    selected = _.clone @state.selected
    if found = _.findWhere(selected, id: article.id)
      selected = _(selected).without(found)
    else
      selected.push(article)

    @setState(selected: selected)

  toggleSelectAll: (ev) ->
    selected = @props.items
    allSelected = false

    if @state.selected.length > 0
      selected = []
      allSelected = false
    else
      allSelected = true

    @setState(selected: selected, allSelected: allSelected)

  getSelected: -> @state.selected
  allSelected: ->
    # TODO: probably don't even need a state for this
    @state.allSelected

  hasSelectedItems: ->
    @state.selected > 0

  renderListItems: ->
    for child in @props.children
      props = _.clone(child.props)
      props.toggleSelect = @toggleSelect
      # TODO: figure out how to associate between json data and related
      props.selected = true

      child = React.cloneElement(child, props)
      child

  render: ->
    <ol className="selectable-list #{@props.className}">
      {@renderListItems()}
    </ol>
