module.exports = React.createClass
  displayName: "DocumentType"
  propTypes:
    document: React.PropTypes.object.isRequired

  topicList: ->
    items =
      for topic in @props.document.topics
        <li className="topic-item">{topic}</li>
    <ul>{items}</ul>

  countryList: ->
    items =
      for country in @props.document.countries
        <li className="country-item">{country.name_abbreviation} ({country.conducted_count})</li>
    <ul>{items}</ul>

  summaryList: ->
    items =
      for link in @props.document.summary_links
        <li className="summary-link-item">
          <a href={link.url} target="_blank">{link.source_name}</a>
        </li>
    <ul>{items}</ul>

  render: ->
    document = @props.document

    <div className="document-item">
      <h1>{document.title}</h1>

      <h2>Document Type</h2>
      {document.document_type}

      <h2>Question Type</h2>
      {document.question_type}

      <h2>Focus</h2>
      {document.focus}

      <h2>Target</h2>
      {document.target}

      <h2>Topics</h2>
      {@topicList()}

      <h2>Last Published</h2>
      {document.last_published}

      <h2>Quality</h2>
      {document.quality} ({document.quality_note})

      <h2>Countries</h2>
      {@countryList()}

      <h2>User Friendly Summary</h2>
      {@summaryList()}

      <h2>Full Text</h2>
      {document.full_text_link}
    </div>