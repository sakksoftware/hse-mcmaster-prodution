# like an API should come from a store
# TODO: 'or' and 'and' will also need to be translated
module.exports = [
  {
    text: "Do you want to know about particular types of health system arrangements?"
    filters: ["0_1"] # topics, not sure we need to apply this
    answers: [
      {
        text: "How decisions (about care) are made",
        filters: ["1_1"] # goveranance arranments
      }
      {
        text: "How care is paid for"
        filters: ["1_2"] # financial arrangements
      }
      {
        text: "How care is organized"
        filters: ["1_3"] # delivery arrangements
      }
      {
        text: "How change can be brought about"
        filters: ["1_4"] # implementation strategies
      }
    ]
  }
  {
    text: "Do you have a particular type of question?"
    filters: ["0_21"] # type of document
    answers: [
      {
        text: "What approaches have been evaluated for their benefits and harms? (or what approach works?)"
        filters: ["10_2", "10_3"] # systematic reviews of effects and overviews of reviews
      }
      {
        text: "What approaches have been evaluated for their cost-effectiveness? (or is an approach cost-effective?)"
        filters: ["10_7"] # economic evaluations and costing studies
      }
      {
        text: "What else do we know about an approach or the problem it addresses?"
        filters: ["10_4"] # systematic reviews addressing other question
      }
      {
        text: "What’s been tried elsewhere and the rationale documented? (and with what impacts)?"
        filters: ["10_8"] # health reform descriptions
      }
      {
        text: "What do we know about a problem, options and implementation considerations in a particular health system?"
        filters: ["10_1"] # evidence briefs for policy
      }
      {
        text: "How does a particular health system work?"
        filters: ["10_9"] # health system description
      }
    ]
  }
  {
    text: "Are you interested in particular diseases, technologies, sectors or providers?"
    filters: ["0_2"] # domains
    answers: [
      {
        text: "Diseases can include infectious diseases (%{infectious_diseases}), non-communicable diseases (%{non_communicable_diseases}) or other (%{other})"
        filters: [
          {
            name: "infectious_diseases"
            id: "2_5"
            filters: [
              {
                title: "HIV/AIDS"
                id: "2_22"
              }
              {
                title: "tuberculosis"
                id: "2_23"
              }
              {
                title: "malaria"
                id: "2_24"
              }
              {
                title: "diarrhoeal disease"
                id: "2_25"
              }
              {
                title: "lower respiratory infections"
                id: "2_26"
              }
            ]
          }
          {
            name: "non_communicable_diseases"
            id: "2_6"
            filters: [
              {
                id: "2_27"
                title: "cancer"
              }
              {
                id: "2_28"
                title: "cardiovascular disease"
              }
              {
                id: "2_29"
                title: "diabetes"
              }
              {
                id: "2_30"
                title: "Alzheimer and other dementias"
              }
              {
                id: "2_31"
                title: "or chronic obstructive pulmonary disease)"
              }
            ]
          }
          {
            name: "other"
            id: "2_7"
            filters: [
              {
                id: "2_32"
                title: "maternal and child health"
              }
              {
                id: "2_33"
                title: "accidents"
              }
              {
                id: "2_34"
                title: "or mental health and addictions"
              }
            ]
          }
        ]
      }
      {
        text: "Technologies can include %{technologies}"
        filters: [
          {
            id: "2_2"
            name: "technologies"
            filters: [
              {
                id: "2_8"
                title: "drugs"
              }
              # { # NO SUCH FILTER
              #   id: ""
              #   title: "vaccines"
              # }
              {
                id: "2_9"
                title: "devices"
              }
              {
                id: "2_10"
                title: "diagnostics"
              }
              {
                id: "2_11"
                title: "or surgery"
              }
            ]
          }
        ]
      }
      {
        text: "Sectors can include %{sectors}"
        filters: [
          {
            id: "2_3"
            name: "sectors"
            filters: [
              {
                id: "2_12"
                title: "primary care"
              }
              {
                id: "2_13"
                title: "home care"
              }
              {
                id: "2_14"
                title: "hospital care"
              }
              {
                id: "2_15"
                title: "rehabilitation"
              }
              {
                id: "2_16"
                title: "long-term care"
              }
              {
                id: "2_37"
                title: "public health"
              }
            ]
          }
        ]
      }
      {
        text: "Providers can include specialist %{providers}"
        filters: [
          id: "2_4"
          name: "providers"
          filters: [
            {
              id: "2_17"
              title: "physicians"
            }
            {
              id: "2_35"
              title: "generalist physicians"
            }
            {
              id: "2_18"
              title: "nurses"
            }
            {
              id: "2_19"
              title: "pharmacists"
            }
            {
              id: "2_20"
              title: "allied health professionals"
            }
            {
              id: "2_21"
              title: "lay/community health workers"
            }
          ]
        ]
      }
    ]
  }
  {
    text: "Are you focused on particular countries or on LMICs?"
    answers: [
      {
        id: "0_6"
        text: "Country focus"
        # filters: [
        #   {
        #     id: "9_1"
        #     title: "Target of document"
        #   }
        #   {
        #     id: ""
        #     title: "At least one study from the country included"
        #   }
        # ]
      }
      {
        id: "0_9"
        text: "Low- and middle-income country (LMIC) focus"
      }
    ]
  }
  # {
  #   id: ""
  #   text: "Do you want to see what international agencies like WHO and the World Bank have written on the topic? (and ‘Canadian governments and stakeholder organizations’ if in Canada, and ‘Ontario government and stakeholder organization if in Ontario)"
  # }
  # {
  #   id: ""
  #   text: "Are the results helpful, or is your query more about a clinical issue (e.g., does drug A work better than drug B?) or a public health issue (e.g., does one approach to obesity prevention work better than others?) than about a health system issue?"
  # }
]
