ApplicationHelper = require('mixins/application_helper')

module.exports = React.createClass
  displayName: 'AnswerItem'

  mixins: [ApplicationHelper]

  propTypes:
    answer: React.PropTypes.object.isRequired
    onAddFilterById: React.PropTypes.func.isRequired

  handleAdd: (e) ->
    e.preventDefault()
    for filter in @props.answer.filters
      @props.onAddFilterById(filter.id)

  applyComplexFilter: (e) ->
    target = e.target
    if target.constructor == HTMLAnchorElement
      e.preventDefault()
      id = target.attributes['data-filter-id'].value
      @props.onAddFilterById(id)

  renderFiltersGroup: (filters)->
    for filter in filters
      "<a key=\"answer-filter-item-#{filter.id}\" data-filter-id=\"#{filter.id}\" href=\"#\">#{filter.title}</a>"

  render: ->
    answer = @props.answer
    html = '<div key="answer-item-complex">' + answer.text + '</div>'
    if matches = answer.text.match(/\%\{[A-Z0-9_]+\}/gi)
      for match, i in matches
        name = match.replace('%{', '').replace('}', '')
        filter = _.find(answer.filters, (f) -> f.name == name)

        filtersHtml = @renderFiltersGroup(filter.filters)

        html = html.replace("%{#{name}}", @joinList(filtersHtml))

      <li key="answer-item-complex-wrapper" className="answer-item" onClick={@applyComplexFilter} dangerouslySetInnerHTML={__html: html}></li>
    else
      <li key="answer-item-simple" className="answer-item">
        <a href="#" onClick={@handleAdd}>{answer.text}</a>
        {
          filterList = _.compact(_.pluck(answer.filters, 'title'))
          if answer.filters && filterList.length > 0
            <span className="answer-item-filters">
              [{@joinList(filterList)}]
            </span>
        }
      </li>
