AnswerList = require('components/guided_questions/answer_list')
UserStore = require('stores/user_store')
TourActions = require('actions/tour_actions')
Hotspot = require('components/tour/hotspot')

module.exports = React.createClass
  displayName: 'GuidedQuestion'
  propTypes:
    question: React.PropTypes.object.isRequired
    onShowMenu: React.PropTypes.func.isRequired
    onHideMenu: React.PropTypes.func.isRequired
    expanded: React.PropTypes.bool

  componentWillMount: ->
    TourActions.addStep
      key: 'guided_search'
      element: '.guided-questions-box'
      position: 'middle'
      order: 2

  componentWillUnmount: ->
    TourActions.removeStep 'guided_search'

  getInitialState: ->
    expanded: @props.expanded || false

  toggle: (e) ->
    e.preventDefault()
    @setState(expanded: !@state.expanded)

  getQuestion: ->
    if @props.question.regions
      @_getByRegion()
    else
      @props.question

  _getByRegion: ->
    if UserStore.state.user?.complementary_3 || (!UserStore.state.user && UserStore.state.region == 'ontario')
      _.findWhere(@props.question.regions, name: 'ontario').question
    else if UserStore.state.user?.complementary_2 || (!UserStore.state.user && UserStore.state.region == 'canada')
      _.findWhere(@props.question.regions, name: 'canada').question
    else
      _.findWhere(@props.question.regions, name: 'worldwide').question

  render: ->
    toggleClass = "collapsed"
    toggleClass = "expanded" if @state.expanded

    <div className="guided-question #{toggleClass}">
      <div className="guided-question-text">
        {@getQuestion().text}
        <a className="btn-toggle" href="#" onClick={@toggle}></a>
        <Hotspot tourKey="guided_search" />
      </div>
      <AnswerList answers={@getQuestion().answers} onShowMenu={@props.onShowMenu} onHideMenu={@props.onHideMenu} />
    </div>
