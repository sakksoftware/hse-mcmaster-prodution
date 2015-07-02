AppliedFilters = require('components/search/applied_filters')
FilterBox = require('components/search/filter_box')
SearchBar = require('components/search/search_bar')

module.exports = React.createClass
  displayName: 'SearchBox'
  propTypes:
    guideQuestions: React.PropTypes.array.isRequired
    onSearch: React.PropTypes.func.isRequired

  render: ->
    filterBox =
      if @props.guideQuestions.length > 0
        <FilterBox guideQuestions={@props.guideQuestions} />

    <div className="SearchBox">
      <SearchBar onSearch={@props.onSearch} />
      <AppliedFilters />
      {filterBox}
    </div>