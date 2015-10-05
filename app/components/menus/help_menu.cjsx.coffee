TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'HelpMenu'
  mixins: [TranslationHelper]
  baseTranslation: 'menus.help'

  render: ->
    # <p>
    #   You can add "and" "or" "nor" to improve them.
    # </p>
    # <p>
    #   For example: you can search for <em>("Wins WorldCup" OR "Wins Champions Leauge") AND (football OR soccer)
    #   -American -beach -women's</em>
    # </p>
    # <p>
    #   The results would show who won the Champions Leauge and the WorldCup lately.
    # </p>

    <div className="help-menu" dangerouslySetInnerHTML={__html: marked @t('instructions')}>
    </div>
