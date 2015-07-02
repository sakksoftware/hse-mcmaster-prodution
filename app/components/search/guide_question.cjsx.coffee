FilterList = require('components/search/filter_list')

module.exports = React.createClass
  displayName: 'GuideQuestion'
  propTypes:
    guideQuestion: React.PropTypes.object.isRequired

  render: ->
    <div className="guide-question">
      <div className="guide-question-text">
        {@props.guideQuestion.text}
      </div>
      <FilterList filters={@props.guideQuestion.filters} />
    </div>