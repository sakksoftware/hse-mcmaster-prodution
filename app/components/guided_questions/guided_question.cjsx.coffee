AnswerList = require('components/guided_questions/answer_list')

module.exports = React.createClass
  displayName: 'GuidedQuestion'
  propTypes:
    question: React.PropTypes.object.isRequired
    onShowMenu: React.PropTypes.func.isRequired
    onHideMenu: React.PropTypes.func.isRequired

  getInitialState: ->
    expanded: false

  toggle: (e) ->
    e.preventDefault()
    @setState(expanded: !@state.expanded)

  render: ->
    toggleClass = "collapsed"
    toggleClass = "expanded" if @state.expanded

    <div className="guided-question #{toggleClass}">
      <div className="guided-question-text">
        {@props.question.text}
        <a className="btn-toggle" href="#" onClick={@toggle}></a>
      </div>
      <AnswerList answers={@props.question.answers} onShowMenu={@props.onShowMenu} onHideMenu={@props.onHideMenu} />
    </div>
