module.exports = React.createClass
  displayName: 'Recaptcha'
  propTypes:
    sitekey: React.PropTypes.string.isRequired
    className: React.PropTypes.string
    onloadCallbackName: React.PropTypes.string
    elementId: React.PropTypes.string
    onloadCallback: React.PropTypes.func
    verifyCallback: React.PropTypes.func

  getDefaultProps: ->
    elementId: 'g-recaptcha'
    onloadCallback: null
    verifyCallback: null
    render: 'onload'
    theme: 'light'
    type: 'image'

  componentDidMount: ->
    if window.recaptcha == undefined
      window.grecaptchaCallback = => @renderRecaptcha()
      $.getScript("https://www.google.com/recaptcha/api.js?&render=explicit&onload=grecaptchaCallback")
    else
      @renderRecaptcha()

  renderRecaptcha: ->
    @grecaptchaId = grecaptcha.render @props.elementId,
      sitekey: @props.sitekey
      callback: if @props.verifyCallback then @props.verifyCallback else undefined
      theme: @props.theme
      type: @props.type
    $(@getDOMNode()).find('.g-recaptcha-response').attr('name', 'captcha')

  componentWillUnmount: ->
    grecaptcha.reset(@grecaptchaId)
    window.grecaptchaCallback = (->)

  render: ->
    <div id={this.props.elementId} className="g-recaptcha">
    </div>
