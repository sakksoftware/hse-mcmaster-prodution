TranslationHelper = require('mixins/translation_helper')
ApplicationHelper = require('mixins/application_helper')
ArticleField = require('components/articles/article_field')

module.exports = React.createClass
  displayName: "ArticleItem"

  mixins: [TranslationHelper, ApplicationHelper]
  baseTranslation: 'articles_page'

  propTypes:
    article: React.PropTypes.object.isRequired

  renderNestedList: (list, listName, itemName) ->
    result = []
    return result unless list?.length > 0

    for item, i in list
      result.push <li key={"#{itemName}-item-#{i}"} className="#{itemName}-item">{item.title}</li>
      if item[listName] && item[listName].length > 0
        result.push <li key={"#{itemName}-item-nested-#{i}"} className="#{itemName}-item">
          <ul>
            {@renderNestedList(item[listName], listName, itemName)}
          </ul>
        </li>

    result

  renderCountryList: ->
    return unless @props.article.studies_conducted_in?.countries
    items =
      for country, i in @props.article.studies_conducted_in.countries
        conductedCount = if country.conducted_count then "(#{country.conducted_count})" else ""
        <li key="country-item-#{i}" className="country-item">{country.name_abbreviation}{conductedCount}</li>
    <ul className="article-item-countries">{items}</ul>

  renderAuthorList: (authors) ->
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
    return unless @props.article.studies_conducted_in?.countries?.length > 0
    <div className="studies-conducted-in">
      {@renderCountryList()}
      {@renderRegionList()}
    </div>

  renderLinksList: (name, links)->
    return unless links?.length > 0
    items =
      for link, i in links
        <li key={"#{name}-#{i}"} className="#{name}-item">
          <a href={link.url} target="_blank">{link.title}</a>
        </li>
    <ul>{items}</ul>

  renderDomains: (domains) ->
    return unless domains
    for domain, i in domains
      <li key="domain-item-#{i}" className="domain-item">
        <span className="domain-item-title">{domain.title}:</span>
        {@renderDomains(domain.domains)}
      </li>

    <ul className="article-item-domain-list">
      {domains}
    </ul>

  renderDocumentSubTypes: ->
    sub_types = @props.article.document_type.sub_types
    if sub_types?.length > 0
      items =
        for sub_type, i in sub_types
          <li key="article-sub-type-#{i}" className="article-item-document-sub-type-item">{sub_type.title}</li>

      <ul className="article-item-document-sub-types">{items}</ul>

  renderTargets: ->
    if @props.article.targets?.length > 0
      <div className="article-item-targets">{@joinList(_.pluck(@props.article.targets, 'title'))}</div>

  render: ->
    article = @props.article

    # <ArticleField visible={article.related_documents_visible}>
    #   <h2>{@props.article.label_related_documents}</h2>
    #   <span dangerouslySetInnerHTML={__html: @ifNotEmpty @props.article.related_documents, @t('no_related_documents')}></span>
    # </ArticleField>

    # TODO: possibly use the description field
    # TODO: can be refactored to use @renderFields(['document_type', 'year_published', 'last_year_literature_searched', etc]) for each section
    # see more here: https://github.com/facebook/react/issues/5119#issuecomment-147112602
    <div className="article-item">
      <h1>{article.title}</h1>

      <div className="article-item-body">
        <div className="section">
          <ArticleField>
            <h2>{article.label_document_type}</h2>
            <ul className="article-item-document-type">
              <li key="article-item-document-type-main">{article.document_type.title}</li>
              <li key="article-item-document-type-sub-type">{@renderDocumentSubTypes()}</li>
            </ul>
          </ArticleField>

          <ArticleField visible={article.year_published_visible}>
            <h2>{article.label_year_published}</h2>
            {article.year_published}
          </ArticleField>

          <ArticleField visible={article.last_year_literature_searched_visible}>
            <h2>{article.label_last_year_literature_searched}</h2>
            {@ifNotEmpty article.last_year_literature_searched, @t('no_last_year_literature_searched')}
          </ArticleField>

          <ArticleField visible={article.quality_rating_visible}>
            <h2>{article.label_quality_rating}</h2>
            {article.quality} ({article.quality_note})
          </ArticleField>

          <ArticleField visible={article.countries_in_which_studies_were_conducted_visible}>
            <h2>{article.label_studies_conducted_in}</h2>
            {@ifNotEmpty @renderStudiesConductedIn(), @t('no_studies_conducted_in')}
          </ArticleField>

          <ArticleField visible={article.priority_area_visible}>
            <h2>{article.label_priority_areas}</h2>
            <ul>{@ifNotEmpty @renderNestedList(article.priority_areas, 'priority_areas', 'priority_area'), @t('no_priority_areas')}</ul>
          </ArticleField>
        </div>

        <div className="section">
          <ArticleField>
            <h2>{article.label_domains}</h2>
            <ul>{@ifNotEmpty @renderNestedList(article.domains, 'domains', 'domain'), @t('no_domains')}</ul>
          </ArticleField>

          <ArticleField>
            <h2>{article.label_health_system_topics}</h2>
            <ul>{@ifNotEmpty @renderNestedList(article.topics, 'topics', 'topic'), @t('no_topics')}</ul>
          </ArticleField>
        </div>

        <div className="section">
          <ArticleField visible={article.theme_visible}>
            <h2>{article.label_themes}</h2>
            <ul>{@ifNotEmpty @renderNestedList(article.themes, 'themes', 'theme'), @t('no_themes')}</ul>
          </ArticleField>

          <ArticleField visible={article.country_groupings_visible}>
            <h2>{article.label_country_groupings}</h2>
            {@ifNotEmpty article.country_groupings, @t('no_country_groupings')}
          </ArticleField>

          <ArticleField visible={article.who_region_visible}>
            <h2>{article.label_who_regions}</h2>
            {@ifNotEmpty @joinList(_.compact(_.pluck(article.who_regions, 'title'))), @t('no_who_regions')}
          </ArticleField>

          <ArticleField visible={article.lmic_focus_visible}>
            <h2>{article.label_lmic_focus}</h2>
            <div className="article-item-lmic-focus">
              {@ifNotEmpty @joinList(_.compact(_.pluck(article.lmic_focus, 'title'))), @t('no_lmic_focus')}
            </div>
          </ArticleField>

          <ArticleField visible={!article.country_focus_visible}>
            <h2>{article.label_country_focus}</h2>
            {@ifNotEmpty @joinList(_.compact(_.pluck(article.country_groups, 'title'))), @t('no_country_groupings')}
          </ArticleField>
        </div>

        <div className="desktop-sidebar">
          <div className="section">
            <ArticleField visible={article.summary_visible}>
              <h2>{article.label_summary}</h2>
              {@ifNotEmpty @renderLinksList('summary-link', article.summary_links), @t('no_summary_links')}
            </ArticleField>

            <ArticleField visible={article.scientific_abstract_visible}>
              <h2>{article.label_scientific_abstract}</h2>
              {@ifNotEmpty @renderLinksList('abstract-links', article.abstract_links), @t('no_scientific_abstract')}
            </ArticleField>

            <ArticleField visible={article.full_text_report_visible}>
              <h2>{article.label_full_text_report}</h2>
              {@ifNotEmpty @renderLinksList('full-text-report', article.full_text_link), @t('no_full_text_report')}
            </ArticleField>

            <ArticleField>
              <h2>{article.label_citation}</h2>
              {article.citation}
            </ArticleField>

            <ArticleField>
              <h2>{article.label_doi}</h2>
              {@ifNotEmpty article.doi, @t('no_doi')}
            </ArticleField>
          </div>

          <div className="section">
            <ArticleField>
              <h2>{article.label_question_type}</h2>
              {article.question_type}
            </ArticleField>

            <ArticleField>
              <h2>{article.label_focus}</h2>
              {@ifNotEmpty article.focus, @t('no_focus')}
            </ArticleField>

            <ArticleField>
              <h2>{article.label_targets}</h2>
              {@ifNotEmpty @renderTargets(), @t('no_targets')}
            </ArticleField>

            <ArticleField visible={article.author_email_visible}>
              <h2>{article.label_author_email}</h2>
              {@ifNotEmpty article.author_email, @t('no_author_email')}
            </ArticleField>

            <ArticleField visible={article.registry_record_visible}>
              <h2>{article.label_registry_record}</h2>
              {@ifNotEmpty article.label_registry_record, @t('no_registry_record_links')}
            </ArticleField>

            <ArticleField visible={article.who_links_visible}>
              <h2>{article.label_who_links}</h2>
              {@ifNotEmpty article.who_links, @t('no_who_links')}
            </ArticleField>
          </div>
        </div>
      </div>
    </div>
