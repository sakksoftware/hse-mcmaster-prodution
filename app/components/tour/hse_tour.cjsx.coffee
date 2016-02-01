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
        text: 'Select the language you prefer when using Health Systems Evidence.'
        element: '.menu-item-language'
        position: 'bottom'
        closeButtonText: 'Next'
      }
      {
        text: 'Get assistance in applying the filters available on Health Systems Evidence to narrow your search by responding to these plain-language questions. The guided search can be turned off or on (indicated by the toggle at the top of the screen) and can be expanded or hidden on a mobile device.'
        element: '.menu-item-guided-search'
        position: 'bottom'
        closeButtonText: 'Next'
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
          text: 'Change your account information (e.g., email, password, name, role) by clicking on ‘profile’ and then the ‘edit’ button within each section.'
          element: '.menu-item-account'
          position: 'bottom'
          closeButtonText: 'Next'
        }
        {
          text: 'Enable or disable your access to complementary content contained'
          element: '.menu-item-account'
          closeButtonText: 'Next'
          position: 'bottom'
        }
      ]

      if @props.page == 'home' #&& prevProps.page != @props.page
        @addTourStepAdvancedFilters()

      if @props.page == 'search' #&& prevProps.page != @props.page
        @addTourStepSelectResultItem()

  addTourStepAdvancedFilters: ->
    TourActions.addSteps
      text: 'Explore the full list of search filters available on Health Systems Evidence, which you can then apply to narrow your search.'
      element: '.advanced-search'
      position: 'bottom'

  addTourStepSelectResultItem: ->
    TourActions.addSteps [
      {
        text: 'Select an article to save, export or view later'
        element: '.result-item:first-child .result-item-select'
        position: 'top-right'
        afterStep: -> $('.result-item:first-child .result-item-select input').click()
      }
      {
        text: 'Send the list of documents selected from your search results by email to yourself or others.'
        element: '.saved-articles-actions .icon-email'
        position: 'top'
      }
      {
        text: 'Save the list of documents selected from your search results directly to your personal ‘Saved documents’ clipboard.'
        element: '.saved-articles-actions .icon-save-article'
        position: 'top'
      }
      {
        text: 'View the list of documents you have saved from previous searches. Your saved documents can also be managed (i.e., retained on or deleted from your profile) on this page. '
        element: '.saved-articles-actions .icon-view-saved-articles'
        position: 'top'
      }
      {
        text: 'Save your search strategy - including keywords and filters – and use it at any time, by clicking the ‘Save search’ icon. You can manage your list of saved searches by clicking the ‘Saved searches’ option from the account profile dropdown menu.'
        element: '.btn-save'
        position: 'bottom'
      }
      {
        text: 'Save your search strategy and subscribe to receive a monthly email containing links to any documents that have been newly added to Health Systems Evidence and meet your search parameters. Your subscriptions can be managed on the ‘Saved searches’ page, where you can also subscribe to past searches you have saved, as well as to any of the suggested ‘Curated searches’ prepared by the Health Systems Evidence team.'
        element: '.btn-save-and-subscribe'
        position: 'bottom'
      }
      {
        text: 'Enable or disable your access to complementary content contained'
        element: '.menu-item-account'
        position: 'bottom'
      }
    ]

  tourStoreUpdated: (state) ->
    steps = state.steps
    steps = _.map state.steps, (s) ->
      s = _.clone(s);
      s.closeButtonText = 'Next'
      s

    steps[steps.length - 1].closeButtonText = 'Close'
    @setTourSteps(steps)
})
