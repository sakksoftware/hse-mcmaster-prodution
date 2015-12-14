module.exports =
  getDefaultProps: ->
    page: 1
    threshold: 250

  componentDidMount: ->
    @page ||= @props.page
    @scrollListener = _.throttle(@_scrollListener, 300)
    @attachScrollListener()

  componentDidUpdate: ->
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

  _scrollListener: ->
    el = @getDOMNode()
    scrollTop = if window.pageYOffset != undefined then window.pageYOffset else (document.documentElement or document.body.parentNode or document.body).scrollTop
    if topPosition(el) + el.offsetHeight - scrollTop - (window.innerHeight) < Number(@props.threshold)
      @detachScrollListener()
      # call loadMore after detachScrollListener to allow
      # for non-async loadMore functions
      @page = @page + 1
      @loadMore @page

# private
topPosition = (domElt) ->
  return 0 if !domElt
  domElt.offsetTop + topPosition(domElt.offsetParent)
