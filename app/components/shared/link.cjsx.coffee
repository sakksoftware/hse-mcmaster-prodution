UrlActions = require('actions/url_actions')
UrlStore = require('stores/url_store')

serializeParams = require('lib/url').serializeParams

module.exports = React.createClass
  displayName: 'Link'
  propTypes:
    to: React.PropTypes.oneOfType([
      React.PropTypes.string,
      React.PropTypes.array
    ]).isRequired
    children: React.PropTypes.node.isRequired
    className: React.PropTypes.string
    onClick: React.PropTypes.func

  path: ->
    path = @props.to
    if _.isArray(@props.to)
      path = @props.to[0]

    path

  params: ->
    params = {lang: UrlStore.state.params.lang}
    if _.isArray(@props.to)
      if @props.to.length > 1
        p = @props.to[1]
        params = _.extend(params, p)

    params

  query: ->
    query = ""
    params = @params()

    unless _.isEmpty(params)
      query = serializeParams(params)

    query

  url: ->
    @path() + @query()

  handleClick: (e) ->
    e.preventDefault()
    router = require('lib/router')
    if @props.to == 'back'
      UrlActions.back()
    else
      UrlActions.navigateTo(@path(), @params())

    @props.onClick?()

  render: ->
    <a href={@url()} onClick={@handleClick} className={@props.className}>
      {@props.children}
    </a>
