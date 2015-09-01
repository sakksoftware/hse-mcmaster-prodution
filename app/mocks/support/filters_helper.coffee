allCountries = require('constants/countries_list')

module.exports =
  getFilters: -> _.clone(filterData)

countryFilters = _.map allCountries, (country) ->
  id: "1_#{country.id}"
  code: country.code
  name: country.name.toLowerCase().replace(/ /g, '_')
  title: country.name
  type: 'country'

filterData = [
  {
    "applied": 0,
    "attributes": null,
    "count": 0,
    "filters": [
      {
        "applied": 0,
        "attributes": null,
        "count": 3328,
        "filters": [
          {
            "applied": 0,
            "attributes": null,
            "count": 2059,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 1017,
                "filters": null,
                "id": "1_22",
                "title": "Centralization/decentralization of policy authority",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 1270,
                "filters": null,
                "id": "1_23",
                "title": "Accountability of the state sector's role in financing & delivery",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 245,
                "filters": null,
                "id": "1_24",
                "title": "Stewardship of the non-state sector's role in financing & delivery",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 621,
                "filters": null,
                "id": "1_25",
                "title": "Decision-making authority about who is covered and what can or must be provided to them",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 57,
                "filters": null,
                "id": "1_26",
                "title": "Corruption protections",
                "type": ""
              }
            ],
            "id": "1_5",
            "title": "Policy authority",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 1703,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 416,
                "filters": null,
                "id": "1_27",
                "title": "Ownership",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 969,
                "filters": null,
                "id": "1_28",
                "title": "Management approaches",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 151,
                "filters": null,
                "id": "1_29",
                "title": "Accreditation",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 851,
                "filters": null,
                "id": "1_30",
                "title": "Networks/multi-institutional arrangements",
                "type": ""
              }
            ],
            "id": "1_6",
            "title": "Organizational authority",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 516,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 153,
                "filters": null,
                "id": "1_31",
                "title": "Licensure & registration requirements",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 78,
                "filters": null,
                "id": "1_32",
                "title": "Patents & profits",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 332,
                "filters": null,
                "id": "1_33",
                "title": "Pricing & purchasing",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 125,
                "filters": null,
                "id": "1_34",
                "title": "Marketing",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 169,
                "filters": null,
                "id": "1_35",
                "title": "Sales & dispensing",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 58,
                "filters": null,
                "id": "1_36",
                "title": "Commercial liability",
                "type": ""
              }
            ],
            "id": "1_7",
            "title": "Commercial authority",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 1264,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 610,
                "filters": null,
                "id": "1_37",
                "title": "Training & licensure requirements",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 587,
                "filters": null,
                "id": "1_38",
                "title": "Scope of practice",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 360,
                "filters": null,
                "id": "1_39",
                "title": "Setting of practice",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 308,
                "filters": null,
                "id": "1_40",
                "title": "Continuing competence",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 286,
                "filters": null,
                "id": "1_41",
                "title": "Quality & safety",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 239,
                "filters": null,
                "id": "1_42",
                "title": "Professional liability",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 1,
                "filters": null,
                "id": "1_132",
                "title": "Strike/job action\r\n",
                "type": ""
              }
            ],
            "id": "1_8",
            "title": "Professional authority",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 1098,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 398,
                "filters": null,
                "id": "1_43",
                "title": "Consumer participation in policy & organizational decisions",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 142,
                "filters": null,
                "id": "1_44",
                "title": "Consumer participation in system monitoring",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 192,
                "filters": null,
                "id": "1_45",
                "title": "Consumer participation in service delivery",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 102,
                "filters": null,
                "id": "1_46",
                "title": "Consumer complaints management",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 754,
                "filters": null,
                "id": "1_47",
                "title": "Stakeholder participation in policy & organizational decisions (or monitoring)",
                "type": ""
              }
            ],
            "id": "1_9",
            "title": "Consumer & stakeholder involvement",
            "type": ""
          }
        ],
        "id": "1_1",
        "title": "Governance arrangement",
        "type": ""
      },
      {
        "applied": 0,
        "attributes": null,
        "count": 2419,
        "filters": [
          {
            "applied": 0,
            "attributes": null,
            "count": 1093,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 468,
                "filters": null,
                "id": "1_48",
                "title": "Taxation",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 495,
                "filters": null,
                "id": "1_49",
                "title": "Social health insurance",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 34,
                "filters": null,
                "id": "1_50",
                "title": "Community-based health insurance",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 12,
                "filters": null,
                "id": "1_51",
                "title": "Community loan funds",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 336,
                "filters": null,
                "id": "1_52",
                "title": "Private insurance",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 53,
                "filters": null,
                "id": "1_53",
                "title": "Health savings accounts (Individually financed)",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 314,
                "filters": null,
                "id": "1_54",
                "title": "User fees",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 60,
                "filters": null,
                "id": "1_55",
                "title": "Donor contributions",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 1,
                "filters": null,
                "id": "1_131",
                "title": "Fundraising",
                "type": ""
              }
            ],
            "id": "1_10",
            "title": "Financing systems",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 522,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 110,
                "filters": null,
                "id": "1_56",
                "title": "Fee-for-service (Funding)",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 81,
                "filters": null,
                "id": "1_57",
                "title": "Capitation (Funding)",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 118,
                "filters": null,
                "id": "1_58",
                "title": "Global budget",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 92,
                "filters": null,
                "id": "1_59",
                "title": "Prospective payment (Funding)",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 9,
                "filters": null,
                "id": "1_60",
                "title": "Indicative budgets (Funding)",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 178,
                "filters": null,
                "id": "1_61",
                "title": "Targeted payments/penalties (Funding)",
                "type": ""
              }
            ],
            "id": "1_11",
            "title": "Funding organizations",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 873,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 278,
                "filters": null,
                "id": "1_62",
                "title": "Fee-for-service (Remuneration)",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 136,
                "filters": null,
                "id": "1_63",
                "title": "Capitation (Remuneration)",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 230,
                "filters": null,
                "id": "1_64",
                "title": "Salary",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 36,
                "filters": null,
                "id": "1_65",
                "title": "Prospective payment (Remuneration)",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 20,
                "filters": null,
                "id": "1_66",
                "title": "Fundholding",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 8,
                "filters": null,
                "id": "1_67",
                "title": "Indicative budgets (Remuneration)",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 557,
                "filters": null,
                "id": "1_68",
                "title": "Targeted payments/penalties (Remuneration)",
                "type": ""
              }
            ],
            "id": "1_12",
            "title": "Remunerating providers",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 842,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 515,
                "filters": null,
                "id": "1_69",
                "title": "Scope & nature of insurance plans",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 629,
                "filters": null,
                "id": "1_70",
                "title": "Lists of covered/reimbursed organizations, providers, services & products",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 140,
                "filters": null,
                "id": "1_71",
                "title": "Restrictions in coverage/reimbursement rates for organizations, providers, services & products",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 120,
                "filters": null,
                "id": "1_72",
                "title": "Caps on coverage/reimbursement for organizations, providers, services & products",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 43,
                "filters": null,
                "id": "1_73",
                "title": "Prior approval requirements for organizations, providers, services & products",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 100,
                "filters": null,
                "id": "1_74",
                "title": "Lists of substitutable services & products",
                "type": ""
              }
            ],
            "id": "1_13",
            "title": "Purchasing products & services",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 810,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 200,
                "filters": null,
                "id": "1_75",
                "title": "Premium (level & features)",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 395,
                "filters": null,
                "id": "1_76",
                "title": "Cost-sharing",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 33,
                "filters": null,
                "id": "1_77",
                "title": "Health savings accounts (Third party contributions)",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 407,
                "filters": null,
                "id": "1_78",
                "title": "Targeted payments/penalties (Incentivizing consumers)",
                "type": ""
              }
            ],
            "id": "1_14",
            "title": "Incentivizing consumers",
            "type": ""
          }
        ],
        "id": "1_2",
        "title": "Financial arrangement",
        "type": ""
      },
      {
        "applied": 0,
        "attributes": null,
        "count": 9646,
        "filters": [
          {
            "applied": 0,
            "attributes": null,
            "count": 5268,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 2101,
                "filters": null,
                "id": "1_79",
                "title": "Availability of care",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 1071,
                "filters": null,
                "id": "1_80",
                "title": "Timely access to care",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 1252,
                "filters": null,
                "id": "1_81",
                "title": "Culturally appropriate care",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 1010,
                "filters": null,
                "id": "1_82",
                "title": "Case management",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 2403,
                "filters": null,
                "id": "1_83",
                "title": "Package of care/care pathways/disease management",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 335,
                "filters": null,
                "id": "1_84",
                "title": "Group care",
                "type": ""
              }
            ],
            "id": "1_15",
            "title": "How care is designed to meet consumers' needs",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 5378,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 863,
                "filters": null,
                "id": "1_85",
                "title": "System - Need, demand & supply",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 703,
                "filters": null,
                "id": "1_86",
                "title": "System - Recruitment, retention & transitions",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 669,
                "filters": null,
                "id": "1_87",
                "title": "System - Performance management",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 376,
                "filters": null,
                "id": "1_88",
                "title": "Workplace conditions - Provider satisfaction",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 344,
                "filters": null,
                "id": "1_89",
                "title": "Workplace conditions - Health & safety",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 670,
                "filters": null,
                "id": "1_90",
                "title": "Skill mix - Role performance",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 548,
                "filters": null,
                "id": "1_91",
                "title": "Skill mix - Role expansion or extension",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 536,
                "filters": null,
                "id": "1_92",
                "title": "Skill mix - Task shifting / substitution",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 1386,
                "filters": null,
                "id": "1_93",
                "title": "Skill mix - Multidisciplinary teams",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 398,
                "filters": null,
                "id": "1_94",
                "title": "Skill mix - Volunteers or informal/family caregivers",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 363,
                "filters": null,
                "id": "1_95",
                "title": "Skill mix - Communication & case discussion between distant health professionals",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 1457,
                "filters": null,
                "id": "1_96",
                "title": "Staff - Training",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 415,
                "filters": null,
                "id": "1_97",
                "title": "Staff - Support",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 501,
                "filters": null,
                "id": "1_98",
                "title": "Staff - Workload/workflow/intensity",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 915,
                "filters": null,
                "id": "1_99",
                "title": "Staff - Continuity of care",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 345,
                "filters": null,
                "id": "1_100",
                "title": "Staff/self - Shared decision-making",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 1033,
                "filters": null,
                "id": "1_101",
                "title": "Self-management",
                "type": ""
              }
            ],
            "id": "1_16",
            "title": "By whom care is provided",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 3413,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 1695,
                "filters": null,
                "id": "1_102",
                "title": "Site of service delivery",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 643,
                "filters": null,
                "id": "1_103",
                "title": "Physical structure, facilities & equipment",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 255,
                "filters": null,
                "id": "1_104",
                "title": "Organizational scale",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 1031,
                "filters": null,
                "id": "1_105",
                "title": "Integration of services",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 985,
                "filters": null,
                "id": "1_106",
                "title": "Continuity of care",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 828,
                "filters": null,
                "id": "1_107",
                "title": "Outreach",
                "type": ""
              }
            ],
            "id": "1_17",
            "title": "Where care is provided",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 3600,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 197,
                "filters": null,
                "id": "1_108",
                "title": "Health record systems",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 608,
                "filters": null,
                "id": "1_109",
                "title": "Electronic health record",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 1640,
                "filters": null,
                "id": "1_110",
                "title": "Other ICT that support individuals who provide care",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 1923,
                "filters": null,
                "id": "1_111",
                "title": "ICT that support individuals who receive care",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 956,
                "filters": null,
                "id": "1_112",
                "title": "Quality monitoring and improvement systems",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 465,
                "filters": null,
                "id": "1_113",
                "title": "Safety monitoring and improvement systems",
                "type": ""
              }
            ],
            "id": "1_18",
            "title": "With what supports is care provided",
            "type": ""
          }
        ],
        "id": "1_3",
        "title": "Delivery arrangement",
        "type": ""
      },
      {
        "applied": 0,
        "attributes": null,
        "count": 5414,
        "filters": [
          {
            "applied": 0,
            "attributes": null,
            "count": 4167,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 3182,
                "filters": null,
                "id": "1_114",
                "title": "Information or education provision",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 1476,
                "filters": null,
                "id": "1_115",
                "title": "Behaviour change support",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 834,
                "filters": null,
                "id": "1_116",
                "title": "Skills and competencies development",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 1691,
                "filters": null,
                "id": "1_117",
                "title": "(Personal) Support",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 708,
                "filters": null,
                "id": "1_118",
                "title": "Communication and decision-making facilitation",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 221,
                "filters": null,
                "id": "1_119",
                "title": "System participation",
                "type": ""
              }
            ],
            "id": "1_19",
            "title": "Consumer-targeted strategy",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 2033,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 1245,
                "filters": null,
                "id": "1_120",
                "title": "Educational material",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 924,
                "filters": null,
                "id": "1_121",
                "title": "Educational meeting",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 216,
                "filters": null,
                "id": "1_122",
                "title": "Educational outreach visit",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 116,
                "filters": null,
                "id": "1_123",
                "title": "Local opinion leader",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 39,
                "filters": null,
                "id": "1_124",
                "title": "Local consensus process",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 54,
                "filters": null,
                "id": "1_125",
                "title": "Peer review",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 618,
                "filters": null,
                "id": "1_126",
                "title": "Audit and feedback",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 421,
                "filters": null,
                "id": "1_127",
                "title": "Reminders and prompts",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 51,
                "filters": null,
                "id": "1_128",
                "title": "Tailored intervention",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 76,
                "filters": null,
                "id": "1_129",
                "title": "Patient-mediated intervention",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 182,
                "filters": null,
                "id": "1_130",
                "title": "Multi-faceted intervention",
                "type": ""
              }
            ],
            "id": "1_20",
            "title": "Provider-targeted strategy",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 227,
            "filters": null,
            "id": "1_21",
            "title": "Organization-targeted strategy",
            "type": ""
          }
        ],
        "id": "1_4",
        "title": "Implementation strategy",
        "type": ""
      }
    ],
    "id": "0_1",
    "title": "Topics of interest",
    "type": ""
  },
  {
    "applied": 0,
    "attributes": null,
    "count": 0,
    "filters": [
      {
        "applied": 0,
        "attributes": null,
        "count": 6389,
        "filters": [
          {
            "applied": 0,
            "attributes": null,
            "count": 1415,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 586,
                "filters": null,
                "id": "2_22",
                "title": "HIV/AIDS",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 183,
                "filters": null,
                "id": "2_23",
                "title": "Tuberculosis",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 115,
                "filters": null,
                "id": "2_24",
                "title": "Malaria",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 64,
                "filters": null,
                "id": "2_25",
                "title": "Diarrhoeal disease",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 95,
                "filters": null,
                "id": "2_26",
                "title": "Lower respiratory infections",
                "type": ""
              }
            ],
            "id": "2_5",
            "title": "Infectious diseases",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 3186,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 1002,
                "filters": null,
                "id": "2_27",
                "title": "Cancer",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 1142,
                "filters": null,
                "id": "2_28",
                "title": "Cardiovascular disease",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 957,
                "filters": null,
                "id": "2_29",
                "title": "Diabetes",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 286,
                "filters": null,
                "id": "2_30",
                "title": "Alzheimer and other dementias",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 281,
                "filters": null,
                "id": "2_31",
                "title": "Chronic obstructive pulmonary disease",
                "type": ""
              }
            ],
            "id": "2_6",
            "title": "Non-communicable diseases",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 3134,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 1255,
                "filters": null,
                "id": "2_32",
                "title": "Maternal and child health",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 396,
                "filters": null,
                "id": "2_33",
                "title": "Accidents",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 1870,
                "filters": null,
                "id": "2_34",
                "title": "Mental health and addictions",
                "type": ""
              }
            ],
            "id": "2_7",
            "title": "Other",
            "type": ""
          }
        ],
        "id": "2_1",
        "title": "Diseases",
        "type": ""
      },
      {
        "applied": 0,
        "attributes": null,
        "count": 2917,
        "filters": [
          {
            "applied": 0,
            "attributes": null,
            "count": 1731,
            "filters": null,
            "id": "2_8",
            "title": "Drugs",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 326,
            "filters": null,
            "id": "2_9",
            "title": "Devices",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 826,
            "filters": null,
            "id": "2_10",
            "title": "Diagnostics",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 643,
            "filters": null,
            "id": "2_11",
            "title": "Surgery",
            "type": ""
          }
        ],
        "id": "2_2",
        "title": "Technologies",
        "type": ""
      },
      {
        "applied": 0,
        "attributes": null,
        "count": 6993,
        "filters": [
          {
            "applied": 0,
            "attributes": null,
            "count": 2651,
            "filters": null,
            "id": "2_12",
            "title": "Primary care",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 1391,
            "filters": null,
            "id": "2_13",
            "title": "Home care",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 2976,
            "filters": null,
            "id": "2_14",
            "title": "Hospital care",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 571,
            "filters": null,
            "id": "2_15",
            "title": "Rehabilitation",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 761,
            "filters": null,
            "id": "2_16",
            "title": "Long-term care",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 2124,
            "filters": null,
            "id": "2_37",
            "title": "Public health",
            "type": ""
          }
        ],
        "id": "2_3",
        "title": "Sectors",
        "type": ""
      },
      {
        "applied": 0,
        "attributes": null,
        "count": 5610,
        "filters": [
          {
            "applied": 0,
            "attributes": null,
            "count": 3491,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 1733,
                "filters": null,
                "id": "2_35",
                "title": "Generalist",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 1252,
                "filters": null,
                "id": "2_36",
                "title": "Specialist",
                "type": ""
              }
            ],
            "id": "2_17",
            "title": "Physician",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 2634,
            "filters": null,
            "id": "2_18",
            "title": "Nurse",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 727,
            "filters": null,
            "id": "2_19",
            "title": "Pharmacist",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 1691,
            "filters": null,
            "id": "2_20",
            "title": "Allied health professional",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 857,
            "filters": null,
            "id": "2_21",
            "title": "Lay/community health worker",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 4,
            "filters": null,
            "id": "2_38",
            "title": "Informal/family caregivers",
            "type": ""
          }
        ],
        "id": "2_4",
        "title": "Providers",
        "type": ""
      }
    ],
    "id": "0_2",
    "title": "Domains",
    "type": ""
  },
  {
    "applied": 0,
    "attributes": null,
    "count": 0,
    "filters": [
      {
        "applied": 0,
        "attributes": null,
        "count": 0,
        "filters": [
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_1",
            "title": "Afghanistan",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_2",
            "title": "Albania",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_3",
            "title": "Algeria",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_4",
            "title": "Andorra",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_5",
            "title": "Angola",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_6",
            "title": "Antigua and Barbuda",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_7",
            "title": "Argentina",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_8",
            "title": "Armenia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_9",
            "title": "Australia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_10",
            "title": "Austria",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_11",
            "title": "Azerbaijan",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_12",
            "title": "Bahamas",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_13",
            "title": "Bahrain",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_14",
            "title": "Bangladesh",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_15",
            "title": "Barbados",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_16",
            "title": "Belarus",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_17",
            "title": "Belgium",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_18",
            "title": "Belize",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_19",
            "title": "Benin",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_20",
            "title": "Bhutan",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_21",
            "title": "Bolivia (Plurinational State of)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_22",
            "title": "Bosnia and Herzegovina",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_23",
            "title": "Botswana",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_24",
            "title": "Brazil",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_25",
            "title": "Brunei Darussalam",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_26",
            "title": "Bulgaria",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_27",
            "title": "Burkina Faso",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_28",
            "title": "Burundi",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_29",
            "title": "Cambodia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_30",
            "title": "Cameroon",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_31",
            "title": "Canada",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_32",
            "title": "Cape Verde",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_33",
            "title": "Central African Republic",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_34",
            "title": "Chad",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_35",
            "title": "Chile",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_36",
            "title": "China",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_37",
            "title": "Colombia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_38",
            "title": "Comoros",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_39",
            "title": "Congo (Brazzaville)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_40",
            "title": "Costa Rica",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_41",
            "title": "Côte d'Ivoire",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_42",
            "title": "Croatia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_43",
            "title": "Cuba",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_44",
            "title": "Cyprus",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_45",
            "title": "Czech Republic",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_46",
            "title": "Korea (Democratic People's Republic of)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_47",
            "title": "Congo (Democratic Republic of)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_48",
            "title": "Denmark",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_49",
            "title": "Djibouti",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_50",
            "title": "Dominica",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_51",
            "title": "Dominican Republic",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_52",
            "title": "Ecuador",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_53",
            "title": "Egypt",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_54",
            "title": "El Salvador",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_55",
            "title": "Equatorial Guinea",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_56",
            "title": "Eritrea",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_57",
            "title": "Estonia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_58",
            "title": "Ethiopia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_59",
            "title": "Fiji",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_60",
            "title": "Finland",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_61",
            "title": "France",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_62",
            "title": "Gabon",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_63",
            "title": "Gambia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_64",
            "title": "Georgia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_65",
            "title": "Germany",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_66",
            "title": "Ghana",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_67",
            "title": "Greece",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_68",
            "title": "Grenada",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_69",
            "title": "Guatemala",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_70",
            "title": "Guinea",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_71",
            "title": "Guinea-Bissau",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_72",
            "title": "Guyana",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_73",
            "title": "Haiti",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_74",
            "title": "Honduras",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_75",
            "title": "Hungary",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_76",
            "title": "Iceland",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_77",
            "title": "India",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_78",
            "title": "Indonesia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_79",
            "title": "Iran (Islamic Republic of)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_80",
            "title": "Iraq",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_81",
            "title": "Ireland",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_82",
            "title": "Israel",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_83",
            "title": "Italy",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_84",
            "title": "Jamaica",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_85",
            "title": "Japan",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_86",
            "title": "Jordan",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_87",
            "title": "Kazakhstan",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_88",
            "title": "Kenya",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_89",
            "title": "Kiribati",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_90",
            "title": "Kuwait",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_91",
            "title": "Kyrgyzstan",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_92",
            "title": "Lao People's Democratic Republic",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_93",
            "title": "Latvia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_94",
            "title": "Lebanon",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_95",
            "title": "Lesotho",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_96",
            "title": "Liberia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_97",
            "title": "Libya",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_98",
            "title": "Liechtenstein",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_99",
            "title": "Lithuania",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_100",
            "title": "Luxembourg",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_101",
            "title": "Madagascar",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_102",
            "title": "Malawi",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_103",
            "title": "Malaysia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_104",
            "title": "Maldives",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_105",
            "title": "Mali",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_106",
            "title": "Malta",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_107",
            "title": "Marshall Islands",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_108",
            "title": "Mauritania",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_109",
            "title": "Mauritius",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_110",
            "title": "Mexico",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_111",
            "title": "Micronesia (Federated States of)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_112",
            "title": "Monaco",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_113",
            "title": "Mongolia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_114",
            "title": "Montenegro",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_115",
            "title": "Morocco",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_116",
            "title": "Mozambique",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_117",
            "title": "Myanmar",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_118",
            "title": "Namibia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_119",
            "title": "Nauru",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_120",
            "title": "Nepal",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_121",
            "title": "Netherlands",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_122",
            "title": "New Zealand",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_123",
            "title": "Nicaragua",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_124",
            "title": "Niger",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_125",
            "title": "Nigeria",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_126",
            "title": "Norway",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_127",
            "title": "Oman",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_128",
            "title": "Pakistan",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_129",
            "title": "Palau",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_130",
            "title": "Panama",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_131",
            "title": "Papua New Guinea",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_132",
            "title": "Paraguay",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_133",
            "title": "Peru",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_134",
            "title": "Philippines",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_135",
            "title": "Poland",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_136",
            "title": "Portugal",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_137",
            "title": "Qatar",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_138",
            "title": "Korea (Republic of)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_139",
            "title": "Moldova (Republic of)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_140",
            "title": "Romania",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_141",
            "title": "Russian Federation",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_142",
            "title": "Rwanda",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_143",
            "title": "Saint Kitts and Nevis",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_144",
            "title": "Saint Lucia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_145",
            "title": "Saint Vincent and the Grenadines",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_146",
            "title": "Samoa",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_147",
            "title": "San Marino",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_148",
            "title": "Sao Tome and Principe",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_149",
            "title": "Saudi Arabia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_150",
            "title": "Senegal",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_151",
            "title": "Serbia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_152",
            "title": "Seychelles",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_153",
            "title": "Sierra Leone",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_154",
            "title": "Singapore",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_155",
            "title": "Slovakia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_156",
            "title": "Slovenia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_157",
            "title": "Solomon Islands",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_158",
            "title": "Somalia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_159",
            "title": "South Africa",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_160",
            "title": "Spain",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_161",
            "title": "Sri Lanka",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_162",
            "title": "Sudan",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_163",
            "title": "Suriname",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_164",
            "title": "Swaziland",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_165",
            "title": "Switzerland",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_166",
            "title": "Sweden",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_167",
            "title": "Syrian Arab Republic",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_168",
            "title": "Tajikistan",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_169",
            "title": "Thailand",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_170",
            "title": "Macedonia (The former Yugoslav Republic of)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_171",
            "title": "Timor-Leste",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_172",
            "title": "Togo",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_173",
            "title": "Tonga",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_174",
            "title": "Trinidad and Tobago",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_175",
            "title": "Tunisia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_176",
            "title": "Turkey",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_177",
            "title": "Turkmenistan",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_178",
            "title": "Tuvalu",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_179",
            "title": "Uganda",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_180",
            "title": "Ukraine",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_181",
            "title": "United Arab Emirates",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_182",
            "title": "United Kingdom",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_183",
            "title": "Tanzania (United Republic of)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_184",
            "title": "United States",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_185",
            "title": "Uruguay",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_186",
            "title": "Uzbekistan",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_187",
            "title": "Vanuatu",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_188",
            "title": "Venezuela (Bolivarian Republic of)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_189",
            "title": "Viet Nam",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_190",
            "title": "Yemen",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_191",
            "title": "Zambia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_192",
            "title": "Zimbabwe",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_193",
            "title": "Bermuda",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_194",
            "title": "French Polynesia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_195",
            "title": "Hong Kong",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_196",
            "title": "Kosovo",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_197",
            "title": "Northern Mariana Islands",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_198",
            "title": "Palestine",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_199",
            "title": "Puerto Rico",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_200",
            "title": "Taiwan",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_201",
            "title": "United Kingdom (England)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_202",
            "title": "United Kingdom (Northern Ireland)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_203",
            "title": "United Kingdom (Scotland)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_204",
            "title": "United Kingdom (Wales)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_205",
            "title": "Yugoslavia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_207",
            "title": "Scandinavia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_208",
            "title": "Ireland & UK (Northern Ireland)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_209",
            "title": "Africa",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_210",
            "title": "Asia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_211",
            "title": "Europe",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_212",
            "title": "North America",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_213",
            "title": "South America",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_214",
            "title": "Latin America",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_215",
            "title": "Australasia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_216",
            "title": "Caribbean",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_217",
            "title": "Developed countries",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_218",
            "title": "Developing countries",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_219",
            "title": "Eastern Europe",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_220",
            "title": "Middle East",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_221",
            "title": "OECD countries",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_222",
            "title": "Sub-Saharan Africa",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_223",
            "title": "West Bank",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_225",
            "title": "Mostly from USA",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_226",
            "title": "Caribbean & Latin America",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_227",
            "title": "Austria, Germany & Switzerland",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_228",
            "title": "Canada & USA",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_229",
            "title": "Guinea & Kenya",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_231",
            "title": "Asia & Europe",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_232",
            "title": "Africa, Asia, Australia & Europe",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_233",
            "title": "Western countries",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_234",
            "title": "France, Italy, Spain & UK",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_235",
            "title": "South Africa & Zimbabwe",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_236",
            "title": "Australia or New Zealand",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_237",
            "title": "UK & USA",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_238",
            "title": "Spain & UK",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_239",
            "title": "Kenya & Tanzania",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_240",
            "title": "India, Paraguay, Tanzania & Uganda",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_241",
            "title": "Brazil & South Africa",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_242",
            "title": "Asia & Middle East",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_243",
            "title": "UK (England & Wales)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_245",
            "title": "Netherlands & UK",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_246",
            "title": "Ireland & UK",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_247",
            "title": "Low income countries",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_248",
            "title": "Asia, Australasia & Europe",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_249",
            "title": "Australia, New Zealand & Oceania",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_250",
            "title": "Africa, Asia & Middle East",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_251",
            "title": "Central America, Mexico & South America",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_252",
            "title": "Montserrat",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_253",
            "title": "Anguilla",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_254",
            "title": "American Samoa",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_255",
            "title": "Cook Islands",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_256",
            "title": "Guam",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_257",
            "title": "Macao",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_258",
            "title": "New Caledonia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_259",
            "title": "Niue",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_260",
            "title": "Commonwealth Of Northern Mariana Islands",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_261",
            "title": "Pitcairn Islands",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_262",
            "title": "Tokelau",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_263",
            "title": "Wallis and Futuna",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_264",
            "title": "Other",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_265",
            "title": "Global",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "6_266",
            "title": "South Sudan",
            "type": ""
          }
        ],
        "id": "0_6",
        "title": "Countries",
        "type": "countries_countries"
      },
      {
        "applied": 0,
        "attributes": null,
        "count": 0,
        "filters": [
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_162",
            "title": "Sudan",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_201",
            "title": "United Kingdom (England)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_202",
            "title": "United Kingdom (Northern Ireland)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_203",
            "title": "United Kingdom (Scotland)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_204",
            "title": "United Kingdom (Wales)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_207",
            "title": "Scandinavia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_208",
            "title": "Ireland & UK (Northern Ireland)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_209",
            "title": "Africa",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_210",
            "title": "Asia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_212",
            "title": "North America",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_213",
            "title": "South America",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_214",
            "title": "Latin America",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_215",
            "title": "Australasia",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_216",
            "title": "Caribbean",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_219",
            "title": "Eastern Europe",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_221",
            "title": "OECD countries",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_222",
            "title": "Sub-Saharan Africa",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_225",
            "title": "Mostly from USA",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_226",
            "title": "Caribbean & Latin America",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_227",
            "title": "Austria, Germany & Switzerland",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_228",
            "title": "Canada & USA",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_229",
            "title": "Guinea & Kenya",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_231",
            "title": "Asia & Europe",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_234",
            "title": "France, Italy, Spain & UK",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_235",
            "title": "South Africa & Zimbabwe",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_236",
            "title": "Australia or New Zealand",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_237",
            "title": "UK & USA",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_238",
            "title": "Spain & UK",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_239",
            "title": "Kenya & Tanzania",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_240",
            "title": "India, Paraguay, Tanzania & Uganda",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_241",
            "title": "Brazil & South Africa",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_242",
            "title": "Asia & Middle East",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_243",
            "title": "UK (England & Wales)",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_245",
            "title": "Netherlands & UK",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_246",
            "title": "Ireland & UK",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_248",
            "title": "Asia, Australasia & Europe",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_249",
            "title": "Australia, New Zealand & Oceania",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_250",
            "title": "Africa, Asia & Middle East",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "7_251",
            "title": "Central America, Mexico & South America",
            "type": ""
          }
        ],
        "id": "0_7",
        "title": "Country groupings",
        "type": "countries_country_groupings"
      },
      {
        "applied": 0,
        "attributes": null,
        "count": 0,
        "filters": [
          {
            "applied": 0,
            "attributes": null,
            "count": 99,
            "filters": null,
            "id": "8_1",
            "title": "WHO - African region",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 5,
            "filters": null,
            "id": "8_2",
            "title": "WHO - Americas region",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 8,
            "filters": null,
            "id": "8_4",
            "title": "WHO - Eastern Mediterranean region",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 15,
            "filters": null,
            "id": "8_8",
            "title": "WHO - South East Asia region",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 6,
            "filters": null,
            "id": "8_16",
            "title": "WHO - Western Pacific region",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 139,
            "filters": null,
            "id": "8_32",
            "title": "WHO - European region",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 271,
            "filters": null,
            "id": "8_64",
            "title": "Global",
            "type": ""
          }
        ],
        "id": "0_8",
        "title": "WHO regions",
        "type": "countries_who_regions"
      },
      {
        "applied": 0,
        "attributes": null,
        "count": 0,
        "filters": [
          {
            "applied": 0,
            "attributes": null,
            "count": 1192,
            "filters": null,
            "id": "9_1",
            "title": "Target of document",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 591,
            "filters": null,
            "id": "9_2",
            "title": "At least one LMIC author",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 1262,
            "filters": null,
            "id": "9_3",
            "title": "At least one LMIC study included",
            "type": ""
          }
        ],
        "id": "0_9",
        "title": "LMICs",
        "type": "countries_lmics"
      }
    ],
    "id": "0_3",
    "title": "Area of focus",
    "type": ""
  },
  {
    "applied": 0,
    "attributes": null,
    "count": 0,
    "filters": [
      {
        "applied": 0,
        "attributes": null,
        "count": 0,
        "filters": [
          {
            "applied": 0,
            "attributes": null,
            "count": 136,
            "filters": null,
            "id": "10_1",
            "title": "Evidence briefs for policy",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 65,
            "filters": null,
            "id": "10_2",
            "title": "Overviews of systematic reviews",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 3464,
            "filters": null,
            "id": "10_3",
            "title": "Systematic reviews of effects",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 913,
            "filters": null,
            "id": "10_4",
            "title": "Systematic reviews addressing other questions ",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 619,
            "filters": null,
            "id": "10_5",
            "title": "Systematic reviews in progress",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 223,
            "filters": null,
            "id": "10_6",
            "title": "Systematic reviews being planned",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 2253,
            "filters": null,
            "id": "10_7",
            "title": "Economic evaluations and costing studies\r\n",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 1111,
            "filters": null,
            "id": "10_8",
            "title": "Health reform descriptions",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 234,
            "filters": null,
            "id": "10_9",
            "title": "Health system descriptions",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 1282,
            "filters": null,
            "id": "10_10",
            "title": "Canadian healthcare renewal documents",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 527,
            "filters": null,
            "id": "10_11",
            "title": "Intergovernmental organization documents\r\n",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 585,
            "filters": null,
            "id": "10_12",
            "title": "Ontario health system documents",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "10_13",
            "title": "Systematic reviews and other types of syntheses",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": null,
            "id": "10_14",
            "title": "Canada health system documents",
            "type": ""
          }
        ],
        "id": "0_10",
        "title": "Type",
        "type": ""
      },
      {
        "applied": 0,
        "attributes": null,
        "count": 0,
        "filters": null,
        "id": "0_11",
        "title": "Free full-text",
        "type": ""
      },
      {
        "applied": 0,
        "attributes": null,
        "count": 0,
        "filters": null,
        "id": "0_12",
        "title": "Date range",
        "type": "date_range"
      },
      {
        "applied": 0,
        "attributes": null,
        "count": 0,
        "filters": null,
        "id": "0_13",
        "title": "Focus",
        "type": ""
      },
      {
        "applied": 0,
        "attributes": null,
        "count": 0,
        "filters": [
          {
            "applied": 0,
            "attributes": null,
            "count": 2589,
            "filters": null,
            "id": "14_1",
            "title": "Individual",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 1152,
            "filters": null,
            "id": "14_2",
            "title": "Community",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 6734,
            "filters": null,
            "id": "14_3",
            "title": "Health system",
            "type": ""
          }
        ],
        "id": "0_14",
        "title": "Target",
        "type": ""
      },
      {
        "applied": 0,
        "attributes": null,
        "count": 0,
        "filters": [
          {
            "applied": 0,
            "attributes": null,
            "count": 2774,
            "filters": null,
            "id": "15_1",
            "title": "Optimal aging",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 2113,
            "filters": null,
            "id": "15_2",
            "title": "Health promotion/primary prevention",
            "type": ""
          }
        ],
        "id": "0_15",
        "title": "Theme",
        "type": ""
      },
      {
        "applied": 0,
        "attributes": null,
        "count": 0,
        "filters": null,
        "id": "0_16",
        "title": "Producer",
        "type": ""
      }
    ],
    "id": "0_4",
    "title": "Document features",
    "type": ""
  },
  {
    "applied": 0,
    "attributes": null,
    "count": 0,
    "filters": [
      {
        "applied": 0,
        "attributes": null,
        "count": 0,
        "filters": [
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 99,
                "filters": null,
                "id": "20_1",
                "title": "WHO - African region",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 5,
                "filters": null,
                "id": "20_2",
                "title": "WHO - Americas region",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 8,
                "filters": null,
                "id": "20_4",
                "title": "WHO - Eastern Mediterranean region",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 15,
                "filters": null,
                "id": "20_8",
                "title": "WHO - South East Asia region",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 6,
                "filters": null,
                "id": "20_16",
                "title": "WHO - Western Pacific region",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 139,
                "filters": null,
                "id": "20_32",
                "title": "WHO - European region",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 271,
                "filters": null,
                "id": "20_64",
                "title": "Global",
                "type": ""
              }
            ],
            "id": "0_20",
            "title": "Global/regional focus",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 8,
                "filters": null,
                "id": "21_25",
                "title": "Health and health system data",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 0,
                "filters": null,
                "id": "21_26",
                "title": "Health expenditure review",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 1,
                "filters": null,
                "id": "21_27",
                "title": "Health system research priorities",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 88,
                "filters": null,
                "id": "21_28",
                "title": "Situation analysis",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 27,
                "filters": null,
                "id": "21_29",
                "title": "Jurisdictional review",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 23,
                "filters": null,
                "id": "21_30",
                "title": "Performance review",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 14,
                "filters": null,
                "id": "21_31",
                "title": "External evaluation",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 13,
                "filters": null,
                "id": "21_32",
                "title": "Literature review",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 33,
                "filters": null,
                "id": "21_33",
                "title": "Framework",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 27,
                "filters": null,
                "id": "21_34",
                "title": "Toolkit",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 9,
                "filters": null,
                "id": "21_35",
                "title": "Options framing",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 33,
                "filters": null,
                "id": "21_36",
                "title": "Guidance",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 7,
                "filters": null,
                "id": "21_37",
                "title": "Citizen/patient input",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 10,
                "filters": null,
                "id": "21_38",
                "title": "Stakeholder input",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 96,
                "filters": null,
                "id": "21_39",
                "title": "WHO discussion paper",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 85,
                "filters": null,
                "id": "21_40",
                "title": "WHO position paper",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 87,
                "filters": null,
                "id": "21_41",
                "title": "WHO strategic plan",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 4,
                "filters": null,
                "id": "21_42",
                "title": "WHO policy",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 95,
                "filters": null,
                "id": "21_43",
                "title": "World Health Assembly resolution",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 0,
                "filters": null,
                "id": "21_44",
                "title": "Inter-agency communiqué",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 0,
                "filters": null,
                "id": "21_45",
                "title": "Inter-agency accord",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 0,
                "filters": null,
                "id": "21_46",
                "title": "WHO/third party accord",
                "type": ""
              }
            ],
            "id": "0_21",
            "title": "Type of document",
            "type": ""
          }
        ],
        "id": "0_17",
        "title": "INTERGOVERNMENTAL ORGANIATIONS' HEALTH SYSTEMS DOCUMENTS",
        "type": "complementary_1"
      },
      {
        "applied": 0,
        "attributes": null,
        "count": 0,
        "filters": [
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 846,
                "filters": null,
                "id": "22_1",
                "title": "National priority funding area",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 1089,
                "filters": null,
                "id": "22_2",
                "title": "Other priority area",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 987,
                "filters": null,
                "id": "22_3",
                "title": "Performance indicator",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 1266,
                "filters": null,
                "id": "22_4",
                "title": "Priority research themes - Listening for Direction III",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 468,
                "filters": null,
                "id": "22_5",
                "title": "Primary healthcare",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 316,
                "filters": null,
                "id": "22_6",
                "title": "Home care",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 162,
                "filters": null,
                "id": "22_7",
                "title": "Prescription drug coverage",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 178,
                "filters": null,
                "id": "22_8",
                "title": "Diagnostic/medical equipment",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 470,
                "filters": null,
                "id": "22_9",
                "title": "Information technology",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 259,
                "filters": null,
                "id": "22_10",
                "title": "Electronic health record",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 297,
                "filters": null,
                "id": "22_11",
                "title": "Patient safety",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 944,
                "filters": null,
                "id": "22_12",
                "title": "Health human resources",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 28,
                "filters": null,
                "id": "22_13",
                "title": "Technology assessment",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 308,
                "filters": null,
                "id": "22_14",
                "title": "Innovation & research",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 360,
                "filters": null,
                "id": "22_15",
                "title": "Healthy Canadians / determinants of health",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 476,
                "filters": null,
                "id": "22_16",
                "title": "Timely access / waiting lists",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 605,
                "filters": null,
                "id": "22_17",
                "title": "Quality",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 386,
                "filters": null,
                "id": "22_18",
                "title": "Sustainability",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 379,
                "filters": null,
                "id": "22_19",
                "title": "Health status & wellness",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 941,
                "filters": null,
                "id": "22_20",
                "title": "Workforce & the work environment",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 164,
                "filters": null,
                "id": "22_21",
                "title": "Change management for improved practice & improved health",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 468,
                "filters": null,
                "id": "22_22",
                "title": "Data/information/knowledge management",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 475,
                "filters": null,
                "id": "22_23",
                "title": "Values-based decision-making & public engagement",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 390,
                "filters": null,
                "id": "22_24",
                "title": "Patient-centred care",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 750,
                "filters": null,
                "id": "22_25",
                "title": "Patient flow & system integration",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 474,
                "filters": null,
                "id": "22_26",
                "title": "Chronic disease prevention & management",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 607,
                "filters": null,
                "id": "22_27",
                "title": "Health system financing & sustainability",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 78,
                "filters": null,
                "id": "22_28",
                "title": "Emerging technologies & drugs",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 1039,
                "filters": null,
                "id": "22_29",
                "title": "Quality & patient safety",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 270,
                "filters": null,
                "id": "22_30",
                "title": "Linking population & public health to health services",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 232,
                "filters": null,
                "id": "22_31",
                "title": "Aboriginal health",
                "type": ""
              }
            ],
            "id": "0_22",
            "title": "Priority area",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 248,
                "filters": null,
                "id": "23_1",
                "title": "Health and health system data",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 11,
                "filters": null,
                "id": "23_2",
                "title": "Health expenditure review",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 3,
                "filters": null,
                "id": "23_3",
                "title": "National health account",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 8,
                "filters": null,
                "id": "23_4",
                "title": "Health system research priorities",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 439,
                "filters": null,
                "id": "23_5",
                "title": "Situation analysis",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 148,
                "filters": null,
                "id": "23_6",
                "title": "Jurisdictional review",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 102,
                "filters": null,
                "id": "23_7",
                "title": "Performance review",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 43,
                "filters": null,
                "id": "23_8",
                "title": "External evaluation",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 121,
                "filters": null,
                "id": "23_9",
                "title": "Literature review",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 32,
                "filters": null,
                "id": "23_10",
                "title": "Framework",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 21,
                "filters": null,
                "id": "23_11",
                "title": "Toolkit",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 81,
                "filters": null,
                "id": "23_12",
                "title": "Options framing",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 35,
                "filters": null,
                "id": "23_13",
                "title": "Guidance",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 122,
                "filters": null,
                "id": "23_14",
                "title": "Citizen/patient input",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 174,
                "filters": null,
                "id": "23_15",
                "title": "Stakeholder input",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 118,
                "filters": null,
                "id": "23_16",
                "title": "Stakeholder position paper",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 27,
                "filters": null,
                "id": "23_17",
                "title": "Government discussion paper",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 47,
                "filters": null,
                "id": "23_18",
                "title": "Government position paper",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 50,
                "filters": null,
                "id": "23_19",
                "title": "Government strategic plan for the health sector",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 19,
                "filters": null,
                "id": "23_20",
                "title": "Government policy",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 2,
                "filters": null,
                "id": "23_21",
                "title": "Government legislation",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 6,
                "filters": null,
                "id": "23_22",
                "title": "Intergovernmental communiqué  ",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 3,
                "filters": null,
                "id": "23_23",
                "title": "Intergovernmental accord",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 0,
                "filters": null,
                "id": "23_24",
                "title": "Government/third party accord",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 30,
                "filters": null,
                "id": "23_47",
                "title": "Political party platform",
                "type": ""
              }
            ],
            "id": "0_23",
            "title": "Type of document",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 0,
                "filters": null,
                "id": "24_1",
                "title": "Federal/national",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 0,
                "filters": null,
                "id": "24_2",
                "title": "Alberta",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 0,
                "filters": null,
                "id": "24_3",
                "title": "British Columbia",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 0,
                "filters": null,
                "id": "24_4",
                "title": "Manitoba",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 0,
                "filters": null,
                "id": "24_5",
                "title": "New Brunswick",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 0,
                "filters": null,
                "id": "24_6",
                "title": "Newfoundland and Labrador",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 0,
                "filters": null,
                "id": "24_7",
                "title": "Northwest Territories",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 0,
                "filters": null,
                "id": "24_8",
                "title": "Nova Scotia",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 0,
                "filters": null,
                "id": "24_9",
                "title": "Nunavut",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 0,
                "filters": null,
                "id": "24_10",
                "title": "Ontario",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 0,
                "filters": null,
                "id": "24_11",
                "title": "Prince Edward Island",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 0,
                "filters": null,
                "id": "24_12",
                "title": "Quebec",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 0,
                "filters": null,
                "id": "24_13",
                "title": "Saskatchewan",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 0,
                "filters": null,
                "id": "24_14",
                "title": "Yukon",
                "type": ""
              }
            ],
            "id": "0_24",
            "title": "Jurisdiction",
            "type": ""
          }
        ],
        "id": "0_18",
        "title": "CANADA'S HEALTH SYSTEMS DOCUMENTS",
        "type": "complementary_2"
      },
      {
        "applied": 0,
        "attributes": null,
        "count": 0,
        "filters": [
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 342,
                "filters": null,
                "id": "25_1",
                "title": "Community-based care",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 202,
                "filters": null,
                "id": "25_2",
                "title": "Health system performance and sustainability",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 174,
                "filters": null,
                "id": "25_3",
                "title": "Healthy living, with a focus on tobacco control",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 119,
                "filters": null,
                "id": "25_4",
                "title": "Mental health and addictions",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 237,
                "filters": null,
                "id": "25_5",
                "title": "Nursing research",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 233,
                "filters": null,
                "id": "25_6",
                "title": "Primary care reform",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 368,
                "filters": null,
                "id": "25_7",
                "title": "Quality improvement and safety",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 142,
                "filters": null,
                "id": "25_8",
                "title": "Seniors’ care",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 185,
                "filters": null,
                "id": "25_9",
                "title": "Vulnerable and special health needs populations",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 67,
                "filters": null,
                "id": "25_10",
                "title": "Women’s health",
                "type": ""
              }
            ],
            "id": "0_25",
            "title": "Ontario Priority area",
            "type": ""
          },
          {
            "applied": 0,
            "attributes": null,
            "count": 0,
            "filters": [
              {
                "applied": 0,
                "attributes": null,
                "count": 91,
                "filters": null,
                "id": "26_48",
                "title": "Health and health system data",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 9,
                "filters": null,
                "id": "26_49",
                "title": "Health expenditure review",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 4,
                "filters": null,
                "id": "26_50",
                "title": "Provincial health account",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 3,
                "filters": null,
                "id": "26_51",
                "title": "Health system research priorities",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 157,
                "filters": null,
                "id": "26_52",
                "title": "Situation analysis",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 24,
                "filters": null,
                "id": "26_53",
                "title": "Jurisdictional review",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 33,
                "filters": null,
                "id": "26_54",
                "title": "Performance review",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 31,
                "filters": null,
                "id": "26_55",
                "title": "External evaluation",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 119,
                "filters": null,
                "id": "26_56",
                "title": "Literature review",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 21,
                "filters": null,
                "id": "26_57",
                "title": "Framework",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 20,
                "filters": null,
                "id": "26_58",
                "title": "Toolkit",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 54,
                "filters": null,
                "id": "26_59",
                "title": "Options framing",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 16,
                "filters": null,
                "id": "26_60",
                "title": "Guidance",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 41,
                "filters": null,
                "id": "26_61",
                "title": "Citizen/patient input",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 119,
                "filters": null,
                "id": "26_62",
                "title": "Stakeholder input",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 134,
                "filters": null,
                "id": "26_63",
                "title": "Stakeholder position paper",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 9,
                "filters": null,
                "id": "26_64",
                "title": "Government discussion paper",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 24,
                "filters": null,
                "id": "26_65",
                "title": "Government position paper",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 19,
                "filters": null,
                "id": "26_66",
                "title": "Government strategic plan for the health sector",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 11,
                "filters": null,
                "id": "26_67",
                "title": "Government policy",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 3,
                "filters": null,
                "id": "26_68",
                "title": "Government legislation",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 0,
                "filters": null,
                "id": "26_69",
                "title": "Intergovernmental communiqué  ",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 0,
                "filters": null,
                "id": "26_70",
                "title": "Intergovernmental accord",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 0,
                "filters": null,
                "id": "26_71",
                "title": "Government/third party accord",
                "type": ""
              },
              {
                "applied": 0,
                "attributes": null,
                "count": 5,
                "filters": null,
                "id": "26_72",
                "title": "Political party platform",
                "type": ""
              }
            ],
            "id": "0_26",
            "title": "Type of document",
            "type": ""
          }
        ],
        "id": "0_19",
        "title": "ONTARIO'S HEALTH SYSTEMS DOCUMENTS",
        "type": "complementary_3"
      }
    ],
    "id": "0_5",
    "title": "COMPLEMENTARY CONTENT",
    "type": ""
  }
]
