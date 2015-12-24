SavedSearchItem = require('components/saved_search/saved_search_item')
Button = require('components/shared/button')
SelectableList = require('components/shared/selectable_list')
UserActions = require('actions/user_actions')
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'SavedSearchList'

  mixins: [TranslationHelper]
  baseTranslation: 'saved_search_page'

  propTypes:
    searches: React.PropTypes.array.isRequired
    toggleSubscription: React.PropTypes.func.isRequired
    showHeader: React.PropTypes.bool
    showSelect: React.PropTypes.bool

  getDefaultProps: ->
    showHeader: true
    showSelect: true

  getInitialState: ->
    allSelected: false
    hasSelected: false

  toggleSelect: (selected) ->
    allSelected = selected.length > 0 && selected.length == @props.searches.length
    @setState(hasSelected: selected.length > 0, allSelected: allSelected)

  toggleSubscription: (saved_search) ->
    @props.toggleSubscription(saved_search)

  toggleSelectAll: ->
    @refs.selectableList.toggleSelectAll()

  removeSelected: ->
    selected = @getSelected()
    UserActions.removeSearches(selected).then =>
      flash('success', @t('on_remove', searches_count: selected.length))

  getSelected: ->
    for child in @refs.selectableList.getSelected()
      child.props.search

  renderItems: ->
    for search in @props.searches
      <SavedSearchItem search={search}
        key="saved-search-item-#{search.id}"
        onToggleSubscription={@toggleSubscription}
        showSelect={@props.showSelect}
      />

  renderHeader: ->
    if @props.showHeader
      <div className="saved-search-list-header">
        <ul className="saved-search-list-actions list-actions list-inline">
          {
            if @state.hasSelected
              <li className="action remove-selected">
                <Button onClick={@removeSelected}>{@t('/remove_selected')}</Button>
              </li>
          }
          <li className="action">
            <label>
              {@t('/select_all')}
              <input type="checkbox" checked={@state.allSelected} onChange={@toggleSelectAll} name="search_to_delete"/>
            </label>
          </li>
        </ul>
      </div>

  render: ->
    <div className="saved-search-list">
      {@renderHeader()}
      <SelectableList ref="selectableList" className="saved-search-list-content list" toggleSelect={@toggleSelect} showSelectAll={false}>
        {@renderItems()}
      </SelectableList>
    </div>
