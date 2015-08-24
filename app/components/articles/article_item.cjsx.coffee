TranslationHelper = require('mixins/translation_helper')
ApplicationHelper = require('mixins/application_helper')

module.exports = React.createClass
  displayName: "ArticleItem"

  mixins: [TranslationHelper, ApplicationHelper]
  baseTranslation: 'articles_page'

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
    return unless @props.article.studies_conducted_in?.countries
    items =
      for country, i in @props.article.studies_conducted_in.countries
        <li key="country-item-#{i}" className="country-item">{country.name_abbreviation} ({country.conducted_count})</li>
    <ul className="article-item-countries">{items}</ul>

  renderAuthorList: (authors) ->
    console.log(authors[0])
    items =
      for author, i in authors
        <li key="author-item-#{i}" className="author-item">
          <a href={author.url} target="_blank">{author.title}</a>
        </li>

    <ul className="article-author-list">
      {items}
    </ul>

  renderRegionList: ->
    return unless @props.article.studies_conducted_in?.regions
    items =
      for region, i in @props.article.studies_conducted_in?.regions
        <li key="region-item-#{i}" className="region-item">
          <span className="region-item-title">{region.title}:</span>
          {@renderAuthorList(region.authors)}
        </li>

    <ul className="article-item-region-list">{items}</ul>

  renderStudiesConductedIn: ->
    <div className="studies-conducted-in">
      {@renderCountryList()}
      {@renderRegionList()}
    </div>

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

    # TOODO: modify rendering of article domains
    <div className="article-item">
      <h1>{article.title}</h1>

      <h2>{@t('document_type')}</h2>
      {article.document_type}

      <h2>{@t('year_published')}</h2>
      {article.year_published}

      <h2>{@t('quality_rating')}</h2>
      {article.quality}/10 ({article.quality_note})

      <h2>{@t('countries')}</h2>
      {@renderStudiesConductedIn()}

      <div className="highlighted-section">
        <h2>{@t('domains')}</h2>
        {article.domains}

        <h2>{@t('topics')}</h2>
        <ul>{@renderTopicList(@props.article.topics)}</ul>
      </div>

      <h2>{@t('country_groupings')}</h2>
      {@renderCountryGroupingsList()}

      <h2>{@t('who_regions')}</h2>
      {article.who_regions}

      <h2>{@t('lmic_focus')}</h2>
      {article.lmic_focus}

      <div className="highlighted-section">
        <h2>{@t('summary_links')}</h2>
        {@renderLinksList('summary-link', article.summary_links)}

        <h2>{@t('abstract_links')}</h2>
        {@renderLinksList('abstract-links', article.abstract_links)}

        <h2>{@t('full_text_link')}</h2>
        {article.full_text_link || @t('full_text_link')}

        <h2>{@t('citation')}</h2>
        {article.citation}

        <h2>{@t('doi')}</h2>
        {article.doi || "Not yet available"}
      </div>

      <h2>{@t('question_type')}</h2>
      {article.question_type}

      <h2>{@t('focus')}</h2>
      {article.focus}

      <h2>{@t('target')}</h2>
      {article.target}

    </div>
