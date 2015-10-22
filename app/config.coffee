config =
  development:
    apiBase: '//hse.functionalimperative.com'
    useMocks: true
    mockResponseTime: 500
    # localesUrl: '//s3.amazonaws.com/my-hse-staging/locales/'
    localesUrl: '/locales/'
    recaptchaKey: '6LdQsAwTAAAAALZ8cZ2TOCW_BQ_faBRoL_Ffc3I1'
    siteUrl: 'http://localhost:3000'

  staging:
    apiBase: 'https://staging-api.healthsystemsevidence.org'
    useMocks: false
    mockResponseTime: 500
    localesUrl: '//s3.amazonaws.com/my-hse-staging/locales/hse/'
    recaptchaKey: '6LdQsAwTAAAAALZ8cZ2TOCW_BQ_faBRoL_Ffc3I1'
    siteUrl: 'https://www.healthsystemsevidence.org'

  production:
    apiBase: 'https://api.healthsystemsevidence.org'
    useMocks: false
    mockResponseTime: 500
    localesUrl: '/locales/'
    recaptchaKey: '6LdQsAwTAAAAALZ8cZ2TOCW_BQ_faBRoL_Ffc3I1'
    siteUrl: 'https://www.healthsystemsevidence.org'

module.exports = config[window.ENV]
