Button = require('components/shared/button')
UserActions = require('actions/user_actions')
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  display: 'SavedSearchButtons'
  mixins: [TranslationHelper]
  baseTranslation: 'search_page.search_box'

  propTypes:
    search: React.PropTypes.object.isRequired
    onSaveAndSubscribe: React.PropTypes.func

  getDefaultProps: ->
    onSaveAndSubscribe: ->
    toggleSelectAll: ->

  saveSearch: ->
    search = @props.search
    @props.search.saved = !@props.search.saved
    @forceUpdate()
    search = _.pick(search, 'query', 'applied_filters', 'sort_by', 'saved', 'subscribed')
    UserActions.saveSearch(search).then (search) =>
      if search.saved
        flash('success', @t('/search_page.on_save_search'))
      else
        flash('success', @t('/search_page.on_unsave_search'))

  saveAndSubscribe: ->
    @props.search.subscribed = !@props.search.subscribed
    @props.onSaveAndSubscribe(@saveSearch)

  render: ->
    <div className="saved-search-buttons">
      <Button className="btn-save #{'btn-save-on' if @props.search.saved}" onClick={@saveSearch}>{@t('save')}</Button>
      <Button className="btn-save-and-subscribe #{'btn-save-and-subscribe-on' if @props.search.subscribed}" onClick={@saveAndSubscribe}>{@t('save_and_subscribe')}</Button>
      <label className="select-all-action action">{@t('/select_all')}<input type="checkbox" onChange={@props.toggleSelectAll} name="search_to_delete"/></label>
    </div>
