GuideQuestion = require('components/search/guide_question')

module.exports = React.createClass
  displayName: 'FilterBox'
  propTypes:
    guideQuestion: React.PropTypes.object.isRequired


  render: ->
    <div className="filter-box">
      <GuideQuestion guideQuestion={@props.guideQuestion}/>
      <button>Skip</button>
    </div>