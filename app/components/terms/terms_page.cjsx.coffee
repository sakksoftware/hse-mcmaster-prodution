TranslationHelper = require('mixins/translation_helper')

# TODO: can refactor static pages: terms & about into a component
module.exports = React.createClass
  displayName: 'TermsPage'

  mixins: [TranslationHelper]
  baseTranslation: 'terms_page'

  render: ->
    <div className="terms-page" dangerouslySetInnerHTML={__html: markdown.toHTML(@t('content'))}>
    </div>
