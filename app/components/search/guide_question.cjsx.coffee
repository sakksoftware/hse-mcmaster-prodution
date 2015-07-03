FilterList = require('components/search/filter_list')

module.exports = React.createClass
  displayName: 'GuideQuestion'
  propTypes:
    guideQuestion: React.PropTypes.object.isRequired
    onAddFilter: React.PropTypes.func.isRequired

  render: ->
    <div className="guide-question">
      <div className="guide-question-text">
        {@props.guideQuestion.text}
      </div>
      <FilterList filters={@props.guideQuestion.filters} onAddFilter={@props.onAddFilter} />
    </div>