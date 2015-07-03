AppliedFilters = require('components/search/applied_filters')
FilterBox = require('components/search/filter_box')
SearchBar = require('components/search/search_bar')

module.exports = React.createClass
  displayName: 'SearchBox'
  propTypes:
    search: React.PropTypes.object
    onSearch: React.PropTypes.func.isRequired

  getAppliedFilters: ->
    @props.search.filters.filter((e) => e.applied)

  render: ->
    filterBox =
      if @props.search?.questions.length > 0
        <FilterBox guideQuestions={@props.search.questions} />
    appliedFilters =
      if @props.search?.filters.length > 0
        <AppliedFilters filters={@getAppliedFilters()}/>

    <div className="SearchBox">
      <SearchBar onSearch={@props.onSearch} />
      {appliedFilters}
      {filterBox}
    </div>