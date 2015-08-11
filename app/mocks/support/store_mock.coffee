config = require('config')
allCountries = require('constants/countries_list')

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

  # TODO: refactor out of here, it doesn't belong here!
  getFilters: ->
    filters = _.clone(filterData.filters)

countryFilters = _.map allCountries, (country) ->
  id: country.id
  code: country.code
  name: country.name
  type: 'country'

filterData =
  "filters": [
    {"name": "Topics of Intrest", "filters": [
      {"name": "Goverance arrangements", "filters": [
        {"name": "Policy authority", "count": 2095, "id": 1001, "applied": false, "filters": [
          {"name": "Centralization/decentralization of policy authority", "id": 1002, "count": 1027, "applied": false },
          {"name": "Accountability of the state sector's role in financing & delivery", "id": 1003, "count": 1027, "applied": false },
          {"name": "Stewardship of the non-state sector's role in financing & delivery", "id": 1004, "count": 1298, "applied": false }
        ]},
        {"name": "Organizational authority", "filters": [
          {"name": "Ownership", "id": 1011, "count": 1027, "applied": false },
          {"name": "Management approaches", "id": 1012, "count": 524, "applied": false },
          {"name": "Accreditation", "id": 1013, "count": 881, "applied": false }
        ]}
      ]},
      {"name": "Financial arrangements", "filters": [
        {"name": "Policy authority", "filters": [
          {"name": "Centralization/decentralization of policy authority", "id": 1022, "count": 1027, "applied": false }
        ]}
      ]}
    ]},
    {"name": "Domains", "filters": [
      {"name": "Sectors", "filters": [
        {"name": "All of them", "id": 1234, "count": 350, "applied": false },
        {"name": "Option A", "id": 1235, "count": 200, "applied": false },
        {"name": "Option B", "id": 1236, "count": 100, "applied": false },
        {"name": "Governance", "id": 1237, "count": 100, "applied": false },
        {"name": "Human Studies", "id": 1238, "count": 135, "applied": false }
      ]},
      {"name": "Providers", "filters": [
        {"name": "All of them", "id": 2011, "count": 350, "applied": false },
        {"name": "Option A", "id": 2012, "count": 200, "applied": false },
        {"name": "Option B", "id": 2013, "count": 100, "applied": false },
        {"name": "Governance", "id": 2014, "count": 100, "applied": false },
        {"name": "Human Studies", "id": 2015, "count": 135, "applied": false }
      ]}
    ]},
    {"name": "Areas of Focus", "filters": [
      {"name": "Countries", "filters": countryFilters }
    ]},
    {"name": "Document Features", "filters": [
      {"name": "Date range", "filters": [
        {"name": "Date range", "id": 400, "applied": false}
      ]}
    ]}
  ]
