module.exports = React.createClass
  displayName: "ArticleItem"
  propTypes:
    article: React.PropTypes.object.isRequired

  topicList: ->
    items =
      for topic, i in @props.article.topics
        <li key={"topic-item-#{i}"} className="topic-item">{topic}</li>
    <ul>{items}</ul>

  countryList: ->
    items =
      for country, i in @props.article.countries
        <li key={"country-item-#{i}"} className="country-item">{country.name_abbreviation} ({country.conducted_count})</li>
    <ul>{items}</ul>

  summaryList: ->
    items =
      for link, i in @props.article.summary_links
        <li key={"summary-link-#{i}"} className="summary-link-item">
          <a href={link.url} target="_blank">{link.source_name}</a>
        </li>
    <ul>{items}</ul>

  render: ->
    article = @props.article

    <div className="article-item">
      <h1>{article.title}</h1>

      <h2>Document Type</h2>
      {article.document_type}

      <h2>Question Type</h2>
      {article.question_type}

      <h2>Focus</h2>
      {article.focus}

      <h2>Target</h2>
      {article.target}

      <h2>Topics</h2>
      {@topicList()}

      <h2>Last Published</h2>
      {article.last_published}

      <h2>Quality</h2>
      {article.quality} ({article.quality_note})

      <h2>Countries</h2>
      {@countryList()}

      <h2>User Friendly Summary</h2>
      {@summaryList()}

      <h2>Full Text</h2>
      {article.full_text_link}
    </div>
