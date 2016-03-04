TourMixin = require('components/tour/mixin')
TourActions = require('actions/tour_actions')
TourStore = require('stores/tour_store')
tour =
  startIndex: -1,
  scrollToSteps: true
  steps: []

cb = ->
  console.log('User has completed tour!')

Tour = TourMixin(tour, cb)

# disable on mobile
if window.innerWidth < 1024
  return module.exports = {}

#
# create mixin to let component check if any of the steps apply to it
# add the mixin only to the components that can have steps
#
module.exports = _.extend({}, Tour, {
  componentWillMount: ->
    @unsubscribeTourStore = TourStore.listen(@tourStoreUpdated)

  componentWillUnmount: ->
    Tour.componentWillUnmount.call(@)
    @unsubscribeTourStore()

  componentDidMount: ->
    Tour.componentDidMount.call(@)

    @addTourStepsForMainMenu()

    if @props.page == 'home'
      @addTourStepAdvancedFilters()
    if @props.page == 'search'
      @addTourStepsForSearchPage()

  componentWillReceiveProps: (nextProps) ->
    # page changed or user logged in
    console.log('reset steps')
    TourActions.resetSteps()

  componentDidUpdate: (prevProps, prevState) ->
    # check if logged in
    Tour.componentDidUpdate.call(@, prevProps, prevState)

    if prevProps.page != @props.page
      @addTourStepsForMainMenu()

    if @props.page == 'home' && prevProps.page != @props.page
      @addTourStepAdvancedFilters()

    if @props.page == 'search' && prevProps.page != @props.page
      @addTourStepsForSearchPage()

    if @state.currentUser && prevState.currentUser != @state.currentUser
      @addTourStepsForSearchPage() if @props.page == 'search'
      @addTourStepsForMainMenu()

  addTourStepsForMainMenu: ->
    

    if @state.currentUser
      TourActions.addSteps [
        {
          key: 'profile'
          element: '.menu-item-account'
          position: 'bottom'
          cssPosition: if @props.page == 'search' then 'fixed' else 'absolute'
          order: 5
          beforeStep: -> $('.menu-item-account').addClass('hover')
          afterStep: -> $('.menu-item-account').removeClass('hover')
        }
      ]

      TourActions.addSteps [
        {
          key: 'complementary_content'
          element: '.menu-item-account'
          position: 'bottom'
          cssPosition: if @props.page == 'search' then 'fixed' else 'absolute'
          order: 12
          beforeStep: -> $('.menu-item-account').addClass('hover')
          afterStep: -> $('.menu-item-account').removeClass('hover')
        }
      ]

  addTourStepAdvancedFilters: ->
    TourActions.addStep
      key: 'advanced_search'
      element: '.advanced-search'
      position: 'bottom'
      order: 3

  addTourStepsForSearchPage: ->
    TourActions.addSteps [
      {
        key: 'filters_menu'
        element: '.filter-groups-menu-wrapper'
        position: 'top left'
        order: 4
      }
    ]

    if @state.currentUser
      TourActions.addSteps [
        {
          key: 'select_article'
          element: '.result-item:first-child .result-item-select'
          position: 'top-right'
          order: 6
          afterStep: -> $('.result-item:first-child .result-item-select input').click()
        }
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

  tourStoreUpdated: (state) ->
    steps = _.deepClone(state.steps)
    steps = _.map state.steps, (s) =>
      s = _.clone(s)
      s.text = @t("/tour.steps.#{s.key}")
      s.closeButtonText = @t('/tour.got_it')

      oldAfterStep = s.afterStep
      s.afterStep = =>
        TourActions.markStepCompleted(s)
        oldAfterStep?.call(@)
      s

    @setTourSteps(steps)

    # adjust placement
    if steps.length > 0
      @calculatePlacement()
    else
      @_unrenderLayer()

    # special cases (SUPER HACKY...)
    if steps?[0]?.key == 'save_search' || steps?[0]?.key == 'save_and_subscribe'
      _.delay (=> @calculatePlacement()), 600 # until the css animation finishes

})
