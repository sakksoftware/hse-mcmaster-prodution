# var React     = require('react/addons');
# var $         = require('jquery');
Indicator = require('./indicator')
Tooltip = require('./tooltip')

module.exports = (settings, done) ->
  mixin =
    settings: $.extend({
      startIndex: 0
      scrollToSteps: true
      steps: []
    }, settings)
    completionCallback: done or ->
    getInitialState: ->
      {
        currentIndex: @settings.startIndex
        showTooltip: false
        xPos: -1000
        yPos: -1000
      }
    _renderLayer: ->
      # By calling this method in componentDidMount() and componentDidUpdate(), you're effectively
      # creating a "wormhole" that funnels React's hierarchical updates through to a DOM node on an
      # entirely different part of the page.
      @setState
        xPos: -1000
        yPos: -1000
      React.render @renderCurrentStep(), @_target
      @calculatePlacement()
      return
    _unrenderLayer: ->
      React.unmountComponentAtNode @_target
      return
    componentDidUpdate: (prevProps, prevState) ->
      hasNewIndex = @state.currentIndex != prevState.currentIndex
      hasNewStep = ! !@settings.steps[@state.currentIndex]
      hasSteps = @settings.steps.length > 0
      hasNewX = @state.xPos != prevState.xPos
      hasNewY = @state.yPos != prevState.yPos
      didToggleTooltip = @state.showTooltip and @state.showTooltip != prevState.showTooltip
      if hasNewIndex and hasNewStep or didToggleTooltip or hasNewX or hasNewY
        @_renderLayer()
      else if hasSteps and hasNewIndex and !hasNewStep
        @completionCallback()
        @_unrenderLayer()
      return
    componentDidMount: ->
      # Appending to the body is easier than managing the z-index of everything on the page.
      # It's also better for accessibility and makes stacking a snap (since components will stack
      # in mount order).
      @_target = document.createElement('div')
      document.body.appendChild @_target
      if @settings.steps[@state.currentIndex]
        @_renderLayer()
      $(window).on 'resize', @calculatePlacement
      return
    componentWillUnmount: ->
      @_unrenderLayer()
      document.body.removeChild @_target
      $(window).off 'resize', @calculatePlacement
      return
    setTourSteps: (steps, cb) ->
      if !(steps instanceof Array)
        return false
      cb = cb or ->
      @settings.steps = steps
      @setState {
        currentIndex: if @state.currentIndex < 0 then 0 else @state.currentIndex
        setTourSteps: steps.length
      }, cb
      return
    getUserTourProgress: ->
      {
        index: @state.currentIndex
        percentageComplete: @state.currentIndex / @settings.steps.length * 100
        step: @settings.steps[@state.currentIndex]
      }
    preventWindowOverflow: (value, axis, elWidth, elHeight) ->
      winWidth = parseInt($(window).width())
      docHeight = parseInt($(document).height())
      if axis.toLowerCase() == 'x'
        if value + elWidth > winWidth
          console.log 'right overflow. value:', value, 'elWidth:', elWidth
          value = winWidth - elWidth
        else if value < 0
          console.log 'left overflow. value:', value, 'elWidth:', elWidth
          value = 0
      else if axis.toLowerCase() == 'y'
        if value + elHeight > docHeight
          console.log 'bottom overflow. value:', value, 'elHeight:', elHeight
          value = docHeight - elHeight
        else if value < 0
          console.log 'top overflow. value:', value, 'elHeight:', elHeight
          value = 0
      value
    calculatePlacement: ->
      step = @settings.steps[@state.currentIndex]
      $target = $(step.element)
      offset = $target.offset()
      targetWidth = $target.outerWidth()
      targetHeight = $target.outerHeight()
      position = step.position.toLowerCase()
      topRegex = new RegExp('top', 'gi')
      bottomRegex = new RegExp('bottom', 'gi')
      leftRegex = new RegExp('left', 'gi')
      rightRegex = new RegExp('right', 'gi')
      $element = if @state.showTooltip then $('.tour-tooltip') else $('.tour-indicator')
      elWidth = $element.outerWidth()
      elHeight = $element.outerHeight()
      placement =
        x: -1000
        y: -1000
      # Calculate x position
      if leftRegex.test(position)
        placement.x = offset.left - (elWidth / 2)
      else if rightRegex.test(position)
        placement.x = offset.left + targetWidth - (elWidth / 2)
      else
        placement.x = offset.left + targetWidth / 2 - (elWidth / 2)
      # Calculate y position
      if topRegex.test(position)
        placement.y = offset.top - (elHeight / 2)
      else if bottomRegex.test(position)
        placement.y = offset.top + targetHeight - (elHeight / 2)
      else
        placement.y = offset.top + targetHeight / 2 - (elHeight / 2)
      @setState
        xPos: @preventWindowOverflow(placement.x, 'x', elWidth, elHeight)
        yPos: @preventWindowOverflow(placement.y, 'y', elWidth, elHeight)
      return
    handleIndicatorClick: (evt) ->
      evt.preventDefault()
      @setState showTooltip: true
      return

    afterStep: ->
      step = @settings.steps[@state.currentIndex]
      step.afterStep?()

    closeTooltip: (evt) ->
      evt.preventDefault()
      @afterStep()
      @setState {
        showTooltip: false
        currentIndex: @state.currentIndex + 1
      }, => @scrollToNextStep()
      return
    scrollToNextStep: ->
      $nextIndicator = $('.tour-indicator')
      if $nextIndicator and $nextIndicator.length and @settings.scrollToSteps
        $('html, body').animate { 'scrollTop': $nextIndicator.offset().top - ($(window).height() / 2) }, 500
      return
    renderCurrentStep: ->
      element = null
      currentStep = @settings.steps[@state.currentIndex]
      $target = if currentStep and currentStep.element then $(currentStep.element) else null
      cssPosition = if $target then $target.css('position') else null
      if $target and $target.length
        if @state.showTooltip
          element = (
            <Tooltip cssPosition={cssPosition}
                     xPos={this.state.xPos}
                     yPos={this.state.yPos}
                     text={currentStep.text}
                     closeTooltip={this.closeTooltip}
                     closeButtonText={currentStep.closeButtonText} />
          );
        else
          element = (
           <Indicator cssPosition={cssPosition}
                      xPos={this.state.xPos}
                      yPos={this.state.yPos}
                      handleIndicatorClick={this.handleIndicatorClick} />
          );

      if !element
        throw new Error("Cannot find element with selector #{currentStep.element}")

      return element

  return mixin
