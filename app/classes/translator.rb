class Translator

  attr_accessor :target, :raw_data

  def translate(target, data, authorizer, coercer, options = {})
    nested_attributes_translator = options[:nested_attributes_translator] || Translators::NestedAtrributesTranslator.new
    finalized_data = options[:finalized_data] || Hashie::Mash.new
    @target = target
    @raw_data = data
    finalized_data.merge!( sanitize(@raw_data, authorizer, options) )
    finalized_data.merge!( nested_attributes_translator.translate(@target, @raw_data) )
    coercer.new(finalized_data)
  end

  def sanitize(data, authorizer, options = {})
    sanitizer = options[:sanitizer] || Sanitizer.new(self)
    sanitizer.sanitize(data, authorizer)
  end

  def process_removed_attributes(attrs)
    # delegated from sanitizer
  end

end