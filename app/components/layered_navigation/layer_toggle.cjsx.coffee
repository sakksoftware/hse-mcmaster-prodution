# TODO: remove dependency on the helper here and let user pass argument
# for the text instead
TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: 'LayerToggle'

  mixins: [TranslationHelper]
  baseTranslation: ''

  propTypes:
    menu: React.PropTypes.string.isRequired
    onToggle: React.PropTypes.func.isRequired
    title: React.PropTypes.string
    context: React.PropTypes.object
    children: React.PropTypes.node
    className: React.PropTypes.string
    style: React.PropTypes.any

  handleClick: (e) ->
    e.preventDefault()
    e.stopPropagation() # prevent things like dismiss menu from being called on parent
    @props.onToggle(@props.menu, @props.title || null, @props.context)

  render: ->
    menu = @props.menu.replace(/([A-Z])/g, "-$1").toLowerCase()
    <a ref="btnOffcanvas" href="#" onClick={@handleClick} style={@props.style} className={"layer-toggle layer-toggle-#{menu} #{@props.className}"}>
      <span className="sr-only">{@t('toggle_navigation')}</span>
      {@props.children}
    </a>
