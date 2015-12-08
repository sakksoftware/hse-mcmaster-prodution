FetchAPI = require('lib/fetch_api')

FetchAPI.registerInterceptor '/user/curated_searches', (url, options) ->
  curated_searches = [
    {
      "applied_filters": [
        "22_31"
      ],
      "filters": [
        {
          "applied": true,
          "id": "22_31",
          "title": "Aboriginal health"
        }
      ],
      "id": 1,
      "query": "HIV Positive",
      "saved": false,
      "subscribed": false,
      "userid": 0
    }
  ]
  Promise.resolve({status: 200, json: -> curated_searches})

FetchAPI.registerInterceptor '/user/searches', 'POST', (url, options) ->
  saved_search = {
    "applied_filters": [
      "22_31"
    ],
    "filters": [
      {
        "applied": true,
        "id": "22_31",
        "title": "Aboriginal health"
      }
    ],
    "id": 35,
    "query": "HIV Positive",
    "saved": true,
    "subscribed": false,
    "userid": 0
  }
  Promise.resolve({status: 200, json: -> saved_search})

FetchAPI.registerInterceptor /^\/user\/searches\/[0-9]+\/subscribe$/, 'POST', (url, options) ->
  saved_search = {
    "applied_filters": [
      "22_31"
    ],
    "filters": [
      {
        "applied": true,
        "id": "22_31",
        "title": "Aboriginal health"
      }
    ],
    "id": 35,
    "query": "HIV Positive",
    "saved": true,
    "subscribed": true,
    "userid": 0
  }
  Promise.resolve({status: 200, json: -> saved_search})

FetchAPI.registerInterceptor /^\/user\/searches\/[0-9]+\/unsubscribe$/, 'POST', (url, options) ->
  saved_search = {
    "applied_filters": [
      "22_31"
    ],
    "filters": [
      {
        "applied": true,
        "id": "22_31",
        "title": "Aboriginal health"
      }
    ],
    "id": 35,
    "query": "HIV Positive",
    "saved": true,
    "subscribed": false,
    "userid": 0
  }
  Promise.resolve({status: 200, json: -> saved_search})

FetchAPI.registerInterceptor /^\/user\/searches\/[0-9]+\/?$/, 'DELETE', (url, options) ->
  saved_search = {
    "applied_filters": [
      "22_31"
    ],
    "filters": [
      {
        "applied": true,
        "id": "22_31",
        "title": "Aboriginal health"
      }
    ],
    "id": 35,
    "query": "HIV Positive",
    "saved": false,
    "subscribed": false,
    "userid": 0
  }
  Promise.resolve({status: 200, json: -> saved_search})
