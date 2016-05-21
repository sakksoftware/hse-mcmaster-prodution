config =
  development:
    apiBase: '//localhost:3000'
    useMocks: true
    mockResponseTime: 500
    localesUrl: '/locales/%{lng}.json'
    recaptchaKey: '6LdQsAwTAAAAALZ8cZ2TOCW_BQ_faBRoL_Ffc3I1'
    siteUrl: 'http://localhost:3000'

  staging:
    apiBase: 'https://staging-api.healthsystemsevidence.org'
    useMocks: false
    mockResponseTime: 500
    localesUrl: 'https://s3.amazonaws.com/hse-staging/locales/%{lng}.json'
    recaptchaKey: '6LdQsAwTAAAAALZ8cZ2TOCW_BQ_faBRoL_Ffc3I1'
    siteUrl: 'https://staging.healthsystemsevidence.org'

  production:
    apiBase: 'https://api.healthsystemsevidence.org'
    useMocks: false
    mockResponseTime: 500
    localesUrl: 'https://s3.amazonaws.com/hse-production/locales/%{lng}.json'
    recaptchaKey: '6LdQsAwTAAAAALZ8cZ2TOCW_BQ_faBRoL_Ffc3I1'
    siteUrl: 'https://www.healthsystemsevidence.org'

module.exports = config[window.ENV]
