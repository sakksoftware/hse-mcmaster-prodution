module.exports = React.createClass
  displayName: 'AnswerItem'
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
    html = _.clone(answer.text)
    if matches = answer.text.match(/\%\{[A-Z0-9_]+\}/gi)
      for match, i in matches
        name = match.replace('%{', '').replace('}', '')
        filter = _.find(answer.filters, (f) -> f.name == name)

        filtersHtml = @renderFiltersGroup(filter.filters)
        # TODO: refactor this bit to a helper on the translation
        lastItem = _.last(filtersHtml)
        filtersHtml = filtersHtml[0..-2].join(', ') + ' and ' + lastItem

        html = html.replace("%{#{name}}", filtersHtml)

      <li className="answer-item" onClick={@applyComplexFilter} dangerouslySetInnerHTML={__html: html}></li>
    else
      <li className="answer-item">
        <a href="#" onClick={@handleAdd}>{answer.text}</a>
        <span className="answer-item-filters">
          [{_.pluck(answer.filters, 'title').join(',')}]
        </span>
      </li>
