AppliedFilters = require('components/search/applied_filters')
FilterBox = require('components/search/filter_box')
SearchBar = require('components/search/search_bar')

module.exports = React.createClass
  displayName: 'SearchBox'
  render: ->
    guideQuestion = {
      text: "Narrow your search by selecting one of the options below."
      filters: [
        {name: 'All of them', id: 1234, count: 350 }
        {name: 'Option A', id: 1235, count: 200 }
        {name: 'Option B', id: 1236, count: 100 }
      ]
    }

    <div className="SearchBox">
      <SearchBar />
      <AppliedFilters />
      <FilterBox guideQuestion={guideQuestion}/>
    </div>