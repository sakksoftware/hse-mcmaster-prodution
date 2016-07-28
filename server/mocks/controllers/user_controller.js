var _ = require('underscore');

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
      },
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
        "name": "Named search",
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

  app.get('/api/user/articles', function(req, res) {
    var template = {
      "id": "all_filled_all_visible",
      "traversal": "tencharacters",
      "title": "Article 1",
      "created_at": "2014-09-20 11:33:00Z",
      "updated_at": "2014-09-20 11:33:00Z",
      "quality": "7/11",
      "description": "Some <B>Crazy</B> long description goes here.....",
      "category": "<B>International</B> Organizations Document",
      "country_groupings": "<B>USA</B> (26); UK (2); Australia (1); Turkey (1)"
    };
    var articles = [];

    for(var i = 0; i < 203; i++) {
      var article = JSON.parse(JSON.stringify(template));
      article.title = 'Article ' + (i + 1);
      articles.push(article);
    }
    res.json(articles);
  });

  app.post('/api/user/articles/export.csv', function(req, res) {
    if(req.body.length > 200)
      return res.status(403).json({status: 'error', message: 'Export limit reached'});

    res.json({file: '/api/user/exported-file-01'});
  });

  app.get('/api/user/exported-file-01', function(req, res) {
    var contents = ["Title,URL,Description,Details,ShortDetails,Resource,Type,Identifiers,Db,EntrezUID,Properties",
      '"' +["Cost-effectiveness analysis of a television campaign to promote seasonal influenza vaccination among the elderly","http://www.healthsystemsevidence.com/articles/31071?t=Cost-effec","Kim M Yoo BK ","Value in Health. 2015. 10.1016/j.jval.2015.03.1794","Value in Health. 2015","HSE","citation","","hse","","8/31/2015 9:29:05 AM | Kim M"].join('", "') + '"'
    ].join('\n');

    res.attachment();
    res.send(contents);
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

  app.post('/api/user/searches/:id/unsubscribe', function(req, res) {
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

  app.put('/api/user/unsubscribe', function(req, res) {
    res.json(req.query);
  });
}
