update = React.addons.update
_ = {}

_.object = (keys, vals) ->
  o = {}
  i = 0
  while i < keys.length
    o[keys[i]] = vals[i]
    i++
  o

_.isObject = (obj) ->
  type = typeof obj
  type == 'function' or type == 'object' and ! !obj

_.extend = (obj) ->
  if !_.isObject(obj)
    return obj
  source = undefined
  prop = undefined
  i = 1
  length = arguments.length
  while i < length
    source = arguments[i]
    for prop of source
      `prop = prop`
      if Object.getOwnPropertyDescriptor and Object.defineProperty
        propertyDescriptor = Object.getOwnPropertyDescriptor(source, prop)
        Object.defineProperty obj, prop, propertyDescriptor
      else
        obj[prop] = source[prop]
    i++
  obj

_.isFunction = (value) ->
  typeof value == 'function'

###*
# Creates the mixin, ready for use in a store
#
# @param Reflux object An instance of Reflux
# @returns {{setState: Function, init: Function}}
###

module.exports = (Reflux) ->

  attachAction = (options, actionName) ->
    if @[actionName]
      console.warn 'Not attaching event ' + actionName + '; key already exists'
      return
    @[actionName] = Reflux.createAction(options)
    return

  if typeof Reflux != 'object' or typeof Reflux.createAction != 'function'
    throw new Error('Must pass reflux instance to reflux-state-mixin')
  {
    setState: (state) ->
      changed = false
      prevState = update({}, $merge: @state)
      for key of state
        if state.hasOwnProperty(key)
          if @state[key] != state[key]
            @[key].trigger state[key]
            changed = true
      if changed
        @state = update(@state, $merge: state)
        if _.isFunction(@storeDidUpdate)
          @storeDidUpdate prevState
        @trigger @state
      return
    init: ->
      if _.isFunction(@getInitialState)
        @state = @getInitialState()
        for key of @state
          if @state.hasOwnProperty(key)
            attachAction.call this, @state[key], key
      return
    connect: (store, key) ->
      {
        getInitialState: ->
          if !_.isFunction(store.getInitialState)
            {}
          else if key == undefined
            store.state
          else
            _.object [ key ], [ store.state[key] ]
        componentDidMount: ->
          _.extend this, Reflux.ListenerMethods
          noKey = key == undefined
          me = this
          cb = if noKey then @setState else ((v) ->
            if typeof me.isMounted == 'undefined' or me.isMounted() == true
              me.setState _.object([ key ], [ v ])
            return
          )
          listener = if noKey then store else store[key]
          @listenTo listener, cb
          return
        componentWillUnmount: Reflux.ListenerMixin.componentWillUnmount
      }

  }
