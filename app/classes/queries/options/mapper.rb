module Queries
  module Options
    class Mapper

      def to_options(klass, options = {})
        result = options[:result] || Hash.new
        options.symbolize_keys!
        sort_options_mapper = options[:sort_options_mapper] || Queries::Options::SortOptionMapper.new
        fields_options_mapper = options[:fields_options_mapper] || Queries::Options::FieldsOptionMapper.new
        [sort_options_mapper, fields_options_mapper].each do |mapper|
          result.merge!( mapper.to_option(options) )
        end
        result
      end

    end
  end
end