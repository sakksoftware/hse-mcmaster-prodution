module.exports = function(app) {
  app.get('/api/user/curated_searches', function(req, res) {
    var curated_searches = [
      {
        "applied_filters": ["22_31"],
        "filters": [
          {
            "applied": true,
            "id": "22_31",
            "title": "Aboriginal health"
          },
        ],
        "id": 1,
        "query": "HIV Positive",
        "saved": false,
        "subscribed": false,
        "userid": 0
      }
    ];

    filter = curated_searches[0].filters[0];
    var filters = [];
    for(var i = 0; i < 10; i++) {
      filters.push(filter);
    }
    curated_searches[0].filters = filters;

    res.json(curated_searches);
  });

  app.post('/api/user/searches', function(req, res) {
    var params = req.body;
    var saved_search = {
      "applied_filters": ["22_31"],
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
      "subscribed": params.subscribed,
      "userid": 0
    };
    res.json(saved_search);
  });

  app.post('/api/user/searches/:id/subscribe', function(req, res) {
    var saved_search = {
      "applied_filters": ["22_31"],
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
    };

    res.json(saved_search);
  });

  app.post('/apiuser/searches/:id/unsubscribe', function(req, res) {
    var saved_search = {
      "applied_filters": ["22_31"],
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
    };
    res.json(saved_search);
  });

  app.post('/api/user/searches/remove', function(req, res) {
    var saved_search = [
      {
        "applied_filters": ["22_31"],
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
    ];

    res.json(saved_search);
  });
}
