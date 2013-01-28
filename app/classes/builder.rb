class Builder

  def build(klass, data, coercer, options = {})
    translator = options[:translator] || Translator.new
    authorizer = options[:authorizer] || authorizer(klass.accessible_attributes)
    translated_data = translator.translate(klass, data, authorizer, coercer, options)
    klass.new(translated_data)
  end

  def authorizer(attributes)
    ActiveModel::MassAssignmentSecurity::WhiteList.new(Translators::AttributesTranslator.new.translate(attributes))
  end

end