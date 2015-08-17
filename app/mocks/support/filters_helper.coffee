allCountries = require('constants/countries_list')

module.exports =
  getFilters: ->
    filters = _.clone(filterData.filters)

countryFilters = _.map allCountries, (country) ->
  id: country.id
  code: country.code
  name: country.name.toLowerCase().replace(/ /g, '_')
  title: country.name
  type: 'country'

filterData =
  "filters": [
    {"name": "topics_of_interest", "title": "Topics of Intrest", "filters": [
      {"name": "goverance_arrangements", "title": "Goverance arrangements", "filters": [
        {"name": "policy_authority", "title": "Policy authority", "count": 2095, "id": 1001, "applied": false, "filters": [
          {"name": "centralization_decentralization_of_policy_authority", "title": "Centralization/decentralization of policy authority", "id": 1002, "count": 1027, "applied": false },
          {"name": "accountability_of_the_state_sectors_role_in_financing_delivery", "title": "Accountability of the state sector's role in financing & delivery", "id": 1003, "count": 1027, "applied": false },
          {"name": "stewardship_of_the_non_state_sectors_role_in_financing_delivery", "title": "Stewardship of the non-state sector's role in financing & delivery", "id": 1004, "count": 1298, "applied": false }
        ]},
        {"name": "organizational_authority", "title": "Organizational authority", "filters": [
          {"name": "ownership", "title": "Ownership", "id": 1011, "count": 1027, "applied": false },
          {"name": "management_approaches", "title": "Management approaches", "id": 1012, "count": 524, "applied": false },
          {"name": "accreditation", "title": "Accreditation", "id": 1013, "count": 881, "applied": false }
        ]}
      ]},
      {"name": "financial_arrangements", "title": "Financial arrangements", "filters": [
        {"name": "policy_authority", "title": "Policy authority", "filters": [
          {"name": "centralization_decentralization_of_policy_authority", "title": "Centralization/decentralization of policy authority", "id": 1022, "count": 1027, "applied": false }
        ]}
      ]}
    ]},
    {"name": "domains", "title": "Domains", "filters": [
      {"name": "sectors", "title": "Sectors", "filters": [
        {"name": "all_of_them", "title": "All of them", "id": 1234, "count": 350, "applied": false },
        {"name": "option_a", "title": "Option A", "id": 1235, "count": 200, "applied": false },
        {"name": "option_b", "title": "Option B", "id": 1236, "count": 100, "applied": false },
        {"name": "governanace", "title": "Governance", "id": 1237, "count": 100, "applied": false },
        {"name": "human_studies", "title": "Human Studies", "id": 1238, "count": 135, "applied": false }
      ]},
      {"name": "providers", "title": "Providers", "filters": [
        {"name": "all_of_them", "title": "All of them", "id": 2011, "count": 350, "applied": false },
        {"name": "option_a", "title": "Option A", "id": 2012, "count": 200, "applied": false },
        {"name": "option_b", "title": "Option B", "id": 2013, "count": 100, "applied": false },
        {"name": "goverance", "title": "Governance", "id": 2014, "count": 100, "applied": false },
        {"name": "human_studies", "title": "Human Studies", "id": 2015, "count": 135, "applied": false }
      ]}
    ]},
    {"name": "areas_of_focus", "title": "Areas of Focus", "filters": [
      {"name": "countries", "title": "Countries", "id": 3044, "mode": "at_least_one", "filters": countryFilters }
    ]},
    {"name": "document_features", "title": "Document Features", "filters": [
      {"name": "date_range", "title": "Date range", "filters": [
        {"name": "date_range", "title": "Date range", "id": 400, "applied": false}
      ]}
    ]}
  ]
