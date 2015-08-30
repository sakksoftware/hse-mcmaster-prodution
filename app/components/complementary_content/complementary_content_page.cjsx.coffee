UserActions = require('actions/user_actions')
UserStore = require('stores/user_store')

Toggle = ReactToggle

module.exports = React.createClass
  displayName: 'ComplementaryContentPage'

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
      <h1>Complementary Content</h1>
      <p>Enable viewing of complementary content</p>
      <ul className="complementary-content-list">
        <li className="complementary-content-item">
          <label>
            <p className="complementary-content-title">
              Intergovernmental Organiations' Health Systems Documents
            </p>
            <p className="complementary-content-description">For those who...</p>
            <Toggle defaultChecked={UserStore.state.user.complementary_1}
              onChange={@handleToggle('complementary_1')} />
          </label>
        </li>
        <li className="complementary-content-item">
          <label>
            <p className="complementary-content-title">
              Canada's Health System Documents
            </p>
            <p className="complementary-content-description">For those who do not designate their country as Canada or log in
            using a Canada-based IP address</p>
            <Toggle defaultChecked={UserStore.state.user.complementary_2}
              onChange={@handleToggle('complementary_2')} />
          </label>
        </li>
        <li className="complementary-content-item">
          <label>
            <p className="complementary-content-title">
              Ontario's Health System Documents
            </p>
            <p className="complementary-content-description">For those who log in Ontario-based IP address</p>
            <Toggle defaultChecked={UserStore.state.user.complementary_3}
              onChange={@handleToggle('complementary_3')} />
          </label>
        </li>
      </ul>
    </div>
