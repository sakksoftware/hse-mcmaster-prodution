config =
  development:
    apiBase: '//localhost:3000'
    useMocks: true
    mockResponseTime: 500
    # localesUrl: '/locales/%{lng}.json'
    localesUrl: "https://api.phraseapp.com/api/v2/projects/9842d08220549184103dc972be792f4a/locales/%{lng}/download?access_token=0bbe94c73d32b2cae8a0ecef0ac1c778d72423412a97232112c15bc0f020e834&file_format=nested_json"
    recaptchaKey: '6LdQsAwTAAAAALZ8cZ2TOCW_BQ_faBRoL_Ffc3I1'
    siteUrl: 'http://localhost:3000'

  staging:
    apiBase: 'https://staging-api.healthsystemsevidence.org'
    useMocks: false
    mockResponseTime: 500
    localesUrl: "https://api.phraseapp.com/api/v2/projects/9842d08220549184103dc972be792f4a/locales/%{lng}/download?access_token=0bbe94c73d32b2cae8a0ecef0ac1c778d72423412a97232112c15bc0f020e834&file_format=nested_json"
    recaptchaKey: '6LdQsAwTAAAAALZ8cZ2TOCW_BQ_faBRoL_Ffc3I1'
    siteUrl: 'https://staging.healthsystemsevidence.org'

  production:
    apiBase: 'https://api.healthsystemsevidence.org'
    useMocks: false
    mockResponseTime: 500
    localesUrl: "https://api.phraseapp.com/api/v2/projects/9842d08220549184103dc972be792f4a/locales/%{lng}/download?access_token=0bbe94c73d32b2cae8a0ecef0ac1c778d72423412a97232112c15bc0f020e834&file_format=nested_json"
    recaptchaKey: '6LdQsAwTAAAAALZ8cZ2TOCW_BQ_faBRoL_Ffc3I1'
    siteUrl: 'https://www.healthsystemsevidence.org'

module.exports = config[window.ENV]
