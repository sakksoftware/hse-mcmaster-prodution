App = require('components/app')

module.exports = class Application
  constructor: ->
    React.render(<App />, document.getElementById('react-root'))
