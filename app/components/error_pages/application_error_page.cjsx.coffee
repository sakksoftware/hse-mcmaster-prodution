module.exports = React.createClass
  displayName: 'ApplicationErrorPage'

  reloadPage: (e) ->
    e.preventDefault();
    window.location.reload();

  render: ->
    <div className="application-error-page">
      <h1>Application error</h1>
      <p>
        Opps, we didn't expect that. Try <a href="#" onClick={@reloadPage}>refreshing the page</a>.
      </p>
      <p>
        If you continue seeing this, please contact us at <a target="_blank" href="mailto:michael.yagudaev@func-i.com">michael.yagudaev@func-i.com</a>
      </p>
    </div>
