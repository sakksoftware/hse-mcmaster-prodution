UserActions = require('actions/user_actions')
UrlActions = require('actions/url_actions')
UrlStore = require('stores/url_store')
TranslationHelper = require('mixins/translation_helper')
Button = require('components/shared/button')

module.exports = React.createClass
  displayName: 'UnsubscribePage'
  mixins: [TranslationHelper]
  baseTranslation: 'unsubscribe_page'

  unsubscribe: ->
    UserActions.unsubscribe(UrlStore.getParam('x')).then =>
      flash('success', @t('success'))
      UrlActions.navigateTo('/')

  render: ->
    <div className="unsubscribe-page">
      <h1>{@t('title')}</h1>
      <p>{@t('confirmation_msg')}</p>
      <Button className="btn btn-primary" onClick={@unsubscribe}>{@t('unsubscribe')}</Button>
    </div>
