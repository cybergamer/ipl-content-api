class Updater

  def update(target, data, coercer, options = {})
    translator = options[:translator] || Translator.new
    authorizer = options[:authorizer] || authorizer(target.class.accessible_attributes)
    result = target.update_attributes(translator.translate(target, data, authorizer, coercer, options))
    [result, target.errors.messages]
  end

  def authorizer(attributes)
    ActiveModel::MassAssignmentSecurity::WhiteList.new(Translators::AttributesTranslator.new.translate(attributes))
  end

end