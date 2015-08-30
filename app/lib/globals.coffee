module.exports = ->
  window.flash = (type='info', msg) ->
    type = 'danger' if type == 'error'
    $html = $("""
      <div class="alert alert-#{type} alert-dismissible" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <span>#{msg}</span>
      </div>
      """)
    $html.alert()
    $('body > .alert').remove()
    $('body').prepend($html)
