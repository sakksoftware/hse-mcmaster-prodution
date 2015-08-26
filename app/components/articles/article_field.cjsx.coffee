module.exports = React.createClass
  displayName: "ArticleField"

  propTypes:
    visible: React.PropTypes.any
    children: React.PropTypes.any.isRequired

  getDefaultProps: ->
    visible: true

  render: ->
    if @props.visible && @props.visible != "false"
      <div className="article-field">{@props.children}</div>
    else
      false
