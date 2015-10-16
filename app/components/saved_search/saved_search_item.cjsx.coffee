SearchSerializationService = require('services/search_serialization_service')
Link = require('components/shared/link')
Toggle = ReactToggle

module.exports = React.createClass
  displayName: 'SavedSearchItem'

  mixins: [SearchSerializationService]

  propTypes:
    search: React.PropTypes.object.isRequired

  getUrlParams: ->
    "#{@serializeSearchUrl()}"

  render: ->
    <div className="saved-search-item">
      <h2>
        <Link to={['/search', @serializeSearchParams(@props.search)]}>{@props.search.query}</Link>
      </h2>
      <div>
        Subscribe to search <Toggle defaultChecked={@props.search.subscribed} />
      </div>
    </div>
