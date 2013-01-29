class Builder

  def build(klass, data, coercer, options = {})
    translator = options[:translator] || Translator.new
    authorizer = options[:authorizer] || authorizer(klass.accessible_attributes)
    translated_data = translator.translate(klass, data, authorizer, coercer, options)
    klass.new(translated_data)
  end

  def authorizer(attributes, options = {})
    attributes_translator = options[:attributes_translator] || Translators::AttributesTranslator.new
    whitelist = options[:whitelist] || ActiveModel::MassAssignmentSecurity::WhiteList
    whitelist.new(attributes_translator.translate(attributes))
  end

end