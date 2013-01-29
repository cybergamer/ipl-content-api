module Queries
  module Options
    class FieldsOptionMapper

      def to_option(options = {})
        fields = options[:fields] || nil
        values = fields ? fields.split(',') : nil
        if values and values.size > 0
          {:fields => to_fields(values)}
        else
          {}
        end
      end

      def to_fields(values)
        Hash[( values.collect { |field| [field.to_sym, 1] } )].merge({:_type => 1})
      end

    end
  end
end