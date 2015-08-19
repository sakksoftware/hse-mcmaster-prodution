allCountries = require('constants/countries_list')

module.exports =
  getFilters: ->
    filters = _.clone(filterData.filters)

countryFilters = _.map allCountries, (country) ->
  id: "1_#{country.id}"
  code: country.code
  name: country.name.toLowerCase().replace(/ /g, '_')
  title: country.name
  type: 'country'

filterData =
  "filters": [
    {"type": "topics_of_interest", "title": "Topics of Intrest", "filters": [
      {"type": "goverance_arrangements", "title": "Goverance arrangements", "filters": [
        {"type": "policy_authority", "title": "Policy authority", "count": 2095, "id": "1_1001", "applied": false, "filters": [
          {"type": "centralization_decentralization_of_policy_authority", "title": "Centralization/decentralization of policy authority", "id": "1_1002", "count": 1027, "applied": false },
          {"type": "accountability_of_the_state_sectors_role_in_financing_delivery", "title": "Accountability of the state sector's role in financing & delivery", "id": "1_1003", "count": 1027, "applied": false },
          {"type": "stewardship_of_the_non_state_sectors_role_in_financing_delivery", "title": "Stewardship of the non-state sector's role in financing & delivery", "id": "1_1004", "count": 1298, "applied": false }
        ]},
        {"type": "organizational_authority", "title": "Organizational authority", "filters": [
          {"type": "ownership", "title": "Ownership", "id": "1_1011", "count": 1027, "applied": false },
          {"type": "management_approaches", "title": "Management approaches", "id": "1_1012", "count": 524, "applied": false },
          {"type": "accreditation", "title": "Accreditation", "id": "1_1013", "count": 881, "applied": false }
        ]}
      ]},
      {"type": "financial_arrangements", "title": "Financial arrangements", "filters": [
        {"type": "policy_authority", "title": "Policy authority", "filters": [
          {"type": "centralization_decentralization_of_policy_authority", "title": "Centralization/decentralization of policy authority", "id": "1_1022", "count": 1027, "applied": false }
        ]}
      ]}
    ]},
    {"type": "domains", "title": "Domains", "filters": [
      {"type": "sectors", "title": "Sectors", "filters": [
        {"type": "all_of_them", "title": "All of them", "id": "1_1234", "count": 350, "applied": false },
        {"type": "option_a", "title": "Option A", "id": "1_1235", "count": 200, "applied": false },
        {"type": "option_b", "title": "Option B", "id": "1_1236", "count": 100, "applied": false },
        {"type": "governanace", "title": "Governance", "id": "1_1237", "count": 100, "applied": false },
        {"type": "human_studies", "title": "Human Studies", "id": "1_1238", "count": 135, "applied": false }
      ]},
      {"type": "providers", "title": "Providers", "filters": [
        {"type": "all_of_them", "title": "All of them", "id": "1_2011", "count": 350, "applied": false },
        {"type": "option_a", "title": "Option A", "id": "1_2012", "count": 200, "applied": false },
        {"type": "option_b", "title": "Option B", "id": "1_2013", "count": 100, "applied": false },
        {"type": "goverance", "title": "Governance", "id": "1_2014", "count": 100, "applied": false },
        {"type": "human_studies", "title": "Human Studies", "id": "1_2015", "count": 135, "applied": false }
      ]}
    ]},
    {"type": "areas_of_focus", "title": "Areas of Focus", "filters": [
      {"type": "countries", "title": "Countries", "id": "1_3044", "mode": "at_least_one", "filters": countryFilters }
    ]},
    {"type": "document_features", "title": "Document Features", "filters": [
      {"type": "date_range", "title": "Date range", "id": "1_3045", "start": null, "end": null, "applied": false }
    ]},
    {"title": "Complamentary Content", "filters": [
      {"type": "complamentary-1", "title": "Intergovermental Organizations' System Health Documents", "id": "1_3046", "applied": false, "filters": [
        {"type": "option_a", "title": "Option A", "id": "1_2112", "count": 200, "applied": false },
        {"type": "option_b", "title": "Option B", "id": "1_2113", "count": 100, "applied": false }
      ]},
      {"type": "complamentary-2", "title": "Canada's Health System Documents", "id": "1_3047", "applied": false , "filters": [
        {"type": "option_a", "title": "Option A", "id": "1_2212", "count": 200, "applied": false },
        {"type": "option_b", "title": "Option B", "id": "1_2213", "count": 100, "applied": false }
      ]},
      {"type": "complamentary-3", "title": "Ontario's Health System Documents", "id": "1_3048", "applied": false , "filters": [
        {"type": "option_a", "title": "Option A", "id": "1_2312", "count": 200, "applied": false },
        {"type": "option_b", "title": "Option B", "id": "1_2313", "count": 100, "applied": false }
      ]}
    ]}
  ]
