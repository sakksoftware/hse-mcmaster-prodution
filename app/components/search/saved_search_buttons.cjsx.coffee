Button = require('components/shared/button')
Hotspot = require('components/tour/hotspot')
UserActions = require('actions/user_actions')
TourActions = require('actions/tour_actions')
TranslationHelper = require('mixins/translation_helper')
Checkbox = require('components/shared/checkbox')

module.exports = React.createClass
  display: 'SavedSearchButtons'
  mixins: [TranslationHelper]
  baseTranslation: 'search_page.search_box'

  propTypes:
    search: React.PropTypes.object.isRequired
    onSaveAndSubscribe: React.PropTypes.func
    hasSelected: React.PropTypes.bool
    allSelected: React.PropTypes.bool

  getDefaultProps: ->
    onSaveAndSubscribe: ->
    toggleSelectAll: ->

  componentWillMount: ->
    TourActions.addSteps [
      {
        key: 'save_search'
        order: 10
      }
      {
        key: 'save_and_subscribe'
        order: 11
      }
    ]

  componentWillUnmount: ->
    TourActions.removeSteps ['save_search', 'save_and_subscribe']

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
      <label className="select-all-action action">
        {@t('/select_all')}
        <Checkbox checked={@props.allSelected} onChange={@props.toggleSelectAll} showMinus={@props.hasSelected} name="search_to_delete"/>
      </label>
    </div>
