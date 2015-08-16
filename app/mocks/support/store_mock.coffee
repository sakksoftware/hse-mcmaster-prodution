config = require('config')

module.exports =
  ##
  # @param (optional) statusCode - the status code number
  # @param ()
  ##
  send: (statusCode, res, success, url) ->
    unless _.isNumber(statusCode)
      url = success
      success = res
      res = statusCode
      statusCode = 200

    callback = =>
      console.log("#{statusCode} #{url} response:", res)
      success(res)

    setTimeout callback, config.mockResponseTime

  # TODO: can be refactored to match the top item
  sendError: (statusCode, res, success, url) ->
    unless _.isNumber(statusCode)
      url = success
      success = res
      res = statusCode
      statusCode = 400

    callback = =>
      console.log("#{statusCode} #{url} response:", res)
      xhr = { responseText: JSON.stringify(res) }
      statusText = "Error"
      success(xhr, statusCode, statusText)

    setTimeout callback, config.mockResponseTime
