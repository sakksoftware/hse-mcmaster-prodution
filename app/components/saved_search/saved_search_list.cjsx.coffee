SavedSearchItem = require('components/saved_search/saved_search_item')
Button = require('components/shared/button')
UserActions = require('actions/user_actions')
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'SavedSearchList'

  mixins: [TranslationHelper]
  baseTranslation: 'saved_search_page'

  propTypes:
    searches: React.PropTypes.array.isRequired

  getInitialState: ->
    selectedSearches: []
    allSelected: false

  toggleSelectAll: (ev) ->
    selectedSearches = @props.searches
    allSelected = false

    if @state.selectedSearches.length > 0
      selectedSearches = []
      allSelected = false
    else
      allSelected = true

    @setState(selectedSearches: selectedSearches, allSelected: allSelected)

  toggleSubscription: (search) ->
    UserActions.subscribeToSearch(search)

  toggleSelect: (search) ->
    selectedSearches = _.clone(@state.selectedSearches)
    if found = _(selectedSearches).findWhere(id: search.id)
      selectedSearches = _(selectedSearches).without(found)
    else
      selectedSearches.push(search)

    allSelected = selectedSearches.length == @props.searches.length
    @setState(selectedSearches: selectedSearches, allSelected: allSelected)

  removeSelected: ->
    UserActions.removeSearches(@state.selectedSearches)

  renderItems: ->
    for search in @props.searches
      selected = !!_.findWhere(@state.selectedSearches, id: search.id)
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
            if @state.selectedSearches.length > 0
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
      <ul className="saved-search-list-content list">
        {@renderItems()}
      </ul>
    </div>
