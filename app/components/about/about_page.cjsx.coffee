TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'AboutPage'
  mixins: [TranslationHelper]
  baseTranslation: 'about_page'

  render: ->
    <div className="about-page" dangerouslySetInnerHTML={__html: markdown.toHTML(@t('content'))}>
    </div>
