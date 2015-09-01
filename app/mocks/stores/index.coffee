module.exports =
  ArticlesStore: require('mocks/stores/article_store')
  FilterStore: require('stores/filter_store') # load the real store, since no mocking is needed
  UserStore: require('stores/user_store')
  SearchStore: require('stores/search_store')
  ContentStore: require('stores/content_store')
  QuestionStore: require('stores/question_store')
