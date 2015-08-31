module.exports =
  t: (key, args...) ->
    if @baseTranslation is undefined
      throw("missing base translation! You must specify the base path of the translation to use the translation mixin!")

    prefix = ""
    prefix = "#{@baseTranslation}." if @baseTranslation != ""
    # if key contains absoulte path
    if key.match(/^\//)
      prefix = ""
      key = key.replace(/^\//, '')
    $.t("#{prefix}#{key}", args)
