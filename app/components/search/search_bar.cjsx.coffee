Input = ReactBootstrap.Input

module.exports = React.createClass
  displayName: 'SearchBar'
  propTypes:
    query: React.PropTypes.string.isRequired
    onSearch: React.PropTypes.func.isRequired

  handleSubmit: (e) ->
    e.preventDefault()
    @props.onSearch?(@refs.search.getDOMNode().value)

  render: ->
    <form action="#" onSubmit={@handleSubmit} className="search-bar">
      <input type="text" placeholder="Search..." ref="search" defaultValue={@props.query} />
      <button>Search</button>
    </form>