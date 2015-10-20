SearchSerializationService = require('services/search_serialization_service')
Link = require('components/shared/link')
Toggle = ReactToggle

module.exports = React.createClass
  displayName: 'SavedSearchItem'

  mixins: [SearchSerializationService]

  propTypes:
    search: React.PropTypes.object.isRequired
    selected: React.PropTypes.bool

  getDefaultParams: ->
    selected: false

  getUrlParams: ->
    "#{@serializeSearchUrl()}"

  render: ->
    <li className="saved-search-item list-item">
      <div className="saved-search-item-header">
        <h2>
          <Link to={['/search', @serializeSearchParams(@props.search)]}>{@props.search.query}</Link>
        </h2>
        <label className="saved-search-select action">Select: <input type="checkbox" defaultChecked={@props.selected} /></label>
      </div>
      <label className="saved-search-control">
        Subscribe to search
        <Toggle defaultChecked={@props.search.subscribed} />
      </label>
    </li>
