module.exports =
  snakeCase: (str) -> str.toLowerCase().replace(/ /g, '_')
