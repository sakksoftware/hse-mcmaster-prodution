module.exports = React.createClass
  displayName: "ArticleItem"
  propTypes:
    article: React.PropTypes.object.isRequired

  renderTopicList: (topics) ->
    result = []

    for topic, i in topics
      result.push <li key={"topic-item-#{i}"} className="topic-item">{topic.title}</li>
      if topic.topics
        result.push <li key={"topic-item-nested-#{i}"} className="topic-item">
          <ul>
            {@renderTopicList(topic.topics)}
          </ul>
        </li>

    result

  renderCountryList: ->
    items =
      for country, i in @props.article.countries
        <li key={"country-item-#{i}"} className="country-item">{country.name_abbreviation} ({country.conducted_count})</li>
    <ul className="article-item-countries">{items}</ul>

  renderCountryGroupingsList: ->
    items =
      for group, i in @props.article.country_groupings
        <li key={"country-grouping-#{i}"} className="country-grouping-item">
          {group}
        </li>
    <ul className="article-item-country-groupings">{items}</ul>

  renderLinksList: (name, links)->
    items =
      for link, i in links
        <li key={"#{name}-#{i}"} className="#{name}-item">
          <a href={link.url} target="_blank">{link.title}</a>
        </li>
    <ul>{items}</ul>

  render: ->
    article = @props.article

    <div className="article-item">
      <h1>{article.title}</h1>

      <h2>Type of Document</h2>
      {article.document_type}

      <h2>Last year litereature searched or year published</h2>
      {article.last_published}

      <h2>Quality rating</h2>
      {article.quality}/10 ({article.quality_note})

      <h2>Countries in which studies (included in the synthesis) were conducted</h2>
      {@renderCountryList()}

      <div className="highlighted-section">
        <h2>Domain</h2>
        {article.domain}

        <h2>Health system topics</h2>
        <ul>{@renderTopicList(@props.article.topics)}</ul>
      </div>

      <h2>Country groupings</h2>
      {@renderCountryGroupingsList()}

      <h2>World health organization regions</h2>
      {article.who_regions}

      <h2>Low- and middle-income regions (LMIC) focus</h2>
      {article.lmic_focus}

      <div className="highlighted-section">
        <h2>User Friendly Summary</h2>
        {@renderLinksList('summary-link', article.summary_links)}

        <h2>Scentific abstract</h2>
        {@renderLinksList('abstract-links', article.abstract_links)}

        <h2>Full-Text report</h2>
        {article.full_text_link || "No free full text search report available"}

        <h2>Citation</h2>
        {article.citation}

        <h2>DOI</h2>
        {article.doi || "Not yet available"}
      </div>

      <h2>Type of question</h2>
      {article.question_type}

      <h2>Focus</h2>
      {article.focus}

      <h2>Target</h2>
      {article.target}

    </div>
