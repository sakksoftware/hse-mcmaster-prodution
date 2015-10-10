module.exports = React.createClass
  displayName: "HighlightFormat"

  propTypes:
    children: React.PropTypes.any.isRequired

  removeTags: (str) ->
    # remove tags other than bold tag (<b></b>)
    str.replace /<(?=(\/?))\1(?:[^bB]|[bB][^\s>\/])[^>]*>/g, ''

  closeUnclosedTags: (str) ->
    openingTags = str.match(/<[Bb]>/g) || []
    closingTags = str.match(/<\/[Bb]>/g) || []
    toAdd = openingTags.length - closingTags.length

    for i in [0..toAdd]
      str += '</b>'

    str

  content: ->
    @closeUnclosedTags(@removeTags(@props.children))

  render: ->
    <span dangerouslySetInnerHTML={__html: @content()} />
