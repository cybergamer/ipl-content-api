class Authorizer

  def initialize(attributes, options = {})
    list = options[:list] || ActiveModel::MassAssignmentSecurity::WhiteList
    attributes_translator = options[:attributes_translator] || Translators::AttributesTranslator.new
    list.new(attributes_translator.translate(attributes))
  end

end