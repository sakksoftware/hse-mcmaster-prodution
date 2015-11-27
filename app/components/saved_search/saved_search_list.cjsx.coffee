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
    selected: []
    allSelected: false

  toggleSelectAll: (ev) ->
    selected = @props.searches
    allSelected = false

    if @state.selected.length > 0
      selected = []
      allSelected = false
    else
      allSelected = true

    @setState(selected: selected, allSelected: allSelected)

  toggleSubscription: (saved_search) ->
    UserActions.toggleSubscribeToSavedSearch(saved_search.id, saved_search.subscribed)

  toggleSelect: (saved_search) ->
    selected = _.clone(@state.selected)
    if found = _(selected).findWhere(id: saved_search.id)
      selected = _(selected).without(found)
    else
      selected.push(saved_search)

    allSelected = selected.length == @props.searches.length
    @setState(selected: selected, allSelected: allSelected)

  removeSelected: ->
    UserActions.removeSearches(@state.selected).then =>
      flash('success', @t('on_remove', searches_count: @state.selected.length))
      @setState(selected: [])

  renderItems: ->
    for search in @props.searches
      selected = !!_.findWhere(@state.selected, id: search.id)
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
            if @state.selected.length > 0
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
