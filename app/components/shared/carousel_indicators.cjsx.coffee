module.exports = React.createClass
  displayName: "CarouselIndicators"

  propTypes:
    index: React.PropTypes.number.isRequired
    length: React.PropTypes.number.isRequired
    onClick: React.PropTypes.func.isRequired

  updateIndex: (index) ->
    => @props.onClick(index)

  renderIndicators: ->
    for i in [0..@props.length - 1]
      className = "carousel-indicator-item"
      className += " active" if i == @props.index
      <li key="carousel-indicator-#{i}" onClick={@updateIndex(i)} className={className}></li>

  render: ->
    <ul className="carousel-indicators">
      {@renderIndicators()}
    </ul>
