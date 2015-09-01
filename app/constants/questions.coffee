# like an API should come from a store
# TODO: 'or' and 'and' will also need to be translated
module.exports = [
  {
    text: "Do you want to know about particular types of health system arrangements?"
    filters: [id: "0_1", title: "topics"] # topics, not sure we need to apply this
    answers: [
      {
        text: "How decisions (about care) are made",
        filterGroup:
          id: "1_1"
          title: "goveranance arranments"
      }
      {
        text: "How care is paid for"
        filterGroup:
          id: "1_2"
          title: "financial arrangements"
      }
      {
        text: "How care is organized"
        filterGroup:
          id: "1_3"
          title: "delivery arrangements"
      }
      {
        text: "How change can be brought about"
        filterGroup:
          id: "1_4"
          title: "implementation strategies"
      }
    ]
  }
  {
    text: "Do you have a particular type of question?"
    filters: [id: "0_21", title: "type of document"]
    answers: [
      {
        text: "What approaches have been evaluated for their benefits and harms? (or what approach works?)"
        filterGroup:
          id: "0_10"
          title: "systematic reviews of effects and overviews of reviews"
        filters: [
          {id: "10_2", title: "systematic reviews of effects"}
          {id: "10_3", title: "overviews of reviews"}
        ]
      }
      {
        text: "What approaches have been evaluated for their cost-effectiveness? (or is an approach cost-effective?)"
        filterGroup:
          id: "0_10"
          title: "economic evaluations and costing studies"
        filters: [id: "10_7", title: "economic evaluations and costing studies"]
      }
      {
        text: "What else do we know about an approach or the problem it addresses?"
        filterGroup:
          id: "0_10"
          title: "systematic reviews addressing other question"
        filters: [id: "10_4", title: "systematic reviews addressing other question"]
      }
      {
        text: "What’s been tried elsewhere and the rationale documented? (and with what impacts)?"
        filterGroup:
          id: "0_10"
          title: "health reform descriptions"
        filters: [id: "10_8", title: "health reform descriptions"]
      }
      {
        text: "What do we know about a problem, options and implementation considerations in a particular health system?"
        filterGroup:
          id: "0_10"
          title: "evidence briefs for policy"
        filters: [id: "10_1", title: "evidence briefs for policy"]
      }
      {
        text: "How does a particular health system work?"
        filterGroup:
          id: "0_10"
          title: "health system description"
        filters: [id: "10_9", title: "health system description"]
      }
    ]
  }
  {
    text: "Are you interested in particular diseases, technologies, sectors or providers?"
    filters: ["0_2"] # domains
    answers: [
      {
        text: "Diseases can include infectious diseases (HIV/AIDS, tuberculosis, malaria, diarrhoeal disease and lower respiratory infections), non-communicable diseases (cancer, cardiovascular disease, diabetes, alzheimer and other dementias and chronic obstructive pulmonary disease) or other (maternal and child health, accidents, mental health and addictions)"
        filterGroup:
          id: "2_1"
          title: "diseases"
      }
      {
        text: "Technologies can include drugs, devices, diagnostics, surgery"
        filterGroup:
          id: "2_2"
          title: "technologies"
      }
      {
        text: "Sectors can include primary care, home care, hospital care, rehabilitation, long-term care and public health"
        filterGroup:
          id: "2_3"
          title: "sectors"
      }
      {
        text: "Providers can include specialist generalist physicians, specialist physicians, nurses, pharmacists, allied health professionals, lay/community health workers, informal/family caregivers"
        filterGroup:
          id: "2_4"
          title: "providers"
      }
    ]
  }
  {
    text: "Are you focused on particular countries or on LMICs?"
    answers: [
      {
        text: "Country focus"
        filterGroup:
          id: "0_6"
          title: "country focus"
          type: "countries_countries"
      }
      {
        text: "Low- and middle-income country (LMIC) focus"
        filterGroup:
          id: "0_9"
          title: "LMIC focus"
      }
    ]
  }
  {
    filters: ["0_5"] # complementary content
    text: "Do you want to see what international agencies like WHO and the World Bank have written on the topic? (and ‘Canadian governments and stakeholder organizations’ if in Canada, and ‘Ontario government and stakeholder organization if in Ontario)"
    answers: [
      {
        text: "Intergovernmental Organiations' Health Systems Documents"
        filterGroup:
          id: "0_17"
          title: "intergovernmental documents"
      }
      {
        text: "Canada's Health Systems Documents"
        filterGroup:
          id: "0_18"
          title: "canadian documents"
      }
      {
        text: "Ontario's Health Systems Documents"
        filterGroup:
          id: "0_19"
          title: "ontario's documents"
      }
    ]
  }
]
