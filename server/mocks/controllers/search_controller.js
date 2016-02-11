var filterHelper = require('../support/filter_helper');

module.exports = function(app) {
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

    if (params.related_article_id)
      data.related_article = {
        id: params.related_article_id,
        title: "Effectiveness of multidisciplinary interventions to improve the quality of life for people with Parkinson's disease: A systematic review"
      };

    res.json(data);
  });
};

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
      "last_year_literature_searched": 2015,
      "traversal": "tencharacters",
      "title": "All <B>fields</B> Filled & Visible",
      "created_at": "2014-09-20 11:33:00Z",
      "updated_at": "2014-09-20 11:33:00Z",
      "quality": "7/11",
      "description": "Some <B>Crazy</B> long description goes here.....",
      "category": "<B>International</B> Organizations Document",
      "studies_conducted_in": {
        "countries": [
          {"title": "United State", "name_abbreviation": "US", "conducted_count": 3 },
          {"title": "United Kingdom", "name_abbreviation": "UK", "conducted_count": 5 }
        ]
      }
    }, {
      "id": "TBD",
      "last_year_literature_searched": 2015,
      "traversal": "tencharacters",
      "title": "All optional fields are emtpy & visible",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "studies_conducted_in": {
        "countries": [
          {"title": "United State", "name_abbreviation": "US", "conducted_count": 3 },
          {"title": "United Kingdom", "name_abbreviation": "UK", "conducted_count": 5 }
        ]
      }
    }, {
      "id": "TBD",
      "last_year_literature_searched": 2015,
      "traversal": "tencharacters",
      "title": "All fields are hidden",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "studies_conducted_in": {
        "countries": [
          {"title": "United State", "name_abbreviation": "US", "conducted_count": 3 },
          {"title": "United Kingdom", "name_abbreviation": "UK", "conducted_count": 5 }
        ]
      }
    }, {
      "id": "TBD",
      "last_year_literature_searched": 2015,
      "traversal": "tencharacters",
      "title": "Article D",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "studies_conducted_in": {
        "countries": [
          {"title": "United State", "name_abbreviation": "US", "conducted_count": 3 },
          {"title": "United Kingdom", "name_abbreviation": "UK", "conducted_count": 5 }
        ]
      }
    }, {
      "id": "TBD",
      "last_year_literature_searched": 2015,
      "traversal": "tencharacters",
      "title": "Article E",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "studies_conducted_in": {
        "countries": [
          {"title": "United State", "name_abbreviation": "US", "conducted_count": 3 },
          {"title": "United Kingdom", "name_abbreviation": "UK", "conducted_count": 5 }
        ]
      }
    }, {
      "id": "TBD",
      "last_year_literature_searched": 2015,
      "traversal": "tencharacters",
      "title": "Article F",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "studies_conducted_in": {
        "countries": [
          {"title": "United State", "name_abbreviation": "US", "conducted_count": 3 },
          {"title": "United Kingdom", "name_abbreviation": "UK", "conducted_count": 5 }
        ]
      }
    }, {
      "id": "TBD",
      "last_year_literature_searched": 2015,
      "traversal": "tencharacters",
      "title": "Article G",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "Lots of stuff goes here! Very Interesting right?.....",
      "category": "Superhero Marvel Movies",
      "studies_conducted_in": {
        "countries": [
          {"title": "United State", "name_abbreviation": "US", "conducted_count": 3 },
          {"title": "United Kingdom", "name_abbreviation": "UK", "conducted_count": 5 }
        ]
      }
    }, {
      "id": "TBD",
      "last_year_literature_searched": 2015,
      "traversal": "tencharacters",
      "title": "Article H",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "...1<b>BACKGROUND</b>: <b>Heart</b> <b>failure</b> <b>is</b> <b>the</b> <b>leading</b> <b>cause</b> <b>of</b> <b>hospitalization</b> <b>and</b> <b>readmission</b> <b>in</b> <b>many</b> <b>hospitals</b> <b>worldwide</b>. <b>We</b> <b>performed</b> <b>a</b> <b>meta</b>-<b>analysis</b> <b>to</b> <b>evaluate</b> <b>the</b> <b>effectiveness</b> <b>of</b> <b>multidisciplinary</b> <b>heart</b> <b>failure</b> <b>management</b> <b>programs</b> <b>on</b> <b>hospital</b> <b>admission</b> rates...",
      "category": "Superhero Marvel Movies",
      "studies_conducted_in": {
        "countries": [
          {"title": "United State", "name_abbreviation": "US", "conducted_count": 3 },
          {"title": "United Kingdom", "name_abbreviation": "UK", "conducted_count": 5 }
        ]
      }
    }, {
      "id": "TBD",
      "last_year_literature_searched": 2015,
      "traversal": "tencharacters",
      "title": "Article I",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "...12<b>BACKGROUND</b>: <b>Heart</b> <b>failure</b> <b>is</b> <b>the</b> <b>leading</b> <b>cause</b> <b>of</b> <b>hospitalization</b> <b>and</b> <b>readmission</b> <b>in</b> <b>many</b> <b>hospitals</b> <b>worldwide</b>. <b>We</b> <b>performed</b> <b>a</b> <b>meta</b>-<b>analysis</b> <b>to</b> <b>evaluate</b> <b>the</b> <b>effectiveness</b> <b>of</b> <b>multidisciplinary</b> <b>heart</b> <b>failure</b> <b>management</b> <b>programs</b> <b>on</b> <b>hospital</b> <b>admission</b> rates...",
      "category": "Superhero Marvel Movies",
      "studies_conducted_in": {
        "countries": [
          {"title": "United State", "name_abbreviation": "US", "conducted_count": 3 },
          {"title": "United Kingdom", "name_abbreviation": "UK", "conducted_count": 5 }
        ]
      }
    }, {
      "id": "TBD",
      "last_year_literature_searched": 2015,
      "traversal": "tencharacters",
      "title": "Article J",
      "created_at": "2013-08-20 11:33:00Z",
      "updated_at": "2013-08-20 11:33:00Z",
      "quality": "7/11",
      "description": "...<b>BACKGROUND</b>: <b>Heart</b> <b>failure</b> <b>is</b> <b>the</b> <b>leading</b> <b>cause</b> <b>of</b> <b>hospitalization</b> <b>and</b> <b>readmission</b> <b>in</b> <b>many</b> <b>hospitals</b> <b>worldwide</b>. <b>We</b> <b>performed</b> <b>a</b> <b>meta</b>-<b>analysis</b> <b>to</b> <b>evaluate</b> <b>the</b> <b>effectiveness</b> <b>of</b> <b>multidisciplinary</b> <b>heart</b> <b>failure</b> <b>management</b> <b>programs</b> <b>on</b> <b>hospital</b> <b>admission</b> rates...",
      "category": "Superhero Marvel Movies",
      "studies_conducted_in": {
        "countries": [
          {"title": "United State", "name_abbreviation": "US", "conducted_count": 3 },
          {"title": "United Kingdom", "name_abbreviation": "UK", "conducted_count": 5 }
        ]
      }
    }
  ],
  "filters": {}
};
