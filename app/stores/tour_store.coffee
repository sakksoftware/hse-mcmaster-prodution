TourActions = require('actions/tour_actions')
RefluxStateMixin = require('lib/reflux_state_mixin')(Reflux)

module.exports = Reflux.createStore
  listenables: [TourActions]
  mixins: [RefluxStateMixin]

  getInitialState: ->
    steps: []

  onAddStep: (step) ->
    @onAddSteps([step])

  onAddSteps: (steps) ->
    steps = @state.steps.concat(steps)
    steps = steps.sort (a, b) -> a.order - b.order

    completedSteps = @getCompletedSteps()
    steps = steps.filter (s) -> completedSteps.indexOf(s.key) < 0
    @setState(steps: steps)

  onMarkStepCompleted: (step) ->
    completedSteps = @getCompletedSteps()
    completedSteps.push(step.key) unless completedSteps.indexOf(step.key) >= 0
    Cookies.set('completed_tour_steps', completedSteps.join(';'))

    @setState(steps: @state.steps.filter (s) -> completedSteps.indexOf(s.key) < 0)

  getCompletedSteps: ->
    (Cookies.get('completed_tour_steps') || '').split(';')

  onResetSteps: ->
    @setState(steps: [])
