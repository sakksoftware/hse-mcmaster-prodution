TranslationHelper = require('mixins/translation_helper')

module.exports = React.createClass
  displayName: "SelectableItem"

  mixins: [TranslationHelper]
  baseTranslation: 'saved_search_page'

  propTypes:
    className: React.PropTypes.string
    selected: React.PropTypes.bool
    toggleSelect: React.PropTypes.func
    showSelect: React.PropTypes.bool

  getDefaultProps: ->
    showSelect: true

  toggleSelect: ->
    @props.toggleSelect(@)

  render: ->
    <li className="selectable-item #{@props.className}">
      {
        if @props.showSelect
          <label className="result-item-select">{@t('/select')}
            <input type="checkbox" onChange={@toggleSelect} checked={@props.selected} />
          </label>
      }
      {@props.children}
    </li>