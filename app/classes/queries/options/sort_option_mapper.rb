module Queries
  module Options
    class SortOptionMapper

      ASCENDING = "asc"
      DESCENDING = "desc"

      def to_option(options_result, options = {})
        sortBy = options[:sortBy] || nil
        sortDirection = options[:sortDirection] || ASCENDING
        options_result.merge!({:sort => to_field_and_direction(sortBy, sortDirection)}) if sortBy and sortDirection
        options_result
      end

      def to_field_and_direction(field, direction)
        [[field.underscore.to_sym, (direction == DESCENDING) ? Mongo::DESCENDING : Mongo::ASCENDING]]
      end

    end
  end
end