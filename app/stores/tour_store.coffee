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
    @setState(steps: steps)