FetchAPI = require('lib/fetch_api')

FetchAPI.registerInterceptor '/user/curated_searches', (url, options) ->
  curated_searches = [
    {
      "applied_filters": [
        "6_267",
        "1_29",
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
