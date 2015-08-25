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
