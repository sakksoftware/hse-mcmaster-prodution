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

  toggleSubscription: (search) ->
    UserActions.subscribeToSearch(search)

  removeSelected: ->
    UserActions.removeSearches(@getSelected()).then =>
      flash('success', @t('on_remove', searches_count: @getSelected().length))

  getSelected: ->
    for child in @refs.selectableList.getSelected()
      child.props.search

  allSelected: ->
    @refs.selectableList.allSelected()

  renderItems: ->
    for search in @props.searches
      selected = !!_.findWhere(@getSelected(), id: search.id)
      <SavedSearchItem search={search}
        key="saved-search-item-#{search.id}-#{'selected' if selected}"
        selected={selected}
        onSelect={@toggleSelect}
        onToggleSubscription={@toggleSubscription}
      />

  render: ->
    <div className="saved-search-list">
      <div className="saved-search-list-header">
        <span className="saved-search-list-instructions">{@t('instructions')}</span>
        <ul className="saved-search-list-actions list-actions list-inline">
          {
            if @getSelected().length > 0
              <li className="action remove-selected">
                <Button onClick={@removeSelected}>{@t('/remove_selected')}</Button>
              </li>
          }
          <li className="action">
            <label>
              {@t('/select_all')}
              <input type="checkbox" checked={@allSelected} onChange={@toggleSelectAll} name="search_to_delete"/>
            </label>
          </li>
        </ul>
      </div>
      <SelectableList ref="selectableList" className="saved-search-list-content list">
        {@renderItems()}
      </SelectableList>
    </div>
