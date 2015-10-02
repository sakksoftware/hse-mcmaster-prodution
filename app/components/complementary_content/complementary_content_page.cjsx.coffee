UserActions = require('actions/user_actions')
UserStore = require('stores/user_store')
TranslationHelper = require('mixins/translation_helper')

Toggle = ReactToggle

module.exports = React.createClass
  displayName: 'ComplementaryContentPage'

  mixins: [TranslationHelper]
  baseTranslation: 'complementary_content_page'

  componentWillMount: ->
    @unsubscribe = UserStore.listen (state) =>
      window.flash('success', 'Successfully updated')

  componentWillUnmount: ->
    @unsubscribe()

  handleToggle: (fieldName) ->
    =>
      UserActions.toggleComplementaryContent(fieldName)

  render: ->
    <div className="complementary-content-page">
      <h1>{@t('title')}</h1>
      <p>{@t('description')}</p>
      <ul className="complementary-content-list">
        <li className="complementary-content-item">
          <label>
            <p className="complementary-content-title">
              {@t('complementary_content_2.title')}
            </p>
            <p className="complementary-content-description">
              {@t('complementary_content_2.description')}
            </p>
            <Toggle defaultChecked={UserStore.state.user?.complementary_2}
              onChange={@handleToggle('complementary_2')} />
          </label>
        </li>
        <li className="complementary-content-item">
          <label>
            <p className="complementary-content-title">
              {@t('complementary_content_3.title')}
            </p>
            <p className="complementary-content-description">
              {@t('complementary_content_3.description')}
            </p>
            <Toggle defaultChecked={UserStore.state.user?.complementary_3}
              onChange={@handleToggle('complementary_3')} />
          </label>
        </li>
      </ul>
    </div>
