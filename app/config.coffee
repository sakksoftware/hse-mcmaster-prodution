config =
  development:
    apiBase: '//hse.functionalimperative.com'
    useMocks: true
    mockResponseTime: 500
    # localesUrl: '//s3.amazonaws.com/my-hse-staging/locales/'
    localesUrl: '/locales/'
    recaptchaKey: '6LeSqAwTAAAAAGRBFmdkvtCjqxWO2B5sPjWc0v1E'
    # TODO: implement
    # mockAlwaysSucceed: true

  staging:
    apiBase: '//hse.functionalimperative.com'
    useMocks: false
    mockResponseTime: 500
    localesUrl: '//s3.amazonaws.com/my-hse-staging/locales/'
    recaptchaKey: '6LeSqAwTAAAAAGRBFmdkvtCjqxWO2B5sPjWc0v1E'
    # TODO: implement
    # mockAlwaysSucceed: true

  production:
    apiBase: '//api.healthsystemsevidence.org'
    useMocks: false
    mockResponseTime: 500
    localesUrl: '/locales/'
    recaptchaKey: '6LeSqAwTAAAAAGRBFmdkvtCjqxWO2B5sPjWc0v1E'
    # TODO: implement
    # mockAlwaysSucceed: true

module.exports = config[window.ENV]
