module Queries
  module Options
    class SortOptionMapper

      ASCENDING = "asc"
      DESCENDING = "desc"

      def to_option(options = {})
        sortBy = options[:sortBy] || nil
        sortDirection = options[:sortDirection] || ASCENDING
        {:sort => to_field_and_direction(sortBy, sortDirection)} if sortBy and sortDirection
      end

      def to_field_and_direction(field, direction)
        [[field.underscore.to_sym, (direction == DESCENDING) ? Mongo::DESCENDING : Mongo::ASCENDING]]
      end

    end
  end
end