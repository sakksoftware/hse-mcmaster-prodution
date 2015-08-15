module.exports =
  ifEmpty: (elements, text) ->
    if elements and !_.isEmpty(elements)
      elements
    else
      text
