module.exports = React.createClass
  displayName: 'DocumentPage'
  propTypes:
    id: React.PropTypes.string.isRequired

  render: ->
    <h1>Hello checkout {@props.id}</h1>