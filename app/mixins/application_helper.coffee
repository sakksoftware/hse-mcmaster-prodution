module.exports =
  joinList: (array) ->
    return array if array.length <= 1
    lastItem = _.last(array)
    array[0..-2].join(', ') + ' and ' + lastItem
