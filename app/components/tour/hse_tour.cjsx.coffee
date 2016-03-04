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
