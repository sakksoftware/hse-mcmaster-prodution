module.exports =
  snakeCase: (str) -> str.toLowerCase().replace(/ /g, '_')
  sentenceCase: (str) -> str.toLowerCase().replace /[a-z]/, (letter) -> letter.toUpperCase()
