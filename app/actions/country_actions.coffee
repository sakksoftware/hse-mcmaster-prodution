API = require('lib/api')

CountryActions = Reflux.createActions
  loadCountries: {asyncResult: true}

CountryActions.loadCountries.listen ->

  API.read('countries').done(@completed).fail(@failed)

module.exports = CountryActions
