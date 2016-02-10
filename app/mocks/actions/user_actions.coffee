API = require('lib/api')
StoreMock = require('mocks/support/store_mock')
FetchAPI = require('lib/fetch_api')

# private Data
articlesData = [{
  "id": "all_filled_all_visible",
  "traversal": "tencharacters",
  "title": "All <B>fields</B> Filled & Visible",
  "created_at": "2014-09-20 11:33:00Z",
  "updated_at": "2014-09-20 11:33:00Z",
  "quality": "7/11",
  "description": "Some <B>Crazy</B> long description goes here.....",
  "category": "<B>International</B> Organizations Document",
  "country_groupings": "<B>USA</B> (26); UK (2); Australia (1); Turkey (1)"
}]
searchesData = [{
  "id": 1,
  "query": "HIV in african countries",
  "subscribed": true,
  "applied_filters": ["0_2", "1_2"]
  "filters": [
    {
      "id": "0_2",
      "title": "LMIC countries",
      "applied": true
    },
    {
      "id": "1_2",
      "title": "Governance arrangements",
      "applied": true
    }
  ]
},
{
  "id": 2,
  "query": "HIV/AIDS infections over the last decade and their effect on our society",
  "subscribed": false,
  "applied_filters": ["0_2", "1_3"],
  "filters": [
    {
      "id": "0_2",
      "title": "LMIC Countries",
      "applied": true
    },
    {
      "id": "1_3",
      "title": "Stuff",
      "applied": true
    }
  ]
},
{"applied_filters":"2_1001;2_1005;2_1022;2_1023;2_1024;2_1025;2_1026;2_1006;2_1027;2_1028;2_1029;2_1030;2_1007;2_1031;2_1032;2_1033;2_1034;2_1035;2_1036;2_1008;2_1037;2_1038;2_1039;2_1040;2_1041;2_1042;2_1132;2_1009;2_1043;2_1044;2_1045;2_1046;2_1047;2_1002;2_1010;2_1048;2_1049;2_1050;2_1051;2_1052;2_1053;2_1054;2_1055;2_1131;2_1011;2_1056;2_1057;2_1058;2_1059;2_1060;2_1061;2_1012;2_1062;2_1063;2_1064;2_1065;2_1066;2_1067;2_1068;2_1013;2_1069;2_1070;2_1071;2_1072;2_1073;2_1074;2_1014;2_1075;2_1076;2_1077;2_1078;2_1019;2_1114;2_1115;2_1116;2_1117;2_1118;2_1119;2_1120;2_1121;2_1122;2_1123;2_1127;2_1128;2_1129;2_1130","filters":[{"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1001,"filters":null,"id":"2_1001","parent_id":-1,"title":"Governance arrangements","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1005,"filters":null,"id":"2_1005","parent_id":1001,"title":"Policy authority","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1022,"filters":null,"id":"2_1022","parent_id":1005,"title":"Centralization\/decentralization of policy authority","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1023,"filters":null,"id":"2_1023","parent_id":1005,"title":"Accountability of the state sector's role in financing & delivery","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1024,"filters":null,"id":"2_1024","parent_id":1005,"title":"Stewardship of the non-state sector's role in financing & delivery","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1025,"filters":null,"id":"2_1025","parent_id":1005,"title":"Decision-making authority about who is covered and what can or must be provided to them","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1026,"filters":null,"id":"2_1026","parent_id":1005,"title":"Corruption protections","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1006,"filters":null,"id":"2_1006","parent_id":1001,"title":"Organizational authority","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1027,"filters":null,"id":"2_1027","parent_id":1006,"title":"Ownership","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1028,"filters":null,"id":"2_1028","parent_id":1006,"title":"Management approaches","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1029,"filters":null,"id":"2_1029","parent_id":1006,"title":"Accreditation","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1030,"filters":null,"id":"2_1030","parent_id":1006,"title":"Networks\/multi-institutional arrangements","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1007,"filters":null,"id":"2_1007","parent_id":1001,"title":"Commercial authority","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1031,"filters":null,"id":"2_1031","parent_id":1007,"title":"Licensure & registration requirements","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1032,"filters":null,"id":"2_1032","parent_id":1007,"title":"Patents & profits","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1033,"filters":null,"id":"2_1033","parent_id":1007,"title":"Pricing & purchasing","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1034,"filters":null,"id":"2_1034","parent_id":1007,"title":"Marketing","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1035,"filters":null,"id":"2_1035","parent_id":1007,"title":"Sales & dispensing","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1036,"filters":null,"id":"2_1036","parent_id":1007,"title":"Commercial liability","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1008,"filters":null,"id":"2_1008","parent_id":1001,"title":"Professional authority","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1037,"filters":null,"id":"2_1037","parent_id":1008,"title":"Training & licensure requirements","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1038,"filters":null,"id":"2_1038","parent_id":1008,"title":"Scope of practice","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1039,"filters":null,"id":"2_1039","parent_id":1008,"title":"Setting of practice","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1040,"filters":null,"id":"2_1040","parent_id":1008,"title":"Continuing competence","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1041,"filters":null,"id":"2_1041","parent_id":1008,"title":"Quality & safety","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1042,"filters":null,"id":"2_1042","parent_id":1008,"title":"Professional liability","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1132,"filters":null,"id":"2_1132","parent_id":1008,"title":"Strike\/job action\u000d\u000a","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1009,"filters":null,"id":"2_1009","parent_id":1001,"title":"Consumer & stakeholder involvement","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1043,"filters":null,"id":"2_1043","parent_id":1009,"title":"Consumer participation in policy & organizational decisions","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1044,"filters":null,"id":"2_1044","parent_id":1009,"title":"Consumer participation in system monitoring","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1045,"filters":null,"id":"2_1045","parent_id":1009,"title":"Consumer participation in service delivery","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1046,"filters":null,"id":"2_1046","parent_id":1009,"title":"Consumer complaints management","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1047,"filters":null,"id":"2_1047","parent_id":1009,"title":"Stakeholder participation in policy & organizational decisions (or monitoring)","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1002,"filters":null,"id":"2_1002","parent_id":-1,"title":"Financial arrangements","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1010,"filters":null,"id":"2_1010","parent_id":1002,"title":"Financing systems","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1048,"filters":null,"id":"2_1048","parent_id":1010,"title":"Taxation","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1049,"filters":null,"id":"2_1049","parent_id":1010,"title":"Social health insurance","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1050,"filters":null,"id":"2_1050","parent_id":1010,"title":"Community-based health insurance","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1051,"filters":null,"id":"2_1051","parent_id":1010,"title":"Community loan funds","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1052,"filters":null,"id":"2_1052","parent_id":1010,"title":"Private insurance","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1053,"filters":null,"id":"2_1053","parent_id":1010,"title":"Health savings accounts (Individually financed)","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1054,"filters":null,"id":"2_1054","parent_id":1010,"title":"User fees","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1055,"filters":null,"id":"2_1055","parent_id":1010,"title":"Donor contributions","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1131,"filters":null,"id":"2_1131","parent_id":1010,"title":"Fundraising","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1011,"filters":null,"id":"2_1011","parent_id":1002,"title":"Funding organizations","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1056,"filters":null,"id":"2_1056","parent_id":1011,"title":"Fee-for-service (Funding)","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1057,"filters":null,"id":"2_1057","parent_id":1011,"title":"Capitation (Funding)","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1058,"filters":null,"id":"2_1058","parent_id":1011,"title":"Global budget","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1059,"filters":null,"id":"2_1059","parent_id":1011,"title":"Prospective payment (Funding)","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1060,"filters":null,"id":"2_1060","parent_id":1011,"title":"Indicative budgets (Funding)","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1061,"filters":null,"id":"2_1061","parent_id":1011,"title":"Targeted payments\/penalties (Funding)","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1012,"filters":null,"id":"2_1012","parent_id":1002,"title":"Remunerating providers","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1062,"filters":null,"id":"2_1062","parent_id":1012,"title":"Fee-for-service (Remuneration)","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1063,"filters":null,"id":"2_1063","parent_id":1012,"title":"Capitation (Remuneration)","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1064,"filters":null,"id":"2_1064","parent_id":1012,"title":"Salary","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1065,"filters":null,"id":"2_1065","parent_id":1012,"title":"Prospective payment (Remuneration)","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1066,"filters":null,"id":"2_1066","parent_id":1012,"title":"Fundholding","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1067,"filters":null,"id":"2_1067","parent_id":1012,"title":"Indicative budgets (Remuneration)","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1068,"filters":null,"id":"2_1068","parent_id":1012,"title":"Targeted payments\/penalties (Remuneration)","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1013,"filters":null,"id":"2_1013","parent_id":1002,"title":"Purchasing products & services","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1069,"filters":null,"id":"2_1069","parent_id":1013,"title":"Scope & nature of insurance plans","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1070,"filters":null,"id":"2_1070","parent_id":1013,"title":"Lists of covered\/reimbursed organizations, providers, services & products","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1071,"filters":null,"id":"2_1071","parent_id":1013,"title":"Restrictions in coverage\/reimbursement rates for organizations, providers, services & products","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1072,"filters":null,"id":"2_1072","parent_id":1013,"title":"Caps on coverage\/reimbursement for organizations, providers, services & products","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1073,"filters":null,"id":"2_1073","parent_id":1013,"title":"Prior approval requirements for organizations, providers, services & products","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1074,"filters":null,"id":"2_1074","parent_id":1013,"title":"Lists of substitutable services & products","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1014,"filters":null,"id":"2_1014","parent_id":1002,"title":"Incentivizing consumers","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1075,"filters":null,"id":"2_1075","parent_id":1014,"title":"Premium (level & features)","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1076,"filters":null,"id":"2_1076","parent_id":1014,"title":"Cost-sharing","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1077,"filters":null,"id":"2_1077","parent_id":1014,"title":"Health savings accounts (Third party contributions)","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1078,"filters":null,"id":"2_1078","parent_id":1014,"title":"Targeted payments\/penalties (Incentivizing consumers)","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1019,"filters":null,"id":"2_1019","parent_id":1004,"title":"Consumer-targeted strategy","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1114,"filters":null,"id":"2_1114","parent_id":1019,"title":"Information or education provision","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1115,"filters":null,"id":"2_1115","parent_id":1019,"title":"Behaviour change support","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1116,"filters":null,"id":"2_1116","parent_id":1019,"title":"Skills and competencies development","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1117,"filters":null,"id":"2_1117","parent_id":1019,"title":"(Personal) Support","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1118,"filters":null,"id":"2_1118","parent_id":1019,"title":"Communication and decision-making facilitation","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1119,"filters":null,"id":"2_1119","parent_id":1019,"title":"System participation","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1120,"filters":null,"id":"2_1120","parent_id":1020,"title":"Educational material","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1121,"filters":null,"id":"2_1121","parent_id":1020,"title":"Educational meeting","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1122,"filters":null,"id":"2_1122","parent_id":1020,"title":"Educational outreach visit","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1123,"filters":null,"id":"2_1123","parent_id":1020,"title":"Local opinion leader","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1127,"filters":null,"id":"2_1127","parent_id":1020,"title":"Reminders and prompts","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1128,"filters":null,"id":"2_1128","parent_id":1020,"title":"Tailored intervention","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1129,"filters":null,"id":"2_1129","parent_id":1020,"title":"Patient-mediated intervention","type":""},
    {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1130,"filters":null,"id":"2_1130","parent_id":1020,"title":"Multi-faceted intervention","type":""}
  ],"id":3506,"query":"","saved":true,"saved_search_id":3506,"subscribed":false,"userid":11567
},
{"applied_filters":"2_-1;2_1001;2_1005;2_1022;2_1023;2_1024;2_1025;2_1026;2_1006;2_1027;2_1028;2_1029;2_1030;2_1007;2_1031;2_1032;2_1033;2_1034;2_1035;2_1036;2_1008;2_1037;2_1038;2_1039;2_1040;2_1041;2_1042;2_1132;2_1009;2_1043;2_1044;2_1045;2_1046;2_1047;2_1002;2_1010;2_1048;2_1049;2_1050;2_1051;2_1052;2_1053;2_1054;2_1055;2_1131;2_1011;2_1056;2_1057;2_1058;2_1059;2_1060;2_1061;2_1012;2_1062;2_1063;2_1064;2_1065;2_1066;2_1067;2_1068;2_1013;2_1069;2_1070;2_1071;2_1072;2_1073;2_1074;2_1014;2_1075;2_1076;2_1077;2_1078;2_1003;2_1015;2_1079;2_1080;2_1081;2_1082;2_1083;2_1084;2_1016;2_1085;2_1086;2_1087;2_1088;2_1089;2_1090;2_1091;2_1092;2_1093;2_1094;2_1095;2_1096;2_1097;2_1098;2_1099;2_1100;2_1101;2_1017;2_1102;2_1103;2_1104;2_1105;2_1106;2_1107;2_1018;2_1108;2_1109;2_1110;2_1111;2_1112;2_1113","filters": [
  {"applied":1,"attributes":null,"count":null,"display_order":0,"filter_group_id":2,"filter_id":-1,"filters":null,"id":"2_-1","parent_id":0,"title":"System arrangements","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1001,"filters":null,"id":"2_1001","parent_id":-1,"title":"Governance arrangements","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1005,"filters":null,"id":"2_1005","parent_id":1001,"title":"Policy authority","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1022,"filters":null,"id":"2_1022","parent_id":1005,"title":"Centralization\/decentralization of policy authority","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1023,"filters":null,"id":"2_1023","parent_id":1005,"title":"Accountability of the state sector's role in financing & delivery","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1024,"filters":null,"id":"2_1024","parent_id":1005,"title":"Stewardship of the non-state sector's role in financing & delivery","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1025,"filters":null,"id":"2_1025","parent_id":1005,"title":"Decision-making authority about who is covered and what can or must be provided to them","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1026,"filters":null,"id":"2_1026","parent_id":1005,"title":"Corruption protections","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1006,"filters":null,"id":"2_1006","parent_id":1001,"title":"Organizational authority","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1027,"filters":null,"id":"2_1027","parent_id":1006,"title":"Ownership","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1028,"filters":null,"id":"2_1028","parent_id":1006,"title":"Management approaches","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1029,"filters":null,"id":"2_1029","parent_id":1006,"title":"Accreditation","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1030,"filters":null,"id":"2_1030","parent_id":1006,"title":"Networks\/multi-institutional arrangements","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1007,"filters":null,"id":"2_1007","parent_id":1001,"title":"Commercial authority","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1031,"filters":null,"id":"2_1031","parent_id":1007,"title":"Licensure & registration requirements","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1032,"filters":null,"id":"2_1032","parent_id":1007,"title":"Patents & profits","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1033,"filters":null,"id":"2_1033","parent_id":1007,"title":"Pricing & purchasing","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1034,"filters":null,"id":"2_1034","parent_id":1007,"title":"Marketing","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1035,"filters":null,"id":"2_1035","parent_id":1007,"title":"Sales & dispensing","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1036,"filters":null,"id":"2_1036","parent_id":1007,"title":"Commercial liability","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1008,"filters":null,"id":"2_1008","parent_id":1001,"title":"Professional authority","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1037,"filters":null,"id":"2_1037","parent_id":1008,"title":"Training & licensure requirements","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1038,"filters":null,"id":"2_1038","parent_id":1008,"title":"Scope of practice","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1039,"filters":null,"id":"2_1039","parent_id":1008,"title":"Setting of practice","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1040,"filters":null,"id":"2_1040","parent_id":1008,"title":"Continuing competence","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1041,"filters":null,"id":"2_1041","parent_id":1008,"title":"Quality & safety","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1042,"filters":null,"id":"2_1042","parent_id":1008,"title":"Professional liability","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1132,"filters":null,"id":"2_1132","parent_id":1008,"title":"Strike\/job action\u000d\u000a","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1009,"filters":null,"id":"2_1009","parent_id":1001,"title":"Consumer & stakeholder involvement","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1043,"filters":null,"id":"2_1043","parent_id":1009,"title":"Consumer participation in policy & organizational decisions","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1044,"filters":null,"id":"2_1044","parent_id":1009,"title":"Consumer participation in system monitoring","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1045,"filters":null,"id":"2_1045","parent_id":1009,"title":"Consumer participation in service delivery","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1046,"filters":null,"id":"2_1046","parent_id":1009,"title":"Consumer complaints management","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1047,"filters":null,"id":"2_1047","parent_id":1009,"title":"Stakeholder participation in policy & organizational decisions (or monitoring)","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1002,"filters":null,"id":"2_1002","parent_id":-1,"title":"Financial arrangements","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1010,"filters":null,"id":"2_1010","parent_id":1002,"title":"Financing systems","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1048,"filters":null,"id":"2_1048","parent_id":1010,"title":"Taxation","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1049,"filters":null,"id":"2_1049","parent_id":1010,"title":"Social health insurance","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1050,"filters":null,"id":"2_1050","parent_id":1010,"title":"Community-based health insurance","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1051,"filters":null,"id":"2_1051","parent_id":1010,"title":"Community loan funds","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1052,"filters":null,"id":"2_1052","parent_id":1010,"title":"Private insurance","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1053,"filters":null,"id":"2_1053","parent_id":1010,"title":"Health savings accounts (Individually financed)","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1054,"filters":null,"id":"2_1054","parent_id":1010,"title":"User fees","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1055,"filters":null,"id":"2_1055","parent_id":1010,"title":"Donor contributions","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1131,"filters":null,"id":"2_1131","parent_id":1010,"title":"Fundraising","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1011,"filters":null,"id":"2_1011","parent_id":1002,"title":"Funding organizations","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1056,"filters":null,"id":"2_1056","parent_id":1011,"title":"Fee-for-service (Funding)","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1057,"filters":null,"id":"2_1057","parent_id":1011,"title":"Capitation (Funding)","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1058,"filters":null,"id":"2_1058","parent_id":1011,"title":"Global budget","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1059,"filters":null,"id":"2_1059","parent_id":1011,"title":"Prospective payment (Funding)","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1060,"filters":null,"id":"2_1060","parent_id":1011,"title":"Indicative budgets (Funding)","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1061,"filters":null,"id":"2_1061","parent_id":1011,"title":"Targeted payments\/penalties (Funding)","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1012,"filters":null,"id":"2_1012","parent_id":1002,"title":"Remunerating providers","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1062,"filters":null,"id":"2_1062","parent_id":1012,"title":"Fee-for-service (Remuneration)","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1063,"filters":null,"id":"2_1063","parent_id":1012,"title":"Capitation (Remuneration)","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1064,"filters":null,"id":"2_1064","parent_id":1012,"title":"Salary","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1065,"filters":null,"id":"2_1065","parent_id":1012,"title":"Prospective payment (Remuneration)","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1066,"filters":null,"id":"2_1066","parent_id":1012,"title":"Fundholding","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1067,"filters":null,"id":"2_1067","parent_id":1012,"title":"Indicative budgets (Remuneration)","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1068,"filters":null,"id":"2_1068","parent_id":1012,"title":"Targeted payments\/penalties (Remuneration)","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1013,"filters":null,"id":"2_1013","parent_id":1002,"title":"Purchasing products & services","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1069,"filters":null,"id":"2_1069","parent_id":1013,"title":"Scope & nature of insurance plans","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1070,"filters":null,"id":"2_1070","parent_id":1013,"title":"Lists of covered\/reimbursed organizations, providers, services & products","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1071,"filters":null,"id":"2_1071","parent_id":1013,"title":"Restrictions in coverage\/reimbursement rates for organizations, providers, services & products","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1072,"filters":null,"id":"2_1072","parent_id":1013,"title":"Caps on coverage\/reimbursement for organizations, providers, services & products","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1073,"filters":null,"id":"2_1073","parent_id":1013,"title":"Prior approval requirements for organizations, providers, services & products","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1074,"filters":null,"id":"2_1074","parent_id":1013,"title":"Lists of substitutable services & products","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1014,"filters":null,"id":"2_1014","parent_id":1002,"title":"Incentivizing consumers","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1075,"filters":null,"id":"2_1075","parent_id":1014,"title":"Premium (level & features)","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1076,"filters":null,"id":"2_1076","parent_id":1014,"title":"Cost-sharing","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1077,"filters":null,"id":"2_1077","parent_id":1014,"title":"Health savings accounts (Third party contributions)","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1078,"filters":null,"id":"2_1078","parent_id":1014,"title":"Targeted payments\/penalties (Incentivizing consumers)","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1003,"filters":null,"id":"2_1003","parent_id":-1,"title":"Delivery arrangements","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1015,"filters":null,"id":"2_1015","parent_id":1003,"title":"How care is designed to meet consumers' needs","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1079,"filters":null,"id":"2_1079","parent_id":1015,"title":"Availability of care","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1080,"filters":null,"id":"2_1080","parent_id":1015,"title":"Timely access to care","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1081,"filters":null,"id":"2_1081","parent_id":1015,"title":"Culturally appropriate care","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1082,"filters":null,"id":"2_1082","parent_id":1015,"title":"Case management","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1083,"filters":null,"id":"2_1083","parent_id":1015,"title":"Package of care\/care pathways\/disease management","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1084,"filters":null,"id":"2_1084","parent_id":1015,"title":"Group care","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1016,"filters":null,"id":"2_1016","parent_id":1003,"title":"By whom care is provided","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1085,"filters":null,"id":"2_1085","parent_id":1016,"title":"System - Need, demand & supply","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1086,"filters":null,"id":"2_1086","parent_id":1016,"title":"System - Recruitment, retention & transitions","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1087,"filters":null,"id":"2_1087","parent_id":1016,"title":"System - Performance management","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1088,"filters":null,"id":"2_1088","parent_id":1016,"title":"Workplace conditions - Provider satisfaction","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1089,"filters":null,"id":"2_1089","parent_id":1016,"title":"Workplace conditions - Health & safety","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1090,"filters":null,"id":"2_1090","parent_id":1016,"title":"Skill mix - Role performance","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1091,"filters":null,"id":"2_1091","parent_id":1016,"title":"Skill mix - Role expansion or extension","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1092,"filters":null,"id":"2_1092","parent_id":1016,"title":"Skill mix - Task shifting \/ substitution","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1093,"filters":null,"id":"2_1093","parent_id":1016,"title":"Skill mix - Multidisciplinary teams","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1094,"filters":null,"id":"2_1094","parent_id":1016,"title":"Skill mix - Volunteers or informal\/family caregivers","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1095,"filters":null,"id":"2_1095","parent_id":1016,"title":"Skill mix - Communication & case discussion between distant health professionals","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1096,"filters":null,"id":"2_1096","parent_id":1016,"title":"Staff - Training","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1097,"filters":null,"id":"2_1097","parent_id":1016,"title":"Staff - Support","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1098,"filters":null,"id":"2_1098","parent_id":1016,"title":"Staff - Workload\/workflow\/intensity","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1099,"filters":null,"id":"2_1099","parent_id":1016,"title":"Staff - Continuity of care","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1100,"filters":null,"id":"2_1100","parent_id":1016,"title":"Staff\/self - Shared decision-making","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1101,"filters":null,"id":"2_1101","parent_id":1016,"title":"Self-management","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1017,"filters":null,"id":"2_1017","parent_id":1003,"title":"Where care is provided","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1102,"filters":null,"id":"2_1102","parent_id":1017,"title":"Site of service delivery","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1103,"filters":null,"id":"2_1103","parent_id":1017,"title":"Physical structure, facilities & equipment","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1104,"filters":null,"id":"2_1104","parent_id":1017,"title":"Organizational scale","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1105,"filters":null,"id":"2_1105","parent_id":1017,"title":"Integration of services","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1106,"filters":null,"id":"2_1106","parent_id":1017,"title":"Continuity of care","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1107,"filters":null,"id":"2_1107","parent_id":1017,"title":"Outreach","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1018,"filters":null,"id":"2_1018","parent_id":1003,"title":"With what supports is care provided","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1108,"filters":null,"id":"2_1108","parent_id":1018,"title":"Health record systems","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1109,"filters":null,"id":"2_1109","parent_id":1018,"title":"Electronic health record","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1110,"filters":null,"id":"2_1110","parent_id":1018,"title":"Other ICT that support individuals who provide care","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1111,"filters":null,"id":"2_1111","parent_id":1018,"title":"ICT that support individuals who receive care","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1112,"filters":null,"id":"2_1112","parent_id":1018,"title":"Quality monitoring and improvement systems","type":""},
  {"applied":1,"attributes":null,"count":null,"display_order":1,"filter_group_id":2,"filter_id":1113,"filters":null,"id":"2_1113","parent_id":1018,"title":"Safety monitoring and improvement systems","type":""}],"id":3591,"query":"hiv","saved":true,"saved_search_id":3591,"subscribed":false,"userid":11567}
]
maxSearchId = 2

UserActions = Reflux.createActions
  changeLanguage: {}
  toggleGuidedSearch: {}
  toggleComplementaryContent: {}
  createUser: {asyncResult: true}
  loginUser: {asyncResult: true}
  logoutUser: {asyncResult: true}
  updateUser: {asyncResult: true}
  loadUser: {asyncResult: true}
  forgotPassword: {asyncResult: true}
  resetPassword: {asyncResult: true}
  loadRegion: {asyncResult: true}
  unsubscribe: {asyncResult: true}
  loadSearches: {asyncResult: true}
  loadCuratedSearches: {asyncResult: true}
  toggleSaveSearch: {asyncResult: true}
  saveSearch: {asyncResult: true}
  toggleSubscribeToSearch: {asyncResult: true}
  toggleSubscribeToSavedSearch: {asyncResult: true}
  toggleSubscribeToCuratedSearch: {asyncResult: true}
  removeSearches: {asyncResult: true}
  saveArticles: {asyncResult: true}
  loadArticles: {asyncResult: true}
  removeArticles: {asyncResult: true}
  emailArticles: {asyncResult: true}

UserActions.createUser.listen (user) ->
  user.errors = {}
  if _.isEmpty(user.email)
    user.errors.email = "cant_be_blank"
  if _.isEmpty(user.password)
    user.errors.password = "can't be blank!"
  if _.isEmpty(user.confirm_password)
    user.errors.confirm_password = "can't be blank!"
  if user.accept_terms != "on" && user.accept_terms != true
    user.errors.accept_terms = "must_accept_terms"

  if _.isEmpty(user.errors)
    API.read('user').done (u) =>
      user = _.extend(u, user)
      StoreMock.send(user, (=> @completed(user)), 'POST /users')
  else
    StoreMock.sendError(400, user, (=> @failed({}, 'bad data', user)), 'POST /users')

UserActions.loadUser.listen ->
  API.read('user').done(@completed).fail(@failed)

UserActions.updateUser.listen (user) ->
  @completed(user)

UserActions.loginUser.listen (user) ->
  user.errors = {}
  if _.isEmpty(user.email)
    user.errors.email = "can't be blank!"
  if _.isEmpty(user.password)
    user.errors.password = "can't be blank!"

  if _.isEmpty(user.errors)
    API.read('user').done (u) =>
      user = _.extend(u, user)
      StoreMock.send user, (=> @completed(user)), 'POST /users/login'
  else
    StoreMock.sendError 400, user, (=> @failed({}, "bad input", user)), 'POST /users/login'

UserActions.logoutUser.listen (user) ->
  StoreMock.send user, (=> @completed(user)), 'GET /user/logout'

UserActions.forgotPassword.listen (data) ->
  StoreMock.send data, (=> @completed(data)), 'POST /user/forgotPassword'

UserActions.resetPassword.listen (data) ->
  API.read('user').done (user) =>
    StoreMock.send data, (=> @completed(user)), 'POST /user/reset_password'

UserActions.loadRegion.listen ->
  API.read('geo').done(@completed).fail(@failed)

UserActions.unsubscribe.listen (params) ->
  FetchAPI.update('user/unsubscribe', params).then(@completed).catch(@failed)

UserActions.loadSearches.listen ->
  Promise.resolve(searchesData).then(@completed)

UserActions.toggleSaveSearch.listen (search) ->
  if search.saved
    UserActions.removeSearches([{id: search.saved_search_id}]).then(@completed).catch(@failed)
  else
    UserActions.saveSearch(search).then(@completed).catch(@failed)

UserActions.saveSearch.listen (search) ->
  search = _.clone(search)
  search.id = ++maxSearchId
  search.saved = true
  searchesData.push(search)
  Promise.resolve(search).then(@completed)

UserActions.removeSearches.listen (searches) ->
  toDelete = _(searchesData).filter (s) -> _.findWhere(searches, id: s.id)
  searchesData = _.difference(searchesData, toDelete)
  Promise.resolve(_.pluck(toDelete, 'id')).then(@completed)

UserActions.saveArticles.listen (articles) ->
  ids = _.pluck(articles, 'id')
  articlesData = articlesData.concat(articles)
  articlesData = _(articlesData).uniq (a) -> a.id
  Promise.resolve(articles).then(@completed)

UserActions.loadArticles.listen ->
  FetchAPI.read('/user/articles').then(@completed).catch(@failed)

UserActions.removeArticles.listen (articles) ->
  toDelete = _(articlesData).filter (a) -> _.findWhere(articles, id: a.id)
  articlesData = _.difference(articlesData, toDelete)
  Promise.resolve(_.pluck(toDelete, 'id')).then(@completed)

UserActions.emailArticles.listen (articles) ->
  Promise.resolve(_.pluck(articles, 'id')).then(@completed)

UserActions.toggleSubscribeToSearch.listen (search) ->
  search = _.clone(search)
  saved_search = _.omit(search, ['results', 'filters', 'saved_search_id'])
  saved_search.id = search.saved_search_id
  saved_search.filters = []
  if search.saved
    UserActions.toggleSubscribeToSavedSearch(saved_search.id, saved_search.subscribed).then(@completed)
  else
    UserActions.saveSearch(search).then (search) =>
      saved_search = _.omit(search, ['results', 'filters'])
      UserActions.toggleSubscribeToSavedSearch(saved_search.id, saved_search.subscribed).then(@completed).catch(@error)

UserActions.toggleSubscribeToSavedSearch.listen (id, subscribed) ->
  saved_search = _.clone(_.findWhere(searchesData, id: id))
  saved_search.subscribed = !subscribed
  Promise.resolve(saved_search).then(@completed)

UserActions.toggleSubscribeToCuratedSearch.listen (curated_search) ->
  if curated_search.subscribed
    id = curated_search.saved_search_id
    FetchAPI.create("/user/searches/remove", [id]).catch(@failed).then =>
      curated_search.saved = false
      curated_search.subscribed = false
      @completed(curated_search)
  else
    search = curated_search
    search.subscribed = true
    FetchAPI.create("/user/searches", search).catch(@failed).then(@completed)

UserActions.loadCuratedSearches.listen ->
  FetchAPI.read('/user/curated_searches').then(@completed).catch(@failed)

module.exports = UserActions
