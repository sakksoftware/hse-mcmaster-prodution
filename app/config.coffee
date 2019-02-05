config =
  development:
    apiBase: '//localhost:3000'
    useMocks: true
    mockResponseTime: 500
    localesUrl: '/locales/%{lng}.json'
    recaptchaKey: '6LcJ5xAUAAAAANuw9EYe3cZ4yQ_tmfIn-ZBC_x6x'
    siteUrl: 'http://localhost:3000'

  staging:
    apiBase: 'https://staging-api.healthsystemsevidence.org'
    useMocks: false
    mockResponseTime: 500
    localesUrl: 'https://s3.amazonaws.com/hse-staging/locales/%{lng}.json'
    recaptchaKey: '6LcJ5xAUAAAAANuw9EYe3cZ4yQ_tmfIn-ZBC_x6x'
    siteUrl: 'https://staging.healthsystemsevidence.org'

  production:
    apiBase: 'https://api.healthsystemsevidence.org'
    useMocks: false
    mockResponseTime: 500
    localesUrl: 'https://s3.amazonaws.com/hsse-staging/locales/%{lng}.json'
    recaptchaKey: '6LcJ5xAUAAAAANuw9EYe3cZ4yQ_tmfIn-ZBC_x6x'
    siteUrl: 'https://www.healthsystemsevidence.org'

module.exports = config[window.ENV]
