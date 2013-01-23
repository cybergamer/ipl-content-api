module Events
  module Data
    class Handler

      attr_accessor :raw_data, :sanitized_data, :nested_data

      def handle(data, options = {})
        @raw_data = data
        @sanitized_data = sanitize(@raw_data, options)
        coerce(@sanitized_data.merge(@nested_data), options)
      end

      def sanitize(data, options = {})
        sanitizer = options[:sanitizer] || Events::Data::Sanitizer.new(self)
        authorizer = options[:authorizer] || Event.accessible_attributes
        sanitizer.sanitize(data, authorizer)
      end

      def coerce(data, options = {})
        coercer = options[:coercer] || Events::DataHash
        coercer.new(data)
      end

      def process_removed_attributes(attrs)
        @nested_data = Hashie::Mash.new
        @nested_data[:matchup_attributes] = Matchups::Data::Handler.new.handle( @raw_data.matchup ) if @raw_data.matchup?
      end

    end
  end
end