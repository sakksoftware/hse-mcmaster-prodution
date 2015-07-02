module.exports = React.createClass
  displayName: 'SearchBar'
  propTypes:
    onSearch: React.PropTypes.func.isRequired

  handleSubmit: (e) ->
    e.preventDefault()
    @props.onSearch?(@refs.search.getDOMNode().value)

  render: ->
    <form action="#" onSubmit={@handleSubmit} className="search-bar">
      <input type="text" placeholder="Search..." ref="search" />
      <button>Search</button>
    </form>