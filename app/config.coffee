module.exports =
  development:
    apiBase: '//hse.functionalimperative.com'
    useMockStores: true
    mockResponseTime: 500
    localesUrl: '/locales/%{lng}.json'
    # TODO: implement
    # mockAlwaysSucceed: true

  production:
    apiBase: '//hse.functionalimperative.com'
    useMockStores: false
    mockResponseTime: 500
    localesUrl: '//s3.amazonaws.com/my-hse/locales/%{lng}.json'
    # TODO: implement
    # mockAlwaysSucceed: true
