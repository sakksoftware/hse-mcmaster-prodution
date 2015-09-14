module.exports = React.createClass
  displayName: 'TimeoutErrorPage'

  reloadPage: (e) ->
    e.preventDefault();
    window.location.reload();

  render: ->
    <div className="timeout-error-page">
      <h1>Connection Timeout</h1>
      <p>
        Opps, look like we could not reach our server.
        Check your internet connection and try <a href="#" onClick={@reloadPage}>refreshing the page</a>.
      </p>
      <p>
        If you continue seeing this, please contact us at <a target="_blank" href="mailto:michael.yagudaev@func-i.com">michael.yagudaev@func-i.com</a>
      </p>
    </div>
