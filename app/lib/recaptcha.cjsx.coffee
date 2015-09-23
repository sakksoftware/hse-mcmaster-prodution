module.exports = React.createClass
  displayName: 'Recaptcha'
  propTypes:
    sitekey: React.PropTypes.string.isRequired
    className: React.PropTypes.string
    onloadCallbackName: React.PropTypes.string
    elementID: React.PropTypes.string
    onloadCallback: React.PropTypes.func
    verifyCallback: React.PropTypes.func

  getDefaultProps: ->
    elementID: 'g-recaptcha'
    onloadCallback: null
    verifyCallback: null
    render: 'onload'
    theme: 'light'
    type: 'image'

  componentDidMount: ->
    @grecaptchaId = grecaptcha.render @props.elementID,
      sitekey: @props.sitekey
      callback: if @props.verifyCallback then @props.verifyCallback else undefined
      theme: @props.theme
      type: @props.type

    _.delay((=>
      $(@getDOMNode()).find('.g-recaptcha-response').attr('name', 'captcha')
    ), 200)

  componentWillUnmount: ->
    console.log("resetting ", @grecaptchaId)
    grecaptcha.reset(@grecaptchaId)

  render: ->


    <div id={this.props.elementID} className="g-recaptcha">
    </div>
