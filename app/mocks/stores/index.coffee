module.exports =
  ArticlesStore: require('mocks/stores/article_store')
  SearchStore: require('mocks/stores/search_store')
  FilterStore: require('mocks/stores/filter_store')
  UserStore: require('mocks/stores/user_store')
  ContentStore: require('stores/content_store') # load the real store, since no mocking is needed
