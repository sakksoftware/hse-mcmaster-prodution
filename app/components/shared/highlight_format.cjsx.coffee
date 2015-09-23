module.exports = React.createClass
  displayName: "HighlightFormat"

  propTypes:
    children: React.PropTypes.any.isRequired

  removeTags: (str) ->
    # remove tags other than bold tag (<b></b>)
    str.replace /<(?=(\/?))\1(?:[^bB]|[bB][^\s>\/])[^>]*>/g, ''

  render: ->
    <span dangerouslySetInnerHTML={__html: @props.children} />
