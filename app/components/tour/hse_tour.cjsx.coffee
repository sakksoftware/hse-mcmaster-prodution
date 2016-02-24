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

    TourActions.addSteps [
      {
        key: 'language'
        element: '.menu-item-language'
        position: 'bottom'
        order: 1
        beforeStep: -> $('.menu-item-language').addClass('hover')
        afterStep: -> $('.menu-item-language').removeClass('hover')
      }
      {
        key: 'guided_search'
        element: '.guided-questions-box'
        position: 'bottom'
        order: 2
      }
    ]

    if @props.page == 'home'
      @addTourStepAdvancedFilters()
    if @props.page == 'search' && @state.currentUser
      @addTourStepSelectResultItem()

  componentDidUpdate: (prevProps, prevState) ->
    # check if logged in
    Tour.componentDidUpdate.call(@, prevProps, prevState)
    if @state.currentUser && prevState.currentUser != @state.currentUser
      # if @props.page == 'home'
      #   # TODO: implement before index somehow? before step based on element selector?
      #   # homePageStep = steps.pop()

      TourActions.addSteps [
        {
          key: 'profile'
          element: '.menu-item-account .menu-item-profile'
          position: 'middle'
          order: 5
          afterStep: -> $('.menu-item-account').removeClass('hover')
        }
      ]

      if @props.page == 'home' #&& prevProps.page != @props.page
        @addTourStepAdvancedFilters()

      if @props.page == 'search' #&& prevProps.page != @props.page
        @addTourStepSelectResultItem()

      TourActions.addSteps [
        {
          key: 'complementary_content'
          element: '.menu-item-account .menu-item-complementary-content'
          position: 'middle'
          order: 12
          afterStep: -> $('.menu-item-account').removeClass('hover')
        }
      ]

  addTourStepAdvancedFilters: ->
    TourActions.addStep
      key: 'advanced_search'
      element: '.advanced-search'
      position: 'bottom'
      order: 3
      afterStep: -> $('.menu-item-account').addClass('hover')

  addTourStepSelectResultItem: ->
    TourActions.addSteps [
      {
        key: 'filters_menu'
        element: '.filter-groups-menu-wrapper'
        position: 'top left'
        order: 4
        afterStep: -> $('.menu-item-account').addClass('hover')
      }
      {
        key: 'select_article'
        element: '.result-item:first-child .result-item-select'
        position: 'top-right'
        order: 6
        afterStep: -> $('.result-item:first-child .result-item-select input').click()
      }
      {
        key: 'email_articles'
        element: '.saved-articles-actions .icon-email'
        position: 'top'
        order: 7
      }
      {
        key: 'save_articles'
        element: '.saved-articles-actions .icon-save-article'
        position: 'top'
        order: 8
      }
      {
        key: 'view_saved_articles'
        element: '.saved-articles-actions .icon-view-saved-articles'
        position: 'top'
        order: 9
        afterStep: ->
          # event = document.createEvent("HTMLEvents")
          # event.initEvent("click", true, true)
          # target = $('.saved-articles-actions .icon-view-saved-articles')[0]
          # target.dispatchEvent(event)
      }
      {
        key: 'save_search'
        element: '.btn-save'
        position: 'bottom'
        order: 10
      }
      {
        key: 'save_and_subscribe'
        element: '.btn-save-and-subscribe'
        position: 'bottom'
        order: 11
        afterStep: -> $('.menu-item-account').addClass('hover')
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

    @setTourSteps(steps) unless _.isEmpty(steps)
})
