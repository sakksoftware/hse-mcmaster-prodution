module.exports = React.createClass
  displayName: 'QuotaExceededErrorPage'

  render: ->
    <div className="quota-exceeded-error-page">
      <h1>403 Quota exceeded</h1>
      <p>
        Looks like you have exceeded your quota by making too many requests in a short period of time.
      </p>
      <p>
        We limit the number of allowed requests to prevent abuse and protect our service from malicious use.
      </p>
      <p>
        If you feel this is an error on our part, please contact us at <a target="_blank" href="mailto:michael.yagudaev@func-i.com">michael.yagudaev@func-i.com</a>
      </p>
    </div>
