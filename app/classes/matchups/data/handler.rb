module Matchups
  module Data
    class Handler

      attr_accessor :raw_data, :sanitized_data, :nested_data

      def handle(data, options = {})
        @raw_data = data
        @sanitized_data = sanitize(@raw_data, options)
        coerce(@sanitized_data.merge(@nested_data), options)
      end

      def sanitize(data, options = {})
        sanitizer = options[:sanitizer] || Matchups::Data::Sanitizer.new(self)
        authorizer = options[:authorizer] || Matchup.accessible_attributes
        sanitizer.sanitize(data, authorizer)
      end

      def coerce(data, options = {})
        coercer = options[:coercer] || Matchups::DataHash
        coercer.new(data)
      end

      def process_removed_attributes(attrs)
        @nested_data = Hashie::Mash.new
        nested = Matchup.nested_attributes.collect { |e| Regexp.new('(?<attr_name>.*)_attributes=').match(e)[:attr_name] }
        attrs.reject { |e| !nested.include?(e) }.each do |attribute|
          nested_attribute = [attribute.singularize,"ids"].join("_")
          @nested_data[ nested_attribute ] = @raw_data[attribute].collect { |e| e.id } if @raw_data.send("#{attribute}?".to_sym)
        end
      end

    end
  end
end