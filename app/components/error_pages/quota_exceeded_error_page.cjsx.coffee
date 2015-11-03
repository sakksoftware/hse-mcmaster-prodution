TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'QuotaExceededErrorPage'

  mixins: [TranslationHelper]
  baseTranslation: 'quota_exceeded_error_page'

  render: ->
    <div className="quota-exceeded-error-page">
      <h1>{@t('title')}</h1>
      <div className="quota-exceeded-body" dangerouslySetInnerHTML={__html: marked(@t('body'), 'Maruku')}></div>
    </div>
