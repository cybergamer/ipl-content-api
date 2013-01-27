module Translators
  class NestedAtrributesTranslator

    attr_accessor :target, :raw_data, :finalized_data

    def translate(target, data)
      @target = target
      @raw_data = data
      @finalized_data = Hashie::Mash.new
      translate_nested(@target.nested_attributes)
      @finalized_data
    end

    def translate_nested(attributes)
      attributes_bases(attributes).each do |attribute|
        if singular?(attribute)
          translate_singular_nested_attribute(attribute)
        else
          translate_plural_nested_attribute(attribute)
        end
      end
    end

    def attributes_bases(attributes)
      attributes.collect { |e| Regexp.new('(?<attr_name>.*)_attributes=').match(e)[:attr_name] }
    end

    def singular?(s)
      !(s == s.pluralize)
    end

    def translate_singular_nested_attribute(attribute)
      nested_attribute_id = [attribute, 'id'].join("_")
      @finalized_data[nested_attribute_id] = @raw_data[attribute].id if @raw_data.send("#{attribute}?".to_sym)
    end

    def translate_plural_nested_attribute(attribute)
      nested_attribute_ids = [attribute.singularize, 'ids'].join("_")
      @finalized_data[ nested_attribute_ids ] = @raw_data[attribute].collect { |e| e.id } if @raw_data.send("#{attribute}?".to_sym)
    end

  end
end