module Queries
  module Options
    class Mapper

      def to_options(klass, options = {})
        options.symbolize_keys!
        sort_options_mapper = options[:sort_options_mapper] || Queries::Options::SortOptionMapper.new
        fields_options_mapper = options[:fields_options_mapper] || Queries::Options::FieldsOptionMapper.new
        result = Hash.new
        [sort_options_mapper, fields_options_mapper].each do |mapper|
          result = mapper.to_option(result, options)
        end
        result
      end

    end
  end
end