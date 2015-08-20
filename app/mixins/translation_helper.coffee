module.exports =
  t: (key) ->
    unless @baseTranslation
      throw("missing base translation! You must specify the base path of the translation to use the translation mixin!")
    $.t("#{@baseTranslation}.#{key}")
