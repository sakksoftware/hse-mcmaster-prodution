module.exports =
  t: (key, args...) ->
    if @baseTranslation is undefined
      throw("missing base translation! You must specify the base path of the translation to use the translation mixin!")

    prefix = ""
    prefix = "#{@baseTranslation}." if @baseTranslation != ""
    $.t("#{prefix}#{key}", args)
