module.exports =
  getDefaultProps: ->
    page: 1
    threshold: 250

  componentDidMount: ->
    @page ||= @props.page
    @attachScrollListener()

  componentDidUpdate: (prevProps, prevState) ->
    # no need to attach listen unless number of results changed
    # in other words, we still didn't get a chance to update the number of
    # results displayed on the screen, we probably updated something else (e.g. showing a spinner)
    if prevProps.results.length != @props.results.length
      @attachScrollListener()

  attachScrollListener: ->
    return if !@hasMore()

    window.addEventListener 'scroll', @scrollListener
    window.addEventListener 'resize', @scrollListener
    @scrollListener()

  detachScrollListener: ->
    window.removeEventListener 'scroll', @scrollListener
    window.removeEventListener 'resize', @scrollListener

  componentWillUnmount: ->
    @detachScrollListener()

  scrollListener: ->
    el = @getDOMNode()
    scrollTop = if window.pageYOffset != undefined then window.pageYOffset else (document.documentElement or document.body.parentNode or document.body).scrollTop
    # TODO: review this logic
    if topPosition(el) + el.offsetHeight - scrollTop - (window.innerHeight) < Number(@props.threshold)
      @detachScrollListener()
      # call loadMore after detachScrollListener to allow
      # for non-async loadMore functions
      @page = @page + 1
      @_loadMore @page

  # limit how many times we check if we are at the end of the page. We
  # don't want to call loadMore twice in a row before waiting for the other
  # one to finish
  _loadMore: _.throttle ((page) -> @loadMore(page)), 300

# private
topPosition = (domElt) ->
  return 0 if !domElt
  domElt.offsetTop + topPosition(domElt.offsetParent)
