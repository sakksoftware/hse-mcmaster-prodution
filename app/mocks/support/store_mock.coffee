config = require('config')
allCountries = require('constants/countries_list')

module.exports =
  send: (res, success, url) ->
    callback = =>
      console.log("#{url} response:", res)
      success(res)

    setTimeout callback, config.mockResponseTime

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
        {"name": "Policy authority", "count": 2095, "id": 101, "applied": false, "filters": [
          {"name": "Centralization/decentralization of policy authority", "id": 102, "count": 1027, "applied": false },
          {"name": "Accountability of the state sector's role in financing & delivery", "id": 103, "count": 1027, "applied": false },
          {"name": "Stewardship of the non-state sector's role in financing & delivery", "id": 104, "count": 1298, "applied": false }
        ]},
        {"name": "Organizational authority", "filters": [
          {"name": "Ownership", "id": 111, "count": 1027, "applied": false },
          {"name": "Management approaches", "id": 112, "count": 524, "applied": false },
          {"name": "Accreditation", "id": 113, "count": 881, "applied": false }
        ]}
      ]},
      {"name": "Financial arrangements", "filters": [
        {"name": "Policy authority", "filters": [
          {"name": "Centralization/decentralization of policy authority", "id": 122, "count": 1027, "applied": false }
        ]}
      ]}
    ]},
    {"name": "Domains", "filters": [
      {"name": "Sectors", "filters": [
        {"name": "All of them", "id": 1234, "count": 350, "applied": false },
        {"name": "Option A", "id": 1235, "count": 200, "applied": false },
        {"name": "Option B", "id": 1236, "count": 100, "applied": false },
        {"name": "Governance", "id": 1237, "count": 100, "applied": true },
        {"name": "Human Studies", "id": 1238, "count": 135, "applied": true }
      ]},
      {"name": "Providers", "filters": [
        {"name": "All of them", "id": 211, "count": 350, "applied": false },
        {"name": "Option A", "id": 212, "count": 200, "applied": false },
        {"name": "Option B", "id": 213, "count": 100, "applied": false },
        {"name": "Governance", "id": 214, "count": 100, "applied": true },
        {"name": "Human Studies", "id": 215, "count": 135, "applied": true }
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
