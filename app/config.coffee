module.exports =
  development:
    apiBase: '//hse.functionalimperative.com'
    useMocks: true
    mockResponseTime: 500
    # localesUrl: '//s3.amazonaws.com/my-hse-staging/locales/'
    localesUrl: '/locales/'
    # TODO: implement
    # mockAlwaysSucceed: true

  staging:
    apiBase: '//hse.functionalimperative.com'
    useMocks: false
    mockResponseTime: 500
    localesUrl: '//s3.amazonaws.com/my-hse-staging/locales/'
    # TODO: implement
    # mockAlwaysSucceed: true

  production:
    apiBase: '//api.healthsystemsevidence.org'
    useMocks: false
    mockResponseTime: 500
    localesUrl: '/locales/'
    # TODO: implement
    # mockAlwaysSucceed: true
