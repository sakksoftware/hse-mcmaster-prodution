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

  getInitialState: ->
    allSelected: false
    hasSelected: false

  toggleSelect: (selected) ->
    @setState(hasSelected: selected.length > 0, allSelected: selected.length == @props.searches.length)

  toggleSubscription: (search) ->
    UserActions.subscribeToSearch(search)

  toggleSelectAll: ->
    @refs.selectableList.toggleSelectAll()

  removeSelected: ->
    UserActions.removeSearches(@getSelected()).then =>
      flash('success', @t('on_remove', searches_count: @getSelected().length))

  getSelected: ->
    for child in @refs.selectableList.getSelected()
      child.props.search

  renderItems: ->
    for search in @props.searches
      <SavedSearchItem search={search}
        key="saved-search-item-#{search.id}"
        onToggleSubscription={@toggleSubscription}
      />

  render: ->
    <div className="saved-search-list">
      <div className="saved-search-list-header">
        <span className="saved-search-list-instructions">{@t('instructions')}</span>
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
      <SelectableList ref="selectableList" className="saved-search-list-content list" toggleSelect={@toggleSelect} showSelectAll={false}>
        {@renderItems()}
      </SelectableList>
    </div>
