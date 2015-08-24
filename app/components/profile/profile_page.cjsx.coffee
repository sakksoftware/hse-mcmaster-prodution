Form = require('components/shared/form')
languages = require('constants/languages')

module.exports = React.createClass
  displayName: 'ProfilePage'

  renderLanguageSelect: ->
    options =
      for language in languages
        <option key="language-#{language.name}" value={language.name}>{language.title}</option>

    <select label="Language" name="language" type="select">
      {options}
    </select>

  render: ->
    <Form className="profile-page">
      <h1>My Profile</h1>

      <h2>Account Information</h2>
      <input label="Email" name="email" type="email" />
      <input label="Password" name="password" type="password" />
      <input label="Confirm Password" name="confirm_password" type="password" />
      <button>Update information</button>

      <h2>Personal Information</h2>
      <input label="First Name" name="first_name" />
      <input label="Last Name" name="last_name" />
      <input label="Role" name="role" />
      <input label="Country" name="country" />
      {@renderLanguageSelect()}
      <button>Update information</button>
    </Form>
