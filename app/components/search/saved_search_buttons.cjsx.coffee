Button = require('components/shared/button')
Hotspot = require('components/tour/hotspot')
UserActions = require('actions/user_actions')
TourActions = require('actions/tour_actions')
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

  componentWillMount: ->
    TourActions.addSteps [
      {
        key: 'view_saved_articles'
        element: '.saved-articles-actions .icon-view-saved-articles'
        position: 'top'
        order: 9
      }
      {
        key: 'save_search'
        element: '.btn-save'
        position: 'bottom-left'
        order: 10
      }
      {
        key: 'save_and_subscribe'
        element: '.btn-save-and-subscribe'
        position: 'bottom-middle'
        order: 11
      }
    ]

  saveSearch: ->
    search = @props.search
    search = _.pick(search, 'query', 'applied_filters', 'sort_by', 'saved', 'subscribed')
    UserActions.toggleSaveSearch(search).then (saved_search) =>
      if saved_search.saved
        flash('success', @t('/search_page.on_save_search'))
      else
        flash('success', @t('/search_page.on_unsave_search'))

  saveAndSubscribe: ->
    @props.onSaveAndSubscribe(@saveSearch)

  render: ->
    <div className="saved-search-buttons">
      <Button className="btn-save #{'btn-save-on' if @props.search.saved}" onClick={@saveSearch}>
        <Hotspot tourKey="save_search" />
        {@t('save')}
      </Button>
      <Button className="btn-save-and-subscribe #{'btn-save-and-subscribe-on' if @props.search.subscribed}" onClick={@saveAndSubscribe}>
        <Hotspot tourKey="save_and_subscribe" />
        {@t('save_and_subscribe')}
      </Button>
      <label className="select-all-action action">{@t('/select_all')}<input type="checkbox" onChange={@props.toggleSelectAll} name="search_to_delete"/></label>
    </div>
