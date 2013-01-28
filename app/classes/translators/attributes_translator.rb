module Translators
  class AttributesTranslator

    def mappings
      mappings = {'_id' => 'id'}
    end

    def translate(attributes)
      Hash[attributes.map {|k, v| [mappings[k] || k, v] }].keys
    end

  end
end