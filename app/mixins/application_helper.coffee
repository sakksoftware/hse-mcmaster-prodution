module.exports =
  joinList: (array) ->
    return array if array.length <= 1
    lastItem = _.last(array)
    array[0..-2].join(', ') + ' and ' + lastItem

  ifNotEmpty: (value, other) ->
    if value
      if _.isArray(value) || _.isString(value)
        if value.length > 0
          value
        else
          other
      else
        value
    else
      other

  ellipsis: (text, maxLength) ->
    offset = 3
    return text if maxLength <= offset || !text

    endFragment = text[(maxLength - offset)..(maxLength - 1)]

    # special cases to prevent cutting off end highlight tags </b>
    if endFragment.match(/^\/b>/)
      offset = offset - 3 # don't replace those 3 characters
    if endFragment.match(/^b>/)
      offset = offset - 2 # missing either '<' or '</' leave the max length one
    if endFragment.match(/^>/)
      offset = offset - 1 # missing either '<b' or '</b' leave the max length one

    return text[0..(maxLength - (offset + 1))].trim() + '...' if text.length > maxLength
    text
