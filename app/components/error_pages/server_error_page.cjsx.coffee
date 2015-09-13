module.exports = React.createClass
  displayName: 'ServerErrorPage'

  reloadPage: (e) ->
    e.preventDefault();
    window.location.reload();

  render: ->
    <div className="server-error-page">
      <h1>Server Error</h1>
      <p>
        Service is unavilable, please try <a href="#" onClick={@reloadPage}>refreshing the page</a>.
      </p>
      <p>
        If you continue seeing this, please contact us at <a target="_blank" href="mailto:michael.yagudaev@func-i.com">michael.yagudaev@func-i.com</a>
      </p>
    </div>
