var filterHelper = require('./support/filter_helper');

module.exports = function(app) {
  //////////////////
  // SEARCH
  //////////////////
  app.get('/api/search', function (req, res) {
    var params = req.query
    var language = params.lang || 'en';

    var data = deepClone(searchData);
    data.filters = deepClone(filterHelper.getFilters());
    data.query = params.q || '';
    data.sort_by = params.sort_by || '';
    data.page = params.page || 1;

    var appliedFilters = params.applied_filters && params.applied_filters.split(';') || [];
    data.applied_filters = appliedFilters;
    appliedFilters = appliedFilters.map(function(f) {
      if (match = f.match(/^\[(.*)\]$/)) {
        var parts = match[1].split(',');
        return {id: parts.shift(), attributes: parts};
      } else {
        return f
      }
    });
    data.filters = markFilters(data.filters, appliedFilters);

    lastResultIndex = Math.min(data.results_count - (data.results_per_page * (data.page - 1)), data.results_per_page) - 1;

    data.results = data.results.slice(0, lastResultIndex + 1);

    data.results.forEach((function(_this) {
      return function(result, i) {
        return result.id = i + 1 + ((data.page - 1) * data.results_per_page);
      };
    })(this));

    res.json(data);
  });

  //////////////////////////////////////////
  // USER
  /////////////////////////////////////////
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

  /////////////////////////////
  // ARTICLES
  ////////////////////////////
  var path = require('path');

  app.get('/api/articles/:id', function(req, res, id) {
    var file_path = 'all_filled_all_visible'
    switch(id) {
      case '1':
        file_path = 'all_filled_all_visible'
        break;
      case '2':
        file_path = 'all_hidden'
        break;
      case '3':
        file_path = 'not_filled_all_visible';
        break;
    }

    res.sendFile(path.resolve(__dirname, '../../spec/fixtures/requests/articles/' + file_path + '.json'));
  })

  function markFilters(filters, appliedFilters) {
    return filters.map(function(filter) {
      var f = appliedFilters.find(function(f) { return f === filter.id || (typeof f === 'object' && f.id === filter.id) });
      if (f) {
        filter.applied = true;
        if (typeof f === 'object') {
          filter.attributes = f.attributes;
        }
      } else {
        filter.applied = false;
      }

      if (filter.filters) {
        filter.filters = markFilters(filter.filters, appliedFilters);
      }

      return filter;
    });
  }
};

function deepClone(data) {
  return JSON.parse(JSON.stringify(data));
}

var searchData = {
  "query": "HIV",
  "page": 1,
  "results_per_page": 10,
  "results_count": 55,
  "sort_by": "relevance",
  "saved": false,
  "subscribed": false,
  "results": [
    {
      "id": "TBD",
      "traversal": "tencharacters",
      "title": "All <B>fields</B> Filled & Visible",
      "created_at": "2014-09-20 11:33:00Z",
      "updated_at": "2014-09-20 11:33:00Z",
      "quality": "7/11",
      "description": "Some <B>Crazy</B> long description goes here.....",
      "category": "<B>International</B> Organizations Document",
      "country_groupings": "<B>USA</B> (26); UK (2); Australia (1); Turkey (1)"
    }, {
      "id": "TBD",
      "traversal": "tencharacters",
      "title": "All optional fields are emtpy & visible",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "country_groupings": "USA (26); UK (2); Australia (1); Turkey (1)"
    }, {
      "id": "TBD",
      "traversal": "tencharacters",
      "title": "All fields are hidden",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "country_groupings": "USA (26); UK (2); Australia (1); Turkey (1)"
    }, {
      "id": "TBD",
      "traversal": "tencharacters",
      "title": "Article D",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "country_groupings": "USA (26); UK (2); Australia (1); Turkey (1)"
    }, {
      "id": "TBD",
      "traversal": "tencharacters",
      "title": "Article E",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "country_groupings": "USA (26); UK (2); Australia (1); Turkey (1)"
    }, {
      "id": "TBD",
      "traversal": "tencharacters",
      "title": "Article F",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "country_groupings": "USA (26); UK (2); Australia (1); Turkey (1)"
    }, {
      "id": "TBD",
      "traversal": "tencharacters",
      "title": "Article G",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "country_groupings": "USA (26); UK (2); Australia (1); Turkey (1)"
    }, {
      "id": "TBD",
      "traversal": "tencharacters",
      "title": "Article H",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "country_groupings": "USA (26); UK (2); Australia (1); Turkey (1)"
    }, {
      "id": "TBD",
      "traversal": "tencharacters",
      "title": "Article I",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "country_groupings": null
    }, {
      "id": "TBD",
      "traversal": "tencharacters",
      "title": "Article J",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "country_groupings": "USA (26); UK (2); Australia (1); Turkey (1)"
    }
  ],
  "filters": {}
};
