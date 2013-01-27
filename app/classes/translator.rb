class Translator

  attr_accessor :target, :raw_data

  def translate(target, data, authorizer, coercer, options = {})
    nested_attributes_tranlator = options[:nested_attributes_tranlator] || Translators::NestedAtrributesTranslator.new
    @target = target
    @raw_data = data
    finalized_data = Hashie::Mash.new
    finalized_data.merge!( sanitize(@raw_data, authorizer, options) )
    finalized_data.merge!( nested_attributes_tranlator.translate(@target, @raw_data) )
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