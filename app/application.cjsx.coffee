SearchPage = require('components/search/search_page')

module.exports = class Application
  constructor: ->
    React.render(<SearchPage />, document.getElementById('react-root'))
